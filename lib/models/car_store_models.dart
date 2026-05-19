import 'package:flutter/material.dart';

enum CarStoreTab {
  discover('discover', 'Discover', Icons.explore_outlined, Icons.explore),
  orders('orders', 'Orders', Icons.receipt_long_outlined, Icons.receipt_long),
  account(
    'account',
    'Account',
    Icons.person_outline_rounded,
    Icons.person_rounded,
  ),
  advisor(
    'advisor',
    'Advisor Chat',
    Icons.chat_bubble_outline_rounded,
    Icons.chat_bubble_rounded,
  );

  const CarStoreTab(this.queryValue, this.label, this.icon, this.selectedIcon);

  final String queryValue;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  static const navTabs = <CarStoreTab>[
    CarStoreTab.discover,
    CarStoreTab.orders,
    CarStoreTab.account,
    CarStoreTab.advisor,
  ];

  static const _legacyQueryIndexMapping = <int, CarStoreTab>{
    0: CarStoreTab.discover,
    1: CarStoreTab.orders,
    2: CarStoreTab.advisor,
    3: CarStoreTab.account,
  };

  int get indexValue => navIndex(this);

  static int navIndex(CarStoreTab tab) {
    final index = navTabs.indexOf(tab);
    return index == -1 ? 0 : index;
  }

  static CarStoreTab fromNavIndex(int index) {
    if (index < 0 || index >= navTabs.length) {
      return CarStoreTab.discover;
    }
    return navTabs[index];
  }

  static CarStoreTab fromQueryValue(String? value) {
    final normalized = value?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return CarStoreTab.discover;
    }

    for (final tab in CarStoreTab.values) {
      if (tab.queryValue == normalized) {
        return tab;
      }
    }

    final legacyIndex = int.tryParse(normalized);
    if (legacyIndex != null) {
      return _legacyQueryIndexMapping[legacyIndex] ?? fromNavIndex(legacyIndex);
    }

    return CarStoreTab.discover;
  }
}

enum ReservationMode { showroomPickup, homeDelivery }

class Showroom {
  const Showroom({
    required this.id,
    required this.name,
    required this.city,
    required this.specialty,
    required this.rating,
    required this.accentColor,
    required this.description,
  });

  final String id;
  final String name;
  final String city;
  final String specialty;
  final double rating;
  final Color accentColor;
  final String description;
}

class CarCategory {
  const CarCategory({
    required this.label,
    required this.icon,
    required this.imageAssetPath,
  });

  final String label;
  final IconData icon;
  final String imageAssetPath;
}

class CuratorPost {
  const CuratorPost({
    required this.title,
    required this.author,
    required this.summary,
    required this.readTime,
  });

  final String title;
  final String author;
  final String summary;
  final String readTime;
}

class DriverActivity {
  const DriverActivity({
    required this.name,
    required this.note,
    required this.timeAgo,
  });

  final String name;
  final String note;
  final String timeAgo;
}

class CarListing {
  const CarListing({
    required this.id,
    required this.showroomId,
    required this.make,
    required this.model,
    required this.year,
    required this.price,
    required this.rangeOrMileage,
    required this.highlight,
    required this.description,
    required this.colors,
    required this.transmission,
    required this.drivetrain,
    required this.accentColor,
  });

  final String id;
  final String showroomId;
  final String make;
  final String model;
  final int year;
  final int price;
  final String rangeOrMileage;
  final String highlight;
  final String description;
  final List<String> colors;
  final String transmission;
  final String drivetrain;
  final Color accentColor;

  String get title => '$year $make $model';
}

class ReservationItem {
  const ReservationItem({required this.car, required this.packageName});

  final CarListing car;
  final String packageName;
}

class PurchaseOrder {
  const PurchaseOrder({
    required this.id,
    required this.customerName,
    required this.mode,
    required this.pickupDateLabel,
    required this.items,
    required this.status,
  });

  final String id;
  final String customerName;
  final ReservationMode mode;
  final String pickupDateLabel;
  final List<ReservationItem> items;
  final String status;
}
