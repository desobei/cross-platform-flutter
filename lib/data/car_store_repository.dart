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
    CarCategory(
      label: 'EV',
      icon: Icons.bolt_rounded,
      imageAssetPath: 'assets/images/categories/ev.jpg',
    ),
    CarCategory(
      label: 'SUV',
      icon: Icons.airport_shuttle_rounded,
      imageAssetPath: 'assets/images/categories/suv.jpg',
    ),
    CarCategory(
      label: 'Luxury',
      icon: Icons.diamond_outlined,
      imageAssetPath: 'assets/images/categories/luxury.jpg',
    ),
    CarCategory(
      label: 'Track',
      icon: Icons.speed_rounded,
      imageAssetPath: 'assets/images/categories/track.jpg',
    ),
    CarCategory(
      label: 'Family',
      icon: Icons.people_outline_rounded,
      imageAssetPath: 'assets/images/categories/family.jpg',
    ),
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

  static const activities = <DriverActivity>[
    DriverActivity(
      name: 'Nina Park',
      note: 'Reserved a Taycan this morning',
      timeAgo: '22 min ago',
    ),
    DriverActivity(
      name: 'Marco Alves',
      note: 'Shared RS 6 setup ideas',
      timeAgo: '1 hr ago',
    ),
    DriverActivity(
      name: 'Avery Chen',
      note: 'Booked a weekend GLE test drive',
      timeAgo: '2 hr ago',
    ),
    DriverActivity(
      name: 'Ravi Shah',
      note: 'Compared i5 and Model S charging costs',
      timeAgo: '3 hr ago',
    ),
    DriverActivity(
      name: 'Elena Costa',
      note: 'Saved a Land Cruiser off-road setup',
      timeAgo: '4 hr ago',
    ),
    DriverActivity(
      name: 'Jordan Lee',
      note: 'Shared a white-on-black RS 6 build',
      timeAgo: '6 hr ago',
    ),
    DriverActivity(
      name: 'Maya Brooks',
      note: 'Booked a home delivery slot for Friday',
      timeAgo: '8 hr ago',
    ),
    DriverActivity(
      name: 'Theo Ramirez',
      note: 'Posted a review of the new Taycan cabin tech',
      timeAgo: '11 hr ago',
    ),
    DriverActivity(
      name: 'Luca Nguyen',
      note: 'Tracked a Summit Motors reservation update',
      timeAgo: '13 hr ago',
    ),
    DriverActivity(
      name: 'Sofia Kim',
      note: 'Added two SUVs to compare weekend driving comfort',
      timeAgo: '16 hr ago',
    ),
    DriverActivity(
      name: 'Omar Patel',
      note: 'Reserved a Model S with Signature package',
      timeAgo: '18 hr ago',
    ),
    DriverActivity(
      name: 'Isla Morgan',
      note: 'Shared favorite EV routes near San Francisco',
      timeAgo: '21 hr ago',
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

  static String showroomHeroAsset(String showroomId) {
    switch (showroomId) {
      case 'velocity-ev':
        return 'assets/images/showrooms/velocity_ev_house_hero.jpg';
      case 'summit-motors':
        return 'assets/images/showrooms/summit_motors_hero.jpg';
      case 'atelier-garage':
        return 'assets/images/showrooms/atelier_garage_hero.jpg';
      default:
        return '';
    }
  }

  static String carImageAsset(String carId) {
    switch (carId) {
      case 'model-s-plaid':
        return 'assets/images/cars/tesla_model_s_plaid.jpg';
      case 'taycan-4s':
        return 'assets/images/cars/porsche_taycan_4s.jpg';
      case 'bmw-i5':
        return 'assets/images/cars/bmw_i5_m60.jpg';
      case 'gle-450':
        return 'assets/images/cars/mercedes_gle_450.jpg';
      case 'rs6-avant':
        return 'assets/images/cars/audi_rs6_avant.jpg';
      case 'land-cruiser':
        return 'assets/images/cars/toyota_land_cruiser.jpg';
      default:
        return '';
    }
  }

  static List<CarListing> listingsForCategory(String categoryLabel) {
    switch (categoryLabel) {
      case 'EV':
        return listings
            .where(
              (listing) =>
                  listing.id == 'model-s-plaid' ||
                  listing.id == 'taycan-4s' ||
                  listing.id == 'bmw-i5',
            )
            .toList(growable: false);
      case 'SUV':
        return listings
            .where(
              (listing) =>
                  listing.id == 'gle-450' || listing.id == 'land-cruiser',
            )
            .toList(growable: false);
      case 'Luxury':
        return listings
            .where(
              (listing) =>
                  listing.id == 'taycan-4s' ||
                  listing.id == 'bmw-i5' ||
                  listing.id == 'gle-450' ||
                  listing.id == 'rs6-avant',
            )
            .toList(growable: false);
      case 'Track':
        return listings
            .where(
              (listing) =>
                  listing.id == 'model-s-plaid' ||
                  listing.id == 'taycan-4s' ||
                  listing.id == 'rs6-avant',
            )
            .toList(growable: false);
      case 'Family':
        return listings
            .where(
              (listing) =>
                  listing.id == 'gle-450' ||
                  listing.id == 'land-cruiser' ||
                  listing.id == 'bmw-i5',
            )
            .toList(growable: false);
      default:
        return const <CarListing>[];
    }
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
