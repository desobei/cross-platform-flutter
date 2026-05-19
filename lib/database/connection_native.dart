import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openCarStoreConnection() {
  return driftDatabase(name: 'car_store');
}

QueryExecutor openCarStoreMemoryConnection() {
  return NativeDatabase.memory();
}
