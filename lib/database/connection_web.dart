import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

QueryExecutor openCarStoreConnection() {
  return driftDatabase(name: 'car_store');
}

QueryExecutor openCarStoreMemoryConnection() {
  throw UnsupportedError('In-memory Drift is only used by native tests.');
}
