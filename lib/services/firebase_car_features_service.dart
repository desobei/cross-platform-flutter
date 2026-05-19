import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/car_feedback.dart';
import '../models/car_store_models.dart';
import 'cloud_car_features_service.dart';

class FirebaseCarFeaturesService extends CloudCarFeaturesService {
  FirebaseCarFeaturesService({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  CollectionReference<Object?> get _favorites =>
      _firestore.collection('cloudFavoriteCars');
  CollectionReference<Object?> get _orders =>
      _firestore.collection('cloudOrderHistory');
  CollectionReference<Object?> get _feedback => _firestore.collection('carFeedback');

  @override
  Future<void> saveFavoriteCar(String carId) async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    await _favorites.doc('${user.uid}_$carId').set(<String, Object?>{
      'userId': user.uid,
      'carId': carId,
      'savedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> deleteFavoriteCar(String carId) async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    await _favorites.doc('${user.uid}_$carId').delete();
  }

  @override
  Future<void> saveOrder(PurchaseOrder order) async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    await _orders.doc(order.id).set(<String, Object?>{
      'userId': user.uid,
      'customerName': order.customerName,
      'mode': order.mode.name,
      'pickupDateLabel': order.pickupDateLabel,
      'status': order.status,
      'createdAt': FieldValue.serverTimestamp(),
      'items': order.items
          .map(
            (item) => <String, Object?>{
              'carId': item.car.id,
              'title': item.car.title,
              'packageName': item.packageName,
              'price': item.car.price,
            },
          )
          .toList(growable: false),
    });
  }

  @override
  Stream<List<CarFeedback>> watchFeedback(String carId) {
    return _feedback
        .where('carId', isEqualTo: carId)
        .orderBy('createdAt', descending: true)
        .limit(20)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(CarFeedback.fromSnapshot)
              .where((feedback) => feedback.text.trim().isNotEmpty)
              .toList(growable: false);
        });
  }

  @override
  Future<void> sendFeedback({required String carId, required String text}) async {
    final trimmed = text.trim();
    final user = _auth.currentUser;
    if (trimmed.isEmpty || user == null) {
      return;
    }
    await _feedback.add(
      CarFeedback(
        id: '',
        carId: carId,
        text: trimmed,
        driverName: _displayName(user),
        userId: user.uid,
        createdAt: DateTime.now(),
      ).toJson(),
    );
  }

  String _displayName(User user) {
    final displayName = user.displayName;
    if (displayName != null && displayName.trim().isNotEmpty) {
      return displayName.trim();
    }
    final email = user.email;
    if (email != null && email.trim().isNotEmpty) {
      return email.split('@').first;
    }
    return 'Driver';
  }
}
