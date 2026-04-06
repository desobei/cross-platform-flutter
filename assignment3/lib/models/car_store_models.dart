import 'package:flutter/material.dart';

enum CarStoreTab {
  discover(0, 'Discover', Icons.explore_outlined, Icons.explore),
  orders(1, 'Orders', Icons.receipt_long_outlined, Icons.receipt_long),
  account(2, 'Account', Icons.person_outline_rounded, Icons.person_rounded);

  const CarStoreTab(this.indexValue, this.label, this.icon, this.selectedIcon);

  final int indexValue;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  static CarStoreTab fromQueryValue(String? value) {
    switch (value) {
      case '1':
        return CarStoreTab.orders;
      case '2':
        return CarStoreTab.account;
      default:
        return CarStoreTab.discover;
    }
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
  const CarCategory({required this.label, required this.icon});

  final String label;
  final IconData icon;
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
