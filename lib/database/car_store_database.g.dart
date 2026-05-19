// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_store_database.dart';

// ignore_for_file: type=lint
class $FavoriteCarsTable extends FavoriteCars
    with TableInfo<$FavoriteCarsTable, FavoriteCar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteCarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<String> carId = GeneratedColumn<String>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [carId, savedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_cars';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteCar> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {carId};
  @override
  FavoriteCar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteCar(
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}car_id'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $FavoriteCarsTable createAlias(String alias) {
    return $FavoriteCarsTable(attachedDatabase, alias);
  }
}

class FavoriteCar extends DataClass implements Insertable<FavoriteCar> {
  final String carId;
  final DateTime savedAt;
  const FavoriteCar({required this.carId, required this.savedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['car_id'] = Variable<String>(carId);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  FavoriteCarsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCarsCompanion(carId: Value(carId), savedAt: Value(savedAt));
  }

  factory FavoriteCar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteCar(
      carId: serializer.fromJson<String>(json['carId']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'carId': serializer.toJson<String>(carId),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  FavoriteCar copyWith({String? carId, DateTime? savedAt}) =>
      FavoriteCar(carId: carId ?? this.carId, savedAt: savedAt ?? this.savedAt);
  FavoriteCar copyWithCompanion(FavoriteCarsCompanion data) {
    return FavoriteCar(
      carId: data.carId.present ? data.carId.value : this.carId,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCar(')
          ..write('carId: $carId, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(carId, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteCar &&
          other.carId == this.carId &&
          other.savedAt == this.savedAt);
}

class FavoriteCarsCompanion extends UpdateCompanion<FavoriteCar> {
  final Value<String> carId;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const FavoriteCarsCompanion({
    this.carId = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteCarsCompanion.insert({
    required String carId,
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : carId = Value(carId);
  static Insertable<FavoriteCar> custom({
    Expression<String>? carId,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (carId != null) 'car_id': carId,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteCarsCompanion copyWith({
    Value<String>? carId,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return FavoriteCarsCompanion(
      carId: carId ?? this.carId,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (carId.present) {
      map['car_id'] = Variable<String>(carId.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCarsCompanion(')
          ..write('carId: $carId, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbReservationItemsTable extends DbReservationItems
    with TableInfo<$DbReservationItemsTable, DbReservationItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbReservationItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<String> carId = GeneratedColumn<String>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, carId, packageName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_reservation_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbReservationItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbReservationItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbReservationItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}car_id'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DbReservationItemsTable createAlias(String alias) {
    return $DbReservationItemsTable(attachedDatabase, alias);
  }
}

class DbReservationItem extends DataClass
    implements Insertable<DbReservationItem> {
  final int id;
  final String carId;
  final String packageName;
  final DateTime createdAt;
  const DbReservationItem({
    required this.id,
    required this.carId,
    required this.packageName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_id'] = Variable<String>(carId);
    map['package_name'] = Variable<String>(packageName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbReservationItemsCompanion toCompanion(bool nullToAbsent) {
    return DbReservationItemsCompanion(
      id: Value(id),
      carId: Value(carId),
      packageName: Value(packageName),
      createdAt: Value(createdAt),
    );
  }

  factory DbReservationItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbReservationItem(
      id: serializer.fromJson<int>(json['id']),
      carId: serializer.fromJson<String>(json['carId']),
      packageName: serializer.fromJson<String>(json['packageName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carId': serializer.toJson<String>(carId),
      'packageName': serializer.toJson<String>(packageName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbReservationItem copyWith({
    int? id,
    String? carId,
    String? packageName,
    DateTime? createdAt,
  }) => DbReservationItem(
    id: id ?? this.id,
    carId: carId ?? this.carId,
    packageName: packageName ?? this.packageName,
    createdAt: createdAt ?? this.createdAt,
  );
  DbReservationItem copyWithCompanion(DbReservationItemsCompanion data) {
    return DbReservationItem(
      id: data.id.present ? data.id.value : this.id,
      carId: data.carId.present ? data.carId.value : this.carId,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbReservationItem(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('packageName: $packageName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, carId, packageName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbReservationItem &&
          other.id == this.id &&
          other.carId == this.carId &&
          other.packageName == this.packageName &&
          other.createdAt == this.createdAt);
}

class DbReservationItemsCompanion extends UpdateCompanion<DbReservationItem> {
  final Value<int> id;
  final Value<String> carId;
  final Value<String> packageName;
  final Value<DateTime> createdAt;
  const DbReservationItemsCompanion({
    this.id = const Value.absent(),
    this.carId = const Value.absent(),
    this.packageName = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbReservationItemsCompanion.insert({
    this.id = const Value.absent(),
    required String carId,
    required String packageName,
    this.createdAt = const Value.absent(),
  }) : carId = Value(carId),
       packageName = Value(packageName);
  static Insertable<DbReservationItem> custom({
    Expression<int>? id,
    Expression<String>? carId,
    Expression<String>? packageName,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carId != null) 'car_id': carId,
      if (packageName != null) 'package_name': packageName,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbReservationItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? carId,
    Value<String>? packageName,
    Value<DateTime>? createdAt,
  }) {
    return DbReservationItemsCompanion(
      id: id ?? this.id,
      carId: carId ?? this.carId,
      packageName: packageName ?? this.packageName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<String>(carId.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbReservationItemsCompanion(')
          ..write('id: $id, ')
          ..write('carId: $carId, ')
          ..write('packageName: $packageName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbPurchaseOrdersTable extends DbPurchaseOrders
    with TableInfo<$DbPurchaseOrdersTable, DbPurchaseOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbPurchaseOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<int> mode = GeneratedColumn<int>(
    'mode',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pickupDateLabelMeta = const VerificationMeta(
    'pickupDateLabel',
  );
  @override
  late final GeneratedColumn<String> pickupDateLabel = GeneratedColumn<String>(
    'pickup_date_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerName,
    mode,
    pickupDateLabel,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_purchase_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbPurchaseOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
        _modeMeta,
        mode.isAcceptableOrUnknown(data['mode']!, _modeMeta),
      );
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('pickup_date_label')) {
      context.handle(
        _pickupDateLabelMeta,
        pickupDateLabel.isAcceptableOrUnknown(
          data['pickup_date_label']!,
          _pickupDateLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pickupDateLabelMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbPurchaseOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbPurchaseOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      mode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mode'],
      )!,
      pickupDateLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pickup_date_label'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DbPurchaseOrdersTable createAlias(String alias) {
    return $DbPurchaseOrdersTable(attachedDatabase, alias);
  }
}

class DbPurchaseOrder extends DataClass implements Insertable<DbPurchaseOrder> {
  final String id;
  final String customerName;
  final int mode;
  final String pickupDateLabel;
  final String status;
  final DateTime createdAt;
  const DbPurchaseOrder({
    required this.id,
    required this.customerName,
    required this.mode,
    required this.pickupDateLabel,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['customer_name'] = Variable<String>(customerName);
    map['mode'] = Variable<int>(mode);
    map['pickup_date_label'] = Variable<String>(pickupDateLabel);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbPurchaseOrdersCompanion toCompanion(bool nullToAbsent) {
    return DbPurchaseOrdersCompanion(
      id: Value(id),
      customerName: Value(customerName),
      mode: Value(mode),
      pickupDateLabel: Value(pickupDateLabel),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory DbPurchaseOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPurchaseOrder(
      id: serializer.fromJson<String>(json['id']),
      customerName: serializer.fromJson<String>(json['customerName']),
      mode: serializer.fromJson<int>(json['mode']),
      pickupDateLabel: serializer.fromJson<String>(json['pickupDateLabel']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'customerName': serializer.toJson<String>(customerName),
      'mode': serializer.toJson<int>(mode),
      'pickupDateLabel': serializer.toJson<String>(pickupDateLabel),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbPurchaseOrder copyWith({
    String? id,
    String? customerName,
    int? mode,
    String? pickupDateLabel,
    String? status,
    DateTime? createdAt,
  }) => DbPurchaseOrder(
    id: id ?? this.id,
    customerName: customerName ?? this.customerName,
    mode: mode ?? this.mode,
    pickupDateLabel: pickupDateLabel ?? this.pickupDateLabel,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  DbPurchaseOrder copyWithCompanion(DbPurchaseOrdersCompanion data) {
    return DbPurchaseOrder(
      id: data.id.present ? data.id.value : this.id,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      mode: data.mode.present ? data.mode.value : this.mode,
      pickupDateLabel: data.pickupDateLabel.present
          ? data.pickupDateLabel.value
          : this.pickupDateLabel,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbPurchaseOrder(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('mode: $mode, ')
          ..write('pickupDateLabel: $pickupDateLabel, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, customerName, mode, pickupDateLabel, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPurchaseOrder &&
          other.id == this.id &&
          other.customerName == this.customerName &&
          other.mode == this.mode &&
          other.pickupDateLabel == this.pickupDateLabel &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class DbPurchaseOrdersCompanion extends UpdateCompanion<DbPurchaseOrder> {
  final Value<String> id;
  final Value<String> customerName;
  final Value<int> mode;
  final Value<String> pickupDateLabel;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DbPurchaseOrdersCompanion({
    this.id = const Value.absent(),
    this.customerName = const Value.absent(),
    this.mode = const Value.absent(),
    this.pickupDateLabel = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DbPurchaseOrdersCompanion.insert({
    required String id,
    required String customerName,
    required int mode,
    required String pickupDateLabel,
    required String status,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       customerName = Value(customerName),
       mode = Value(mode),
       pickupDateLabel = Value(pickupDateLabel),
       status = Value(status);
  static Insertable<DbPurchaseOrder> custom({
    Expression<String>? id,
    Expression<String>? customerName,
    Expression<int>? mode,
    Expression<String>? pickupDateLabel,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerName != null) 'customer_name': customerName,
      if (mode != null) 'mode': mode,
      if (pickupDateLabel != null) 'pickup_date_label': pickupDateLabel,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DbPurchaseOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? customerName,
    Value<int>? mode,
    Value<String>? pickupDateLabel,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return DbPurchaseOrdersCompanion(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      mode: mode ?? this.mode,
      pickupDateLabel: pickupDateLabel ?? this.pickupDateLabel,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (mode.present) {
      map['mode'] = Variable<int>(mode.value);
    }
    if (pickupDateLabel.present) {
      map['pickup_date_label'] = Variable<String>(pickupDateLabel.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPurchaseOrdersCompanion(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('mode: $mode, ')
          ..write('pickupDateLabel: $pickupDateLabel, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DbPurchaseOrderItemsTable extends DbPurchaseOrderItems
    with TableInfo<$DbPurchaseOrderItemsTable, DbPurchaseOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbPurchaseOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES db_purchase_orders (id)',
    ),
  );
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<String> carId = GeneratedColumn<String>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packageNameMeta = const VerificationMeta(
    'packageName',
  );
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
    'package_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    orderId,
    carId,
    packageName,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_purchase_order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbPurchaseOrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    if (data.containsKey('package_name')) {
      context.handle(
        _packageNameMeta,
        packageName.isAcceptableOrUnknown(
          data['package_name']!,
          _packageNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbPurchaseOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbPurchaseOrderItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}car_id'],
      )!,
      packageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}package_name'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $DbPurchaseOrderItemsTable createAlias(String alias) {
    return $DbPurchaseOrderItemsTable(attachedDatabase, alias);
  }
}

class DbPurchaseOrderItem extends DataClass
    implements Insertable<DbPurchaseOrderItem> {
  final int id;
  final String orderId;
  final String carId;
  final String packageName;
  final int position;
  const DbPurchaseOrderItem({
    required this.id,
    required this.orderId,
    required this.carId,
    required this.packageName,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<String>(orderId);
    map['car_id'] = Variable<String>(carId);
    map['package_name'] = Variable<String>(packageName);
    map['position'] = Variable<int>(position);
    return map;
  }

  DbPurchaseOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return DbPurchaseOrderItemsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      carId: Value(carId),
      packageName: Value(packageName),
      position: Value(position),
    );
  }

  factory DbPurchaseOrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPurchaseOrderItem(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<String>(json['orderId']),
      carId: serializer.fromJson<String>(json['carId']),
      packageName: serializer.fromJson<String>(json['packageName']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<String>(orderId),
      'carId': serializer.toJson<String>(carId),
      'packageName': serializer.toJson<String>(packageName),
      'position': serializer.toJson<int>(position),
    };
  }

  DbPurchaseOrderItem copyWith({
    int? id,
    String? orderId,
    String? carId,
    String? packageName,
    int? position,
  }) => DbPurchaseOrderItem(
    id: id ?? this.id,
    orderId: orderId ?? this.orderId,
    carId: carId ?? this.carId,
    packageName: packageName ?? this.packageName,
    position: position ?? this.position,
  );
  DbPurchaseOrderItem copyWithCompanion(DbPurchaseOrderItemsCompanion data) {
    return DbPurchaseOrderItem(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      carId: data.carId.present ? data.carId.value : this.carId,
      packageName: data.packageName.present
          ? data.packageName.value
          : this.packageName,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbPurchaseOrderItem(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('carId: $carId, ')
          ..write('packageName: $packageName, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, carId, packageName, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPurchaseOrderItem &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.carId == this.carId &&
          other.packageName == this.packageName &&
          other.position == this.position);
}

class DbPurchaseOrderItemsCompanion
    extends UpdateCompanion<DbPurchaseOrderItem> {
  final Value<int> id;
  final Value<String> orderId;
  final Value<String> carId;
  final Value<String> packageName;
  final Value<int> position;
  const DbPurchaseOrderItemsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.carId = const Value.absent(),
    this.packageName = const Value.absent(),
    this.position = const Value.absent(),
  });
  DbPurchaseOrderItemsCompanion.insert({
    this.id = const Value.absent(),
    required String orderId,
    required String carId,
    required String packageName,
    required int position,
  }) : orderId = Value(orderId),
       carId = Value(carId),
       packageName = Value(packageName),
       position = Value(position);
  static Insertable<DbPurchaseOrderItem> custom({
    Expression<int>? id,
    Expression<String>? orderId,
    Expression<String>? carId,
    Expression<String>? packageName,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (carId != null) 'car_id': carId,
      if (packageName != null) 'package_name': packageName,
      if (position != null) 'position': position,
    });
  }

  DbPurchaseOrderItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? orderId,
    Value<String>? carId,
    Value<String>? packageName,
    Value<int>? position,
  }) {
    return DbPurchaseOrderItemsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      carId: carId ?? this.carId,
      packageName: packageName ?? this.packageName,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (carId.present) {
      map['car_id'] = Variable<String>(carId.value);
    }
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbPurchaseOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('carId: $carId, ')
          ..write('packageName: $packageName, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

abstract class _$CarStoreDatabase extends GeneratedDatabase {
  _$CarStoreDatabase(QueryExecutor e) : super(e);
  $CarStoreDatabaseManager get managers => $CarStoreDatabaseManager(this);
  late final $FavoriteCarsTable favoriteCars = $FavoriteCarsTable(this);
  late final $DbReservationItemsTable dbReservationItems =
      $DbReservationItemsTable(this);
  late final $DbPurchaseOrdersTable dbPurchaseOrders = $DbPurchaseOrdersTable(
    this,
  );
  late final $DbPurchaseOrderItemsTable dbPurchaseOrderItems =
      $DbPurchaseOrderItemsTable(this);
  late final FavoriteCarDao favoriteCarDao = FavoriteCarDao(
    this as CarStoreDatabase,
  );
  late final ReservationDao reservationDao = ReservationDao(
    this as CarStoreDatabase,
  );
  late final PurchaseOrderDao purchaseOrderDao = PurchaseOrderDao(
    this as CarStoreDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoriteCars,
    dbReservationItems,
    dbPurchaseOrders,
    dbPurchaseOrderItems,
  ];
}

typedef $$FavoriteCarsTableCreateCompanionBuilder =
    FavoriteCarsCompanion Function({
      required String carId,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });
typedef $$FavoriteCarsTableUpdateCompanionBuilder =
    FavoriteCarsCompanion Function({
      Value<String> carId,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$FavoriteCarsTableFilterComposer
    extends Composer<_$CarStoreDatabase, $FavoriteCarsTable> {
  $$FavoriteCarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteCarsTableOrderingComposer
    extends Composer<_$CarStoreDatabase, $FavoriteCarsTable> {
  $$FavoriteCarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteCarsTableAnnotationComposer
    extends Composer<_$CarStoreDatabase, $FavoriteCarsTable> {
  $$FavoriteCarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get carId =>
      $composableBuilder(column: $table.carId, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt =>
      $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$FavoriteCarsTableTableManager
    extends
        RootTableManager<
          _$CarStoreDatabase,
          $FavoriteCarsTable,
          FavoriteCar,
          $$FavoriteCarsTableFilterComposer,
          $$FavoriteCarsTableOrderingComposer,
          $$FavoriteCarsTableAnnotationComposer,
          $$FavoriteCarsTableCreateCompanionBuilder,
          $$FavoriteCarsTableUpdateCompanionBuilder,
          (
            FavoriteCar,
            BaseReferences<_$CarStoreDatabase, $FavoriteCarsTable, FavoriteCar>,
          ),
          FavoriteCar,
          PrefetchHooks Function()
        > {
  $$FavoriteCarsTableTableManager(
    _$CarStoreDatabase db,
    $FavoriteCarsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteCarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteCarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteCarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> carId = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteCarsCompanion(
                carId: carId,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String carId,
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteCarsCompanion.insert(
                carId: carId,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteCarsTableProcessedTableManager =
    ProcessedTableManager<
      _$CarStoreDatabase,
      $FavoriteCarsTable,
      FavoriteCar,
      $$FavoriteCarsTableFilterComposer,
      $$FavoriteCarsTableOrderingComposer,
      $$FavoriteCarsTableAnnotationComposer,
      $$FavoriteCarsTableCreateCompanionBuilder,
      $$FavoriteCarsTableUpdateCompanionBuilder,
      (
        FavoriteCar,
        BaseReferences<_$CarStoreDatabase, $FavoriteCarsTable, FavoriteCar>,
      ),
      FavoriteCar,
      PrefetchHooks Function()
    >;
typedef $$DbReservationItemsTableCreateCompanionBuilder =
    DbReservationItemsCompanion Function({
      Value<int> id,
      required String carId,
      required String packageName,
      Value<DateTime> createdAt,
    });
typedef $$DbReservationItemsTableUpdateCompanionBuilder =
    DbReservationItemsCompanion Function({
      Value<int> id,
      Value<String> carId,
      Value<String> packageName,
      Value<DateTime> createdAt,
    });

class $$DbReservationItemsTableFilterComposer
    extends Composer<_$CarStoreDatabase, $DbReservationItemsTable> {
  $$DbReservationItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbReservationItemsTableOrderingComposer
    extends Composer<_$CarStoreDatabase, $DbReservationItemsTable> {
  $$DbReservationItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbReservationItemsTableAnnotationComposer
    extends Composer<_$CarStoreDatabase, $DbReservationItemsTable> {
  $$DbReservationItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get carId =>
      $composableBuilder(column: $table.carId, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbReservationItemsTableTableManager
    extends
        RootTableManager<
          _$CarStoreDatabase,
          $DbReservationItemsTable,
          DbReservationItem,
          $$DbReservationItemsTableFilterComposer,
          $$DbReservationItemsTableOrderingComposer,
          $$DbReservationItemsTableAnnotationComposer,
          $$DbReservationItemsTableCreateCompanionBuilder,
          $$DbReservationItemsTableUpdateCompanionBuilder,
          (
            DbReservationItem,
            BaseReferences<
              _$CarStoreDatabase,
              $DbReservationItemsTable,
              DbReservationItem
            >,
          ),
          DbReservationItem,
          PrefetchHooks Function()
        > {
  $$DbReservationItemsTableTableManager(
    _$CarStoreDatabase db,
    $DbReservationItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbReservationItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbReservationItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbReservationItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> carId = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbReservationItemsCompanion(
                id: id,
                carId: carId,
                packageName: packageName,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String carId,
                required String packageName,
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbReservationItemsCompanion.insert(
                id: id,
                carId: carId,
                packageName: packageName,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbReservationItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$CarStoreDatabase,
      $DbReservationItemsTable,
      DbReservationItem,
      $$DbReservationItemsTableFilterComposer,
      $$DbReservationItemsTableOrderingComposer,
      $$DbReservationItemsTableAnnotationComposer,
      $$DbReservationItemsTableCreateCompanionBuilder,
      $$DbReservationItemsTableUpdateCompanionBuilder,
      (
        DbReservationItem,
        BaseReferences<
          _$CarStoreDatabase,
          $DbReservationItemsTable,
          DbReservationItem
        >,
      ),
      DbReservationItem,
      PrefetchHooks Function()
    >;
typedef $$DbPurchaseOrdersTableCreateCompanionBuilder =
    DbPurchaseOrdersCompanion Function({
      required String id,
      required String customerName,
      required int mode,
      required String pickupDateLabel,
      required String status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$DbPurchaseOrdersTableUpdateCompanionBuilder =
    DbPurchaseOrdersCompanion Function({
      Value<String> id,
      Value<String> customerName,
      Value<int> mode,
      Value<String> pickupDateLabel,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$DbPurchaseOrdersTableReferences
    extends
        BaseReferences<
          _$CarStoreDatabase,
          $DbPurchaseOrdersTable,
          DbPurchaseOrder
        > {
  $$DbPurchaseOrdersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $DbPurchaseOrderItemsTable,
    List<DbPurchaseOrderItem>
  >
  _dbPurchaseOrderItemsRefsTable(_$CarStoreDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.dbPurchaseOrderItems,
        aliasName: $_aliasNameGenerator(
          db.dbPurchaseOrders.id,
          db.dbPurchaseOrderItems.orderId,
        ),
      );

  $$DbPurchaseOrderItemsTableProcessedTableManager
  get dbPurchaseOrderItemsRefs {
    final manager = $$DbPurchaseOrderItemsTableTableManager(
      $_db,
      $_db.dbPurchaseOrderItems,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _dbPurchaseOrderItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DbPurchaseOrdersTableFilterComposer
    extends Composer<_$CarStoreDatabase, $DbPurchaseOrdersTable> {
  $$DbPurchaseOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pickupDateLabel => $composableBuilder(
    column: $table.pickupDateLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dbPurchaseOrderItemsRefs(
    Expression<bool> Function($$DbPurchaseOrderItemsTableFilterComposer f) f,
  ) {
    final $$DbPurchaseOrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbPurchaseOrderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbPurchaseOrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.dbPurchaseOrderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbPurchaseOrdersTableOrderingComposer
    extends Composer<_$CarStoreDatabase, $DbPurchaseOrdersTable> {
  $$DbPurchaseOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pickupDateLabel => $composableBuilder(
    column: $table.pickupDateLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbPurchaseOrdersTableAnnotationComposer
    extends Composer<_$CarStoreDatabase, $DbPurchaseOrdersTable> {
  $$DbPurchaseOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get pickupDateLabel => $composableBuilder(
    column: $table.pickupDateLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> dbPurchaseOrderItemsRefs<T extends Object>(
    Expression<T> Function($$DbPurchaseOrderItemsTableAnnotationComposer a) f,
  ) {
    final $$DbPurchaseOrderItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.dbPurchaseOrderItems,
          getReferencedColumn: (t) => t.orderId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DbPurchaseOrderItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.dbPurchaseOrderItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DbPurchaseOrdersTableTableManager
    extends
        RootTableManager<
          _$CarStoreDatabase,
          $DbPurchaseOrdersTable,
          DbPurchaseOrder,
          $$DbPurchaseOrdersTableFilterComposer,
          $$DbPurchaseOrdersTableOrderingComposer,
          $$DbPurchaseOrdersTableAnnotationComposer,
          $$DbPurchaseOrdersTableCreateCompanionBuilder,
          $$DbPurchaseOrdersTableUpdateCompanionBuilder,
          (DbPurchaseOrder, $$DbPurchaseOrdersTableReferences),
          DbPurchaseOrder,
          PrefetchHooks Function({bool dbPurchaseOrderItemsRefs})
        > {
  $$DbPurchaseOrdersTableTableManager(
    _$CarStoreDatabase db,
    $DbPurchaseOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbPurchaseOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbPurchaseOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbPurchaseOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<int> mode = const Value.absent(),
                Value<String> pickupDateLabel = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbPurchaseOrdersCompanion(
                id: id,
                customerName: customerName,
                mode: mode,
                pickupDateLabel: pickupDateLabel,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String customerName,
                required int mode,
                required String pickupDateLabel,
                required String status,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DbPurchaseOrdersCompanion.insert(
                id: id,
                customerName: customerName,
                mode: mode,
                pickupDateLabel: pickupDateLabel,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DbPurchaseOrdersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dbPurchaseOrderItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (dbPurchaseOrderItemsRefs) db.dbPurchaseOrderItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dbPurchaseOrderItemsRefs)
                    await $_getPrefetchedData<
                      DbPurchaseOrder,
                      $DbPurchaseOrdersTable,
                      DbPurchaseOrderItem
                    >(
                      currentTable: table,
                      referencedTable: $$DbPurchaseOrdersTableReferences
                          ._dbPurchaseOrderItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DbPurchaseOrdersTableReferences(
                            db,
                            table,
                            p0,
                          ).dbPurchaseOrderItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.orderId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DbPurchaseOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$CarStoreDatabase,
      $DbPurchaseOrdersTable,
      DbPurchaseOrder,
      $$DbPurchaseOrdersTableFilterComposer,
      $$DbPurchaseOrdersTableOrderingComposer,
      $$DbPurchaseOrdersTableAnnotationComposer,
      $$DbPurchaseOrdersTableCreateCompanionBuilder,
      $$DbPurchaseOrdersTableUpdateCompanionBuilder,
      (DbPurchaseOrder, $$DbPurchaseOrdersTableReferences),
      DbPurchaseOrder,
      PrefetchHooks Function({bool dbPurchaseOrderItemsRefs})
    >;
typedef $$DbPurchaseOrderItemsTableCreateCompanionBuilder =
    DbPurchaseOrderItemsCompanion Function({
      Value<int> id,
      required String orderId,
      required String carId,
      required String packageName,
      required int position,
    });
typedef $$DbPurchaseOrderItemsTableUpdateCompanionBuilder =
    DbPurchaseOrderItemsCompanion Function({
      Value<int> id,
      Value<String> orderId,
      Value<String> carId,
      Value<String> packageName,
      Value<int> position,
    });

final class $$DbPurchaseOrderItemsTableReferences
    extends
        BaseReferences<
          _$CarStoreDatabase,
          $DbPurchaseOrderItemsTable,
          DbPurchaseOrderItem
        > {
  $$DbPurchaseOrderItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DbPurchaseOrdersTable _orderIdTable(_$CarStoreDatabase db) =>
      db.dbPurchaseOrders.createAlias(
        $_aliasNameGenerator(
          db.dbPurchaseOrderItems.orderId,
          db.dbPurchaseOrders.id,
        ),
      );

  $$DbPurchaseOrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$DbPurchaseOrdersTableTableManager(
      $_db,
      $_db.dbPurchaseOrders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DbPurchaseOrderItemsTableFilterComposer
    extends Composer<_$CarStoreDatabase, $DbPurchaseOrderItemsTable> {
  $$DbPurchaseOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$DbPurchaseOrdersTableFilterComposer get orderId {
    final $$DbPurchaseOrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.dbPurchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbPurchaseOrdersTableFilterComposer(
            $db: $db,
            $table: $db.dbPurchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbPurchaseOrderItemsTableOrderingComposer
    extends Composer<_$CarStoreDatabase, $DbPurchaseOrderItemsTable> {
  $$DbPurchaseOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$DbPurchaseOrdersTableOrderingComposer get orderId {
    final $$DbPurchaseOrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.dbPurchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbPurchaseOrdersTableOrderingComposer(
            $db: $db,
            $table: $db.dbPurchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbPurchaseOrderItemsTableAnnotationComposer
    extends Composer<_$CarStoreDatabase, $DbPurchaseOrderItemsTable> {
  $$DbPurchaseOrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get carId =>
      $composableBuilder(column: $table.carId, builder: (column) => column);

  GeneratedColumn<String> get packageName => $composableBuilder(
    column: $table.packageName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$DbPurchaseOrdersTableAnnotationComposer get orderId {
    final $$DbPurchaseOrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.dbPurchaseOrders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbPurchaseOrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.dbPurchaseOrders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbPurchaseOrderItemsTableTableManager
    extends
        RootTableManager<
          _$CarStoreDatabase,
          $DbPurchaseOrderItemsTable,
          DbPurchaseOrderItem,
          $$DbPurchaseOrderItemsTableFilterComposer,
          $$DbPurchaseOrderItemsTableOrderingComposer,
          $$DbPurchaseOrderItemsTableAnnotationComposer,
          $$DbPurchaseOrderItemsTableCreateCompanionBuilder,
          $$DbPurchaseOrderItemsTableUpdateCompanionBuilder,
          (DbPurchaseOrderItem, $$DbPurchaseOrderItemsTableReferences),
          DbPurchaseOrderItem,
          PrefetchHooks Function({bool orderId})
        > {
  $$DbPurchaseOrderItemsTableTableManager(
    _$CarStoreDatabase db,
    $DbPurchaseOrderItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbPurchaseOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbPurchaseOrderItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DbPurchaseOrderItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> carId = const Value.absent(),
                Value<String> packageName = const Value.absent(),
                Value<int> position = const Value.absent(),
              }) => DbPurchaseOrderItemsCompanion(
                id: id,
                orderId: orderId,
                carId: carId,
                packageName: packageName,
                position: position,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String orderId,
                required String carId,
                required String packageName,
                required int position,
              }) => DbPurchaseOrderItemsCompanion.insert(
                id: id,
                orderId: orderId,
                carId: carId,
                packageName: packageName,
                position: position,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DbPurchaseOrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable:
                                    $$DbPurchaseOrderItemsTableReferences
                                        ._orderIdTable(db),
                                referencedColumn:
                                    $$DbPurchaseOrderItemsTableReferences
                                        ._orderIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DbPurchaseOrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$CarStoreDatabase,
      $DbPurchaseOrderItemsTable,
      DbPurchaseOrderItem,
      $$DbPurchaseOrderItemsTableFilterComposer,
      $$DbPurchaseOrderItemsTableOrderingComposer,
      $$DbPurchaseOrderItemsTableAnnotationComposer,
      $$DbPurchaseOrderItemsTableCreateCompanionBuilder,
      $$DbPurchaseOrderItemsTableUpdateCompanionBuilder,
      (DbPurchaseOrderItem, $$DbPurchaseOrderItemsTableReferences),
      DbPurchaseOrderItem,
      PrefetchHooks Function({bool orderId})
    >;

class $CarStoreDatabaseManager {
  final _$CarStoreDatabase _db;
  $CarStoreDatabaseManager(this._db);
  $$FavoriteCarsTableTableManager get favoriteCars =>
      $$FavoriteCarsTableTableManager(_db, _db.favoriteCars);
  $$DbReservationItemsTableTableManager get dbReservationItems =>
      $$DbReservationItemsTableTableManager(_db, _db.dbReservationItems);
  $$DbPurchaseOrdersTableTableManager get dbPurchaseOrders =>
      $$DbPurchaseOrdersTableTableManager(_db, _db.dbPurchaseOrders);
  $$DbPurchaseOrderItemsTableTableManager get dbPurchaseOrderItems =>
      $$DbPurchaseOrderItemsTableTableManager(_db, _db.dbPurchaseOrderItems);
}

mixin _$FavoriteCarDaoMixin on DatabaseAccessor<CarStoreDatabase> {
  $FavoriteCarsTable get favoriteCars => attachedDatabase.favoriteCars;
  FavoriteCarDaoManager get managers => FavoriteCarDaoManager(this);
}

class FavoriteCarDaoManager {
  final _$FavoriteCarDaoMixin _db;
  FavoriteCarDaoManager(this._db);
  $$FavoriteCarsTableTableManager get favoriteCars =>
      $$FavoriteCarsTableTableManager(_db.attachedDatabase, _db.favoriteCars);
}

mixin _$ReservationDaoMixin on DatabaseAccessor<CarStoreDatabase> {
  $DbReservationItemsTable get dbReservationItems =>
      attachedDatabase.dbReservationItems;
  ReservationDaoManager get managers => ReservationDaoManager(this);
}

class ReservationDaoManager {
  final _$ReservationDaoMixin _db;
  ReservationDaoManager(this._db);
  $$DbReservationItemsTableTableManager get dbReservationItems =>
      $$DbReservationItemsTableTableManager(
        _db.attachedDatabase,
        _db.dbReservationItems,
      );
}

mixin _$PurchaseOrderDaoMixin on DatabaseAccessor<CarStoreDatabase> {
  $DbPurchaseOrdersTable get dbPurchaseOrders =>
      attachedDatabase.dbPurchaseOrders;
  $DbPurchaseOrderItemsTable get dbPurchaseOrderItems =>
      attachedDatabase.dbPurchaseOrderItems;
  PurchaseOrderDaoManager get managers => PurchaseOrderDaoManager(this);
}

class PurchaseOrderDaoManager {
  final _$PurchaseOrderDaoMixin _db;
  PurchaseOrderDaoManager(this._db);
  $$DbPurchaseOrdersTableTableManager get dbPurchaseOrders =>
      $$DbPurchaseOrdersTableTableManager(
        _db.attachedDatabase,
        _db.dbPurchaseOrders,
      );
  $$DbPurchaseOrderItemsTableTableManager get dbPurchaseOrderItems =>
      $$DbPurchaseOrderItemsTableTableManager(
        _db.attachedDatabase,
        _db.dbPurchaseOrderItems,
      );
}
