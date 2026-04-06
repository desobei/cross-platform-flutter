import 'package:flutter/material.dart';

import '../models/car_store_models.dart';

class CarStoreRepository {
  static const showrooms = <Showroom>[
    Showroom(
      id: 'velocity-ev',
      name: 'Velocity EV House',
      city: 'San Francisco',
      specialty: 'Electric performance',
      rating: 4.9,
      accentColor: Color(0xFF20639B),
      description:
          'A premium electric showroom focused on daily-drivable performance cars and clean tech interiors.',
    ),
    Showroom(
      id: 'summit-motors',
      name: 'Summit Motors',
      city: 'Seattle',
      specialty: 'Luxury touring',
      rating: 4.8,
      accentColor: Color(0xFF5C8001),
      description:
          'Curated grand tourers, hybrid SUVs and flagship daily drivers selected for comfort and long-distance range.',
    ),
    Showroom(
      id: 'atelier-garage',
      name: 'Atelier Garage',
      city: 'Austin',
      specialty: 'Designer specs',
      rating: 4.7,
      accentColor: Color(0xFF9A031E),
      description:
          'A boutique studio where every listing is paired with a design-forward trim and a high-end customization package.',
    ),
  ];

  static const categories = <CarCategory>[
    CarCategory(label: 'EV', icon: Icons.bolt_rounded),
    CarCategory(label: 'SUV', icon: Icons.airport_shuttle_rounded),
    CarCategory(label: 'Luxury', icon: Icons.diamond_outlined),
    CarCategory(label: 'Track', icon: Icons.speed_rounded),
    CarCategory(label: 'Family', icon: Icons.people_outline_rounded),
  ];

  static const posts = <CuratorPost>[
    CuratorPost(
      title: 'How to choose between range, charging speed and cabin tech',
      author: 'Nina Park',
      summary:
          'A quick buyer guide for balancing road-trip confidence with the features you actually use every day.',
      readTime: '4 min read',
    ),
    CuratorPost(
      title: 'Three spec combos that keep resale value strong',
      author: 'Marco Alves',
      summary:
          'The trims, wheel sizes and color palettes that buyers keep searching for in premium used inventory.',
      readTime: '5 min read',
    ),
  ];

  static const listings = <CarListing>[
    CarListing(
      id: 'model-s-plaid',
      showroomId: 'velocity-ev',
      make: 'Tesla',
      model: 'Model S Plaid',
      year: 2025,
      price: 104990,
      rangeOrMileage: '348 mi EPA',
      highlight: '1,020 hp tri-motor',
      description:
          'Explosive straight-line speed, a lounge-like cabin and a giant center display for road-trip comfort.',
      colors: ['Pearl White', 'Deep Blue', 'Solid Black'],
      transmission: 'Single-speed',
      drivetrain: 'AWD',
      accentColor: Color(0xFF1F6FEB),
    ),
    CarListing(
      id: 'taycan-4s',
      showroomId: 'velocity-ev',
      make: 'Porsche',
      model: 'Taycan 4S',
      year: 2024,
      price: 118400,
      rangeOrMileage: '252 mi EPA',
      highlight: 'Performance Battery Plus',
      description:
          'A low-slung EV tuned for confidence in corners, with a properly premium interior and fast charging.',
      colors: ['Frozen Blue', 'Jet Black', 'Ice Grey'],
      transmission: '2-speed automatic',
      drivetrain: 'AWD',
      accentColor: Color(0xFF3A86FF),
    ),
    CarListing(
      id: 'bmw-i5',
      showroomId: 'summit-motors',
      make: 'BMW',
      model: 'i5 M60',
      year: 2025,
      price: 84500,
      rangeOrMileage: '256 mi EPA',
      highlight: 'Luxury sport sedan',
      description:
          'Blends quiet long-range comfort with instant torque and one of the sharpest digital dashboards in the segment.',
      colors: ['Alpine White', 'Carbon Black', 'Oxide Grey'],
      transmission: 'Single-speed',
      drivetrain: 'AWD',
      accentColor: Color(0xFF588157),
    ),
    CarListing(
      id: 'gle-450',
      showroomId: 'summit-motors',
      make: 'Mercedes',
      model: 'GLE 450',
      year: 2025,
      price: 70500,
      rangeOrMileage: '18 city / 24 hwy',
      highlight: 'AIRMATIC comfort',
      description:
          'A serene family-focused luxury SUV with strong ride quality, soft materials and a polished tech stack.',
      colors: ['Polar White', 'Obsidian Black', 'Selenite Grey'],
      transmission: '9-speed automatic',
      drivetrain: 'AWD',
      accentColor: Color(0xFF6C757D),
    ),
    CarListing(
      id: 'rs6-avant',
      showroomId: 'atelier-garage',
      make: 'Audi',
      model: 'RS 6 Avant',
      year: 2024,
      price: 129900,
      rangeOrMileage: '15 city / 22 hwy',
      highlight: 'Twin-turbo V8',
      description:
          'A cult-favorite performance wagon with supercar pace, dramatic styling and genuinely usable cargo room.',
      colors: ['Nardo Grey', 'Ascari Blue', 'Mythos Black'],
      transmission: '8-speed tiptronic',
      drivetrain: 'AWD',
      accentColor: Color(0xFFC1121F),
    ),
    CarListing(
      id: 'land-cruiser',
      showroomId: 'atelier-garage',
      make: 'Toyota',
      model: 'Land Cruiser',
      year: 2025,
      price: 68900,
      rangeOrMileage: 'Hybrid off-road',
      highlight: 'Trail-ready 4WD',
      description:
          'Retro-inspired design paired with modern cabin tech and the confidence to leave pavement behind.',
      colors: ['Trail Dust', 'Black', 'Meteor Shower'],
      transmission: '8-speed automatic',
      drivetrain: '4WD',
      accentColor: Color(0xFF9C6644),
    ),
  ];

  static Showroom showroomById(String showroomId) {
    return showrooms.firstWhere((showroom) => showroom.id == showroomId);
  }

  static List<CarListing> listingsForShowroom(String showroomId) {
    return listings
        .where((listing) => listing.showroomId == showroomId)
        .toList(growable: false);
  }

  static CarListing carById(String carId) {
    return listings.firstWhere((listing) => listing.id == carId);
  }
}
