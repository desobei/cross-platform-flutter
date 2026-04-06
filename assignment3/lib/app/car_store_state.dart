import 'package:flutter/material.dart';

import '../models/car_store_models.dart';

class CarStoreState extends ChangeNotifier {
  bool _loggedIn = false;
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = const Color(0xFF0F4C81);
  final List<ReservationItem> _reservationItems = <ReservationItem>[];
  final List<PurchaseOrder> _orders = <PurchaseOrder>[];

  bool get loggedIn => _loggedIn;
  ThemeMode get themeMode => _themeMode;
  Color get seedColor => _seedColor;
  List<ReservationItem> get reservationItems =>
      List.unmodifiable(_reservationItems);
  List<PurchaseOrder> get orders => List.unmodifiable(_orders);

  Future<void> signIn(String username, String password) async {
    _loggedIn = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    _loggedIn = false;
    _reservationItems.clear();
    notifyListeners();
  }

  void changeThemeMode(bool darkModeEnabled) {
    _themeMode = darkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void changeSeedColor(Color color) {
    _seedColor = color;
    notifyListeners();
  }

  void addReservation(CarListing car, String packageName) {
    _reservationItems.add(ReservationItem(car: car, packageName: packageName));
    notifyListeners();
  }

  void removeReservationAt(int index) {
    _reservationItems.removeAt(index);
    notifyListeners();
  }

  void submitOrder({
    required String customerName,
    required ReservationMode mode,
    required String pickupDateLabel,
  }) {
    if (_reservationItems.isEmpty) {
      return;
    }

    _orders.insert(
      0,
      PurchaseOrder(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        customerName: customerName,
        mode: mode,
        pickupDateLabel: pickupDateLabel,
        items: List<ReservationItem>.from(_reservationItems),
        status: mode == ReservationMode.homeDelivery
            ? 'Preparing delivery'
            : 'Waiting for pickup',
      ),
    );
    _reservationItems.clear();
    notifyListeners();
  }
}
