import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/car_store_local_repository.dart';
import '../data/car_store_repository.dart';
import '../models/car_feedback.dart';
import '../models/car_store_models.dart';
import '../models/dealer_message.dart';
import '../services/carapi_car_search_service.dart';
import '../services/cloud_car_features_service.dart';
import '../services/dealer_chat_service.dart';

class CarStoreState extends ChangeNotifier {
  CarStoreState({
    required SharedPreferences preferences,
    required CarApiCarSearchService searchService,
    required DealerChatService chatService,
    required CloudCarFeaturesService cloudFeaturesService,
    required CarStoreLocalRepository localRepository,
  }) : _preferences = preferences,
       _searchService = searchService,
       _chatService = chatService,
       _cloudFeaturesService = cloudFeaturesService,
       _localRepository = localRepository {
    _hydrateFromPreferences();
    unawaited(_hydrateFromDatabase());
  }

  static const _prefThemeModeKey = 'themeMode';
  static const _prefSeedColorKey = 'seedColor';
  static const _prefSelectedTabKey = 'selectedTab';
  static const _prefRecentSearchesKey = 'recentSearches';
  static const _prefFavoriteCarIdsKey = 'favoriteCarIds';
  static const _prefReservationItemsKey = 'reservationItems';
  static const _prefOrdersKey = 'purchaseOrders';

  final SharedPreferences _preferences;
  final CarApiCarSearchService _searchService;
  final DealerChatService _chatService;
  final CloudCarFeaturesService _cloudFeaturesService;
  final CarStoreLocalRepository _localRepository;
  Future<void> _snapshotWriteQueue = Future<void>.value();
  Future<void> _databaseWriteQueue = Future<void>.value();
  bool _disposed = false;

  bool _loggedIn = false;
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = const Color(0xFF0F4C81);
  CarStoreTab _selectedTab = CarStoreTab.discover;
  final List<ReservationItem> _reservationItems = <ReservationItem>[];
  final List<PurchaseOrder> _orders = <PurchaseOrder>[];
  final Set<String> _favoriteCarIds = <String>{};
  final List<String> _recentSearches = <String>[];

  bool get loggedIn => _loggedIn;
  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;
  int get selectedTabIndex => CarStoreTab.navIndex(_selectedTab);
  CarStoreTab get selectedTab => _selectedTab;
  List<ReservationItem> get reservationItems =>
      List.unmodifiable(_reservationItems);
  List<PurchaseOrder> get orders => List.unmodifiable(_orders);
  Set<String> get favoriteCarIds => Set.unmodifiable(_favoriteCarIds);
  List<String> get recentSearches => List.unmodifiable(_recentSearches);
  bool get usesEmailPasswordAuth => _chatService.supportsEmailPasswordAuth;

  void _hydrateFromPreferences() {
    final savedTabValue = _safeGetString(_prefSelectedTabKey);
    if (savedTabValue != null && savedTabValue.trim().isNotEmpty) {
      _selectedTab = CarStoreTab.fromQueryValue(savedTabValue);
    } else {
      final legacySavedTabIndex = _safeGetInt(_prefSelectedTabKey);
      if (legacySavedTabIndex != null) {
        _selectedTab = CarStoreTab.fromQueryValue('$legacySavedTabIndex');
      }
    }

    final savedThemeMode = _preferences.getString(_prefThemeModeKey);
    if (savedThemeMode == 'dark') {
      _themeMode = ThemeMode.dark;
    }

    final savedSeedColor = _preferences.getInt(_prefSeedColorKey);
    if (savedSeedColor != null) {
      _seedColor = Color(savedSeedColor);
    }

    final savedSearches = _preferences.getStringList(_prefRecentSearchesKey);
    if (savedSearches != null && savedSearches.isNotEmpty) {
      _recentSearches
        ..clear()
        ..addAll(savedSearches);
    }

    final savedFavoriteCarIds = _preferences.getStringList(
      _prefFavoriteCarIdsKey,
    );
    if (savedFavoriteCarIds != null) {
      _favoriteCarIds
        ..clear()
        ..addAll(savedFavoriteCarIds);
    }

    final savedReservationItems = _decodeJsonList(
      _preferences.getString(_prefReservationItemsKey),
    );
    _reservationItems
      ..clear()
      ..addAll(_reservationItemsFromJson(savedReservationItems));

    final savedOrders = _decodeJsonList(_preferences.getString(_prefOrdersKey));
    _orders
      ..clear()
      ..addAll(_ordersFromJson(savedOrders));
  }

