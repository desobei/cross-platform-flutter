class Screening {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Screening({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Theater {
  String id;
  String name;
  String address;
  String attributes;
  String imageUrl;
  String imageCredits;
  double distance;
  double rating;
  List<Screening> screenings;

  Theater(
    this.id,
    this.name,
    this.address,
    this.attributes,
    this.imageUrl,
    this.imageCredits,
    this.distance,
    this.rating,
    this.screenings,
  );

  String getRatingAndDistance() {
    return 'Rating: ${rating.toStringAsFixed(1)} ★ | Distance: '
        '${distance.toStringAsFixed(1)} miles';
  }
}

List<Theater> theaters = [
  Theater(
    'cinema-0',
    'Marquee Cinema',
    '230 Film Row, Los Angeles, CA',
    'IMAX, Dolby Atmos, Recliners',
    'assets/restaurants/TheBluePrawn.webp',
    'https://images.unsplash.com/photo-1572015124294-488267231e35?auto=format&fit=crop&w=1548&q=80',
    2.1,
    4.6,
    [
      Screening(
        name: 'Midnight Premiere: Nebula Run',
        description:
            'Sci-fi epic in IMAX with Dolby Atmos. Thursday 11:45 PM only.',
        price: 18.50,
        imageUrl:
            'https://images.unsplash.com/photo-1464375117522-1311d6a5b81f?auto=format&fit=crop&w=1200&q=80',
      ),
      Screening(
        name: 'Family Matinee: Cloud Pals',
        description:
            'Animated adventure with activity pack for kids. Saturday 2:00 PM.',
        price: 12.00,
        imageUrl:
            'https://images.unsplash.com/photo-1478720568477-152d9b164e26?auto=format&fit=crop&w=1200&q=80',
      ),
      Screening(
        name: 'Classic Throwback: Casablanca',
        description:
            'Restored print on the big screen. Sunday 7:30 PM with live intro.',
        price: 14.00,
        imageUrl:
            'https://images.unsplash.com/photo-1505682634904-d7c8d95cdc50?auto=format&fit=crop&w=1200&q=80',
      ),
    ],
  ),
  Theater(
    'cinema-1',
    'Popcorn Palace',
    '445 Reel Ave, Chicago, IL',
    '4DX, 3D, Student Nights',
    'assets/restaurants/MamaRosasPizza.webp',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=962&q=80',
    0.9,
    4.4,
    [
      Screening(
        name: 'Horror Marathon Pass',
        description: 'All-night lineup: The Descent, Nope, The Shining. '
            'Free coffee refills.',
        price: 21.00,
        imageUrl:
            'https://images.unsplash.com/photo-1549480017-d76466a4b7b4?auto=format&fit=crop&w=1200&q=80',
      ),
      Screening(
        name: 'Indie Spotlight: Little Lights',
        description: 'Award-winning drama followed by a Q&A with the director.',
        price: 13.00,
        imageUrl:
            'https://images.unsplash.com/photo-1489515217757-5fd1be406fef?auto=format&fit=crop&w=1200&q=80',
      ),
      Screening(
        name: 'Anime Night: Skybound Heroes',
        description:
            'Subbed and dubbed showings; cosplay gets a concession discount.',
        price: 11.50,
        imageUrl:
            'https://images.unsplash.com/photo-1523475496153-3d6cc3000a58?auto=format&fit=crop&w=1200&q=80',
      ),
    ],
  ),
  Theater(
    'cinema-2',
    'Backlot Lounge',
    '19 Studio Way, Austin, TX',
    'Arthouse, Cocktails, Small Bites',
    'assets/restaurants/BistroDeParis.jpg',
    'https://images.unsplash.com/photo-1608855238293-a8853e7f7c98?auto=format&fit=crop&w=1470&q=80',
    3.1,
    4.9,
    [
      Screening(
        name: 'Directors Cut: Moon Harbor',
        description: 'Limited screening with behind-the-scenes short and '
            'panel talkback.',
        price: 16.00,
        imageUrl:
            'https://images.unsplash.com/photo-1524985069026-dd778a71c7b4?auto=format&fit=crop&w=1200&q=80',
      ),
      Screening(
        name: 'Silent Film + Live Piano',
        description:
            'Metropolis with a live score performed by local musicians.',
        price: 15.50,
        imageUrl:
            'https://images.unsplash.com/photo-1464375117522-1311d6a5b81f?auto=format&fit=crop&w=1200&q=80',
      ),
      Screening(
        name: 'Docs & Discussion: Blue Planet',
        description:
            'Nature doc followed by a community discussion on conservation.',
        price: 12.50,
        imageUrl:
            'https://images.unsplash.com/photo-1436491865332-7a61a109cc05?auto=format&fit=crop&w=1200&q=80',
      ),
    ],
  ),
];
