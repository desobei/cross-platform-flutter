import '../database/car_store_database.dart';
import '../models/car_store_models.dart';
import 'car_store_repository.dart';

class CarStoreLocalRepository {
  CarStoreLocalRepository(this._database);

  CarStoreLocalRepository.memoryFallback() : _database = null;

  final CarStoreDatabase? _database;
  final Set<String> _memoryFavoriteCarIds = <String>{};
  final List<ReservationItem> _memoryReservationItems = <ReservationItem>[];
  final List<PurchaseOrder> _memoryOrders = <PurchaseOrder>[];

  Future<Set<String>> findFavoriteCarIds() async {
    final database = _database;
    if (database == null) {
      return Set<String>.from(_memoryFavoriteCarIds);
    }

    final rows = await database.favoriteCarDao.findAllFavoriteCars();
    return rows.map((row) => row.carId).toSet();
  }

  Future<List<ReservationItem>> findReservationItems() async {
    final database = _database;
    if (database == null) {
      return List<ReservationItem>.from(_memoryReservationItems);
    }

    final rows = await database.reservationDao.findAllReservationItems();
    final items = <ReservationItem>[];

    for (final row in rows) {
      final car = _carByIdOrNull(row.carId);
      if (car != null) {
        items.add(ReservationItem(car: car, packageName: row.packageName));
      }
    }

    return items;
  }

  Future<List<PurchaseOrder>> findOrders() async {
    final database = _database;
    if (database == null) {
      return List<PurchaseOrder>.from(_memoryOrders);
    }

    final orderRows = await database.purchaseOrderDao.findAllOrders();
    final orders = <PurchaseOrder>[];

    for (final orderRow in orderRows) {
      final itemRows = await database.purchaseOrderDao.findOrderItems(
        orderRow.id,
      );
      final items = <ReservationItem>[];

      for (final itemRow in itemRows) {
        final car = _carByIdOrNull(itemRow.carId);
        if (car != null) {
          items.add(
            ReservationItem(car: car, packageName: itemRow.packageName),
          );
        }
      }

      final modeIndex = orderRow.mode;
      orders.add(
        PurchaseOrder(
          id: orderRow.id,
          customerName: orderRow.customerName,
          mode: modeIndex >= 0 && modeIndex < ReservationMode.values.length
              ? ReservationMode.values[modeIndex]
              : ReservationMode.showroomPickup,
          pickupDateLabel: orderRow.pickupDateLabel,
          items: items,
          status: orderRow.status,
        ),
      );
    }

    return orders;
  }

  Future<void> saveFavoriteCar(String carId) async {
    final database = _database;
    if (database == null) {
      _memoryFavoriteCarIds.add(carId);
      return;
    }

    await database.favoriteCarDao.insertFavoriteCar(carId);
  }

  Future<void> deleteFavoriteCar(String carId) async {
    final database = _database;
    if (database == null) {
      _memoryFavoriteCarIds.remove(carId);
      return;
    }

    await database.favoriteCarDao.deleteFavoriteCar(carId);
  }

  Future<void> clearFavoriteCars() async {
    final database = _database;
    if (database == null) {
      _memoryFavoriteCarIds.clear();
      return;
    }

    await database.favoriteCarDao.clearFavoriteCars();
  }

  Future<void> saveReservationItem(ReservationItem item) async {
    final database = _database;
    if (database == null) {
      _memoryReservationItems.add(item);
      return;
    }

    await database.reservationDao.insertReservationItem(
      carId: item.car.id,
      packageName: item.packageName,
    );
  }

  Future<void> replaceReservationItems(List<ReservationItem> items) async {
    final database = _database;
    if (database == null) {
      _memoryReservationItems
        ..clear()
        ..addAll(items);
      return;
    }

    await database.transaction(() async {
      await database.reservationDao.clearReservationItems();
      for (final item in items) {
        await database.reservationDao.insertReservationItem(
          carId: item.car.id,
          packageName: item.packageName,
        );
      }
    });
  }

  Future<void> clearReservationItems() async {
    final database = _database;
    if (database == null) {
      _memoryReservationItems.clear();
      return;
    }

    await database.reservationDao.clearReservationItems();
  }

  Future<void> saveOrder(PurchaseOrder order) async {
    final database = _database;
    if (database == null) {
      _memoryOrders.removeWhere((savedOrder) => savedOrder.id == order.id);
      _memoryOrders.insert(0, order);
      return;
    }

    await database.purchaseOrderDao.insertOrderWithItems(
      order: DbPurchaseOrdersCompanion.insert(
        id: order.id,
        customerName: order.customerName,
        mode: order.mode.index,
        pickupDateLabel: order.pickupDateLabel,
        status: order.status,
      ),
      items: [
        for (var index = 0; index < order.items.length; index += 1)
          DbPurchaseOrderItemsCompanion.insert(
            orderId: order.id,
            carId: order.items[index].car.id,
            packageName: order.items[index].packageName,
            position: index,
          ),
      ],
    );
  }

  Future<void> close() async {
    await _database?.close();
  }

  CarListing? _carByIdOrNull(String carId) {
    try {
      return CarStoreRepository.carById(carId);
    } catch (_) {
      return null;
    }
  }
}