  Future<void> _hydrateFromDatabase() async {
    late final Set<String> databaseFavoriteCarIds;
    late final List<ReservationItem> databaseReservationItems;
    late final List<PurchaseOrder> databaseOrders;

    try {
      databaseFavoriteCarIds = await _localRepository.findFavoriteCarIds();
      databaseReservationItems = await _localRepository.findReservationItems();
      databaseOrders = await _localRepository.findOrders();
    } catch (_) {
      if (!_disposed) {
        notifyListeners();
      }
      return;
    }

    if (_disposed) {
      return;
    }

    final restoreFavoritesToDatabase =
        databaseFavoriteCarIds.isEmpty && _favoriteCarIds.isNotEmpty;
    final restoreReservationsToDatabase =
        databaseReservationItems.isEmpty && _reservationItems.isNotEmpty;
    final restoreOrdersToDatabase =
        databaseOrders.isEmpty && _orders.isNotEmpty;

    if (databaseFavoriteCarIds.isNotEmpty) {
      _favoriteCarIds
        ..clear()
        ..addAll(databaseFavoriteCarIds);
    }

    if (databaseReservationItems.isNotEmpty) {
      _reservationItems
        ..clear()
        ..addAll(databaseReservationItems);
    }

    if (databaseOrders.isNotEmpty) {
      _orders
        ..clear()
        ..addAll(databaseOrders);
    }

    if (restoreFavoritesToDatabase ||
        restoreReservationsToDatabase ||
        restoreOrdersToDatabase) {
      unawaited(
        _restoreMissingPreferencesDataToDatabase(
          favorites: restoreFavoritesToDatabase,
          reservations: restoreReservationsToDatabase,
          orders: restoreOrdersToDatabase,
        ),
      );
    }

    await _queueSnapshotPersist();
    if (_disposed) {
      return;
    }
    notifyListeners();
  }

  Future<String?> signIn(String username, String password) async {
    final errorMessage = await _chatService.signIn(username, password);
    if (errorMessage != null) {
      return errorMessage;
    }

    _loggedIn = true;
    notifyListeners();
    return null;
  }

  Future<String?> signUp(String username, String password) async {
    final errorMessage = await _chatService.signUp(username, password);
    if (errorMessage != null) {
      return errorMessage;
    }

    _loggedIn = true;
    notifyListeners();
    return null;
  }

  Future<void> signOut() async {
    await _chatService.signOut();
    _loggedIn = false;
    _reservationItems.clear();
    _favoriteCarIds.clear();
    await _queueSnapshotPersist();
    await _queueDatabaseWrite(() async {
      await _localRepository.clearReservationItems();
      await _localRepository.clearFavoriteCars();
    });
    notifyListeners();
  }

  void syncSelectedTab(CarStoreTab tab) {
    if (_selectedTab == tab) {
      return;
    }
    _selectedTab = tab;
    _preferences.setString(_prefSelectedTabKey, tab.queryValue);
  }

  void setSelectedTab(CarStoreTab tab) {
    syncSelectedTab(tab);
    notifyListeners();
  }

  void changeThemeMode(bool darkModeEnabled) {
    _themeMode = darkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    _preferences.setString(
      _prefThemeModeKey,
      darkModeEnabled ? 'dark' : 'light',
    );
    notifyListeners();
  }

  void changeSeedColor(Color color) {
    _seedColor = color;
    _preferences.setInt(_prefSeedColorKey, color.value);
    notifyListeners();
  }

  void addReservation(CarListing car, String packageName) {
    final item = ReservationItem(car: car, packageName: packageName);
    _reservationItems.add(item);
    unawaited(_queueSnapshotPersist());
    _queueDatabaseWrite(() => _localRepository.saveReservationItem(item));
    notifyListeners();
  }

