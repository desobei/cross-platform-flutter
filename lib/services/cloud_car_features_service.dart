import 'dart:async';

import '../models/car_feedback.dart';
import '../models/car_store_models.dart';

abstract class CloudCarFeaturesService {
  Future<void> saveFavoriteCar(String carId);

  Future<void> deleteFavoriteCar(String carId);

  Future<void> saveOrder(PurchaseOrder order);

  Stream<List<CarFeedback>> watchFeedback(String carId);

  Future<void> sendFeedback({required String carId, required String text});

  void dispose() {}
}

class LocalCloudCarFeaturesService extends CloudCarFeaturesService {
  final Map<String, List<CarFeedback>> _feedbackByCarId = <String, List<CarFeedback>>{};
  final Set<String> favoriteCarIds = <String>{};
  final List<PurchaseOrder> syncedOrders = <PurchaseOrder>[];
  final Map<String, StreamController<List<CarFeedback>>> _controllers =
      <String, StreamController<List<CarFeedback>>>{};

  @override
  Future<void> saveFavoriteCar(String carId) async {
    favoriteCarIds.add(carId);
  }

  @override
  Future<void> deleteFavoriteCar(String carId) async {
    favoriteCarIds.remove(carId);
  }

  @override
  Future<void> saveOrder(PurchaseOrder order) async {
    syncedOrders.removeWhere((savedOrder) => savedOrder.id == order.id);
    syncedOrders.insert(0, order);
  }

  @override
  Stream<List<CarFeedback>> watchFeedback(String carId) async* {
    yield List<CarFeedback>.unmodifiable(_feedbackByCarId[carId] ?? const []);
    yield* _controllerFor(carId).stream;
  }

  @override
  Future<void> sendFeedback({required String carId, required String text}) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }
    final items = _feedbackByCarId.putIfAbsent(carId, () => <CarFeedback>[]);
    items.insert(
      0,
      CarFeedback(
        id: 'local-${DateTime.now().microsecondsSinceEpoch}',
        carId: carId,
        text: trimmed,
        driverName: 'Local Driver',
        userId: 'local-driver',
        createdAt: DateTime.now(),
      ),
    );
    _controllerFor(carId).add(List<CarFeedback>.unmodifiable(items));
  }

  StreamController<List<CarFeedback>> _controllerFor(String carId) {
    return _controllers.putIfAbsent(
      carId,
      () => StreamController<List<CarFeedback>>.broadcast(),
    );
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.close();
    }
  }
}
