import 'package:cloud_firestore/cloud_firestore.dart';

class CarFeedback {
  const CarFeedback({
    required this.id,
    required this.carId,
    required this.text,
    required this.driverName,
    required this.userId,
    required this.createdAt,
  });

  final String id;
  final String carId;
  final String text;
  final String driverName;
  final String userId;
  final DateTime createdAt;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'carId': carId,
      'text': text,
      'driverName': driverName,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  static CarFeedback fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    final data = snapshot.data();
    final map = data is Map<String, Object?> ? data : <String, Object?>{};
    final timestamp = map['createdAt'];
    return CarFeedback(
      id: snapshot.id,
      carId: map['carId']?.toString() ?? '',
      text: map['text']?.toString() ?? '',
      driverName: map['driverName']?.toString() ?? 'Driver',
      userId: map['userId']?.toString() ?? '',
      createdAt: timestamp is Timestamp ? timestamp.toDate() : DateTime.now(),
    );
  }
}