  void removeReservationAt(int index) {
    _reservationItems.removeAt(index);
    final items = List<ReservationItem>.from(_reservationItems);
    unawaited(_queueSnapshotPersist());
    _queueDatabaseWrite(() => _localRepository.replaceReservationItems(items));
    notifyListeners();
  }

  bool isFavorite(String carId) => _favoriteCarIds.contains(carId);

  void toggleFavorite(String carId) {
    if (_favoriteCarIds.contains(carId)) {
      _favoriteCarIds.remove(carId);
      unawaited(_queueSnapshotPersist());
      _queueDatabaseWrite(() async {
        await _localRepository.deleteFavoriteCar(carId);
        await _cloudFeaturesService.deleteFavoriteCar(carId);
      });
    } else {
      _favoriteCarIds.add(carId);
      unawaited(_queueSnapshotPersist());
      _queueDatabaseWrite(() async {
        await _localRepository.saveFavoriteCar(carId);
        await _cloudFeaturesService.saveFavoriteCar(carId);
      });
    }
    notifyListeners();
  }

  Future<void> submitOrder({
    required String customerName,
    required ReservationMode mode,
    required String pickupDateLabel,
  }) async {
    if (_reservationItems.isEmpty) {
      return;
    }

    final order = PurchaseOrder(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      customerName: customerName,
      mode: mode,
      pickupDateLabel: pickupDateLabel,
      items: List<ReservationItem>.from(_reservationItems),
      status: mode == ReservationMode.homeDelivery
          ? 'Preparing delivery'
          : 'Waiting for pickup',
    );

    _orders.insert(0, order);
    _reservationItems.clear();
    notifyListeners();

    await _queueSnapshotPersist();
    await _queueDatabaseWrite(() async {
      await _localRepository.saveOrder(order);
      await _cloudFeaturesService.saveOrder(order);
      await _localRepository.clearReservationItems();
    });
  }

  Stream<List<DealerMessage>> watchAdvisorMessages() {
    return _chatService.watchMessages();
  }

  Future<void> sendAdvisorMessage(String text) {
    return _chatService.sendMessage(text);
  }

  Stream<List<CarFeedback>> watchCarFeedback(String carId) {
    return _cloudFeaturesService.watchFeedback(carId);
  }

  Future<void> sendCarFeedback({
    required String carId,
    required String text,
  }) {
    return _cloudFeaturesService.sendFeedback(carId: carId, text: text);
  }

  Future<List<CarListing>> searchCars(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const <CarListing>[];
    }

