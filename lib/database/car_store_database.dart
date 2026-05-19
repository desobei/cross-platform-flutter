import 'package:drift/drift.dart';

import 'connection.dart';

part 'car_store_database.g.dart';

class FavoriteCars extends Table {
  TextColumn get carId => text()();

  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {carId};
}

class DbReservationItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get carId => text()();

  TextColumn get packageName => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class DbPurchaseOrders extends Table {
  TextColumn get id => text()();

  TextColumn get customerName => text()();

  IntColumn get mode => integer()();

  TextColumn get pickupDateLabel => text()();

  TextColumn get status => text()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DbPurchaseOrderItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get orderId => text().references(DbPurchaseOrders, #id)();

  TextColumn get carId => text()();

  TextColumn get packageName => text()();

  IntColumn get position => integer()();
}

@DriftDatabase(
  tables: [
    FavoriteCars,
    DbReservationItems,
    DbPurchaseOrders,
    DbPurchaseOrderItems,
  ],
  daos: [FavoriteCarDao, ReservationDao, PurchaseOrderDao],
)
class CarStoreDatabase extends _$CarStoreDatabase {
  CarStoreDatabase([QueryExecutor? executor])
    : super(executor ?? openCarStoreConnection());

  CarStoreDatabase.memory() : super(openCarStoreMemoryConnection());

  @override
  int get schemaVersion => 1;
}

@DriftAccessor(tables: [FavoriteCars])
class FavoriteCarDao extends DatabaseAccessor<CarStoreDatabase>
    with _$FavoriteCarDaoMixin {
  FavoriteCarDao(super.db);

  Future<List<FavoriteCar>> findAllFavoriteCars() {
    return (select(
      favoriteCars,
    )..orderBy([(table) => OrderingTerm.desc(table.savedAt)])).get();
  }

  Future<void> insertFavoriteCar(String carId) {
    return into(
      favoriteCars,
    ).insertOnConflictUpdate(FavoriteCarsCompanion.insert(carId: carId));
  }

  Future<int> deleteFavoriteCar(String carId) {
    return (delete(
      favoriteCars,
    )..where((table) => table.carId.equals(carId))).go();
  }

  Future<int> clearFavoriteCars() {
    return delete(favoriteCars).go();
  }
}

@DriftAccessor(tables: [DbReservationItems])
class ReservationDao extends DatabaseAccessor<CarStoreDatabase>
    with _$ReservationDaoMixin {
  ReservationDao(super.db);

  Future<List<DbReservationItem>> findAllReservationItems() {
    return (select(
      dbReservationItems,
    )..orderBy([(table) => OrderingTerm.asc(table.createdAt)])).get();
  }

  Future<int> insertReservationItem({
    required String carId,
    required String packageName,
  }) {
    return into(dbReservationItems).insert(
      DbReservationItemsCompanion.insert(
        carId: carId,
        packageName: packageName,
      ),
    );
  }

  Future<int> deleteReservationItem(int id) {
    return (delete(
      dbReservationItems,
    )..where((table) => table.id.equals(id))).go();
  }

  Future<int> clearReservationItems() {
    return delete(dbReservationItems).go();
  }
}

@DriftAccessor(tables: [DbPurchaseOrders, DbPurchaseOrderItems])
class PurchaseOrderDao extends DatabaseAccessor<CarStoreDatabase>
    with _$PurchaseOrderDaoMixin {
  PurchaseOrderDao(super.db);

  Future<List<DbPurchaseOrder>> findAllOrders() {
    return (select(
      dbPurchaseOrders,
    )..orderBy([(table) => OrderingTerm.desc(table.createdAt)])).get();
  }

  Future<List<DbPurchaseOrderItem>> findOrderItems(String orderId) {
    return (select(dbPurchaseOrderItems)
          ..where((table) => table.orderId.equals(orderId))
          ..orderBy([(table) => OrderingTerm.asc(table.position)]))
        .get();
  }

  Future<void> insertOrderWithItems({
    required DbPurchaseOrdersCompanion order,
    required List<DbPurchaseOrderItemsCompanion> items,
  }) {
    return transaction(() async {
      await into(dbPurchaseOrders).insertOnConflictUpdate(order);
      await (delete(
        dbPurchaseOrderItems,
      )..where((table) => table.orderId.equals(order.id.value))).go();
      await batch((batch) {
        batch.insertAll(dbPurchaseOrderItems, items);
      });
    });
  }

  Future<int> clearOrders() {
    return delete(dbPurchaseOrders).go();
  }
}
