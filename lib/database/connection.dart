import 'package:drift/drift.dart';

import 'connection_stub.dart'
    if (dart.library.io) 'connection_native.dart'
    if (dart.library.js_interop) 'connection_web.dart'
    as impl;

QueryExecutor openCarStoreConnection() {
  return impl.openCarStoreConnection();
}

QueryExecutor openCarStoreMemoryConnection() {
  return impl.openCarStoreMemoryConnection();
}