    _rememberSearch(trimmed);
    return _searchService.queryCars(trimmed);
  }

  void _rememberSearch(String query) {
    _recentSearches.removeWhere(
      (savedQuery) => savedQuery.toLowerCase() == query.toLowerCase(),
    );
    _recentSearches.insert(0, query);
    if (_recentSearches.length > 8) {
      _recentSearches.removeRange(8, _recentSearches.length);
    }
    _preferences.setStringList(_prefRecentSearchesKey, _recentSearches);
    notifyListeners();
  }

  Future<void> _queueDatabaseWrite(Future<void> Function() write) {
    _databaseWriteQueue = _databaseWriteQueue
        .then((_) => write())
        .catchError((_) {});
    return _databaseWriteQueue;
  }

  Future<void> _queueSnapshotPersist() {
    _snapshotWriteQueue = _snapshotWriteQueue
        .then((_) => _persistLocalSnapshot())
        .catchError((_) {});
    return _snapshotWriteQueue;
  }

  Future<void> _persistLocalSnapshot() async {
    await _preferences.setStringList(
      _prefFavoriteCarIdsKey,
      _favoriteCarIds.toList(growable: false),
    );
    await _preferences.setString(
      _prefReservationItemsKey,
      jsonEncode(_reservationItems.map(_reservationItemToJson).toList()),
    );
    await _preferences.setString(
      _prefOrdersKey,
      jsonEncode(_orders.map(_orderToJson).toList()),
    );
  }

  Future<void> _restoreMissingPreferencesDataToDatabase({
    required bool favorites,
    required bool reservations,
    required bool orders,
  }) {
    return _queueDatabaseWrite(() async {
      if (favorites) {
        for (final carId in _favoriteCarIds) {
          await _localRepository.saveFavoriteCar(carId);
        }
      }

      if (reservations) {
        await _localRepository.replaceReservationItems(_reservationItems);
      }

      if (orders) {
        for (final order in _orders.reversed) {
          await _localRepository.saveOrder(order);
        }
      }
    });
  }

  String? _safeGetString(String key) {
    try {
      return _preferences.getString(key);
    } catch (_) {
      return null;
    }
  }

  int? _safeGetInt(String key) {
    try {
      return _preferences.getInt(key);
    } catch (_) {
      return null;
    }
  }

  List<Object?> _decodeJsonList(String? encoded) {
    if (encoded == null || encoded.isEmpty) {
      return const <Object?>[];
    }

    try {
      final decoded = jsonDecode(encoded);
      if (decoded is List) {
        return decoded;
      }
    } catch (_) {}

    return const <Object?>[];
  }

  List<ReservationItem> _reservationItemsFromJson(List<Object?> values) {
    final items = <ReservationItem>[];
    for (final value in values) {
      final item = _reservationItemFromJson(value);
      if (item != null) {
        items.add(item);
      }
    }
    return items;
  }

  List<PurchaseOrder> _ordersFromJson(List<Object?> values) {
    final orders = <PurchaseOrder>[];
    for (final value in values) {
      final order = _orderFromJson(value);
      if (order != null) {
        orders.add(order);
      }
    }
    return orders;
  }

  Map<String, Object?> _reservationItemToJson(ReservationItem item) {
    return <String, Object?>{
      'carId': item.car.id,
      'packageName': item.packageName,
    };
  }

  Map<String, Object?> _orderToJson(PurchaseOrder order) {
    return <String, Object?>{
      'id': order.id,
      'customerName': order.customerName,
      'mode': order.mode.index,
      'pickupDateLabel': order.pickupDateLabel,
      'status': order.status,
      'items': order.items.map(_reservationItemToJson).toList(),
    };
  }

  ReservationItem? _reservationItemFromJson(Object? value) {
    final map = _jsonMap(value);
    if (map == null) {
      return null;
    }

    final car = _carByIdOrNull(map['carId']);
    final packageName = map['packageName'];
    if (car == null || packageName is! String) {
      return null;
    }

    return ReservationItem(car: car, packageName: packageName);
  }

  PurchaseOrder? _orderFromJson(Object? value) {
    final map = _jsonMap(value);
    if (map == null) {
      return null;
    }

    final id = map['id'];
    final customerName = map['customerName'];
    final modeIndex = map['mode'];
    final pickupDateLabel = map['pickupDateLabel'];
    final status = map['status'];
    final itemValues = map['items'];
    if (id is! String ||
        customerName is! String ||
        modeIndex is! int ||
        pickupDateLabel is! String ||
        status is! String ||
        itemValues is! List ||
        modeIndex < 0 ||
        modeIndex >= ReservationMode.values.length) {
      return null;
    }

    return PurchaseOrder(
      id: id,
      customerName: customerName,
      mode: ReservationMode.values[modeIndex],
      pickupDateLabel: pickupDateLabel,
      items: _reservationItemsFromJson(itemValues),
      status: status,
    );
  }

  Map<String, Object?>? _jsonMap(Object? value) {
    if (value is! Map) {
      return null;
    }

    return value.map((key, mapValue) => MapEntry('$key', mapValue));
  }

  CarListing? _carByIdOrNull(Object? carId) {
    if (carId is! String) {
      return null;
    }

    try {
      return CarStoreRepository.carById(carId);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _chatService.dispose();
    _cloudFeaturesService.dispose();
    unawaited(
      Future.wait<void>([
        _snapshotWriteQueue.catchError((_) {}),
        _databaseWriteQueue.catchError((_) {}),
      ]).whenComplete(_localRepository.close),
    );
    super.dispose();
  }
}
