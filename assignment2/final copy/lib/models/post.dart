class Post {
  String id;
  String profileImageUrl;
  String comment;
  String timestamp;

  Post(
    this.id,
    this.profileImageUrl,
    this.comment,
    this.timestamp,
  );
}

List<Post> posts = [
  Post(
    '1',
    'assets/profile_pics/person_cesare.jpeg',
    'Just rewatched Interstellar in IMAX. Goosebumps all over again.',
    '10',
  ),
  Post(
    '2',
    'assets/profile_pics/person_stef.jpeg',
    'Crying at the ending of The Farewell. Highly recommend.',
    '80',
  ),
  Post(
    '3',
    'assets/profile_pics/person_crispy.png',
    'Animated double-feature: Spider-Verse then Up. Perfect night.',
    '20',
  ),
  Post(
    '4',
    'assets/profile_pics/person_joe.jpeg',
    'Documentary spree: Free Solo and Jiro Dreams of Sushi.',
    '30',
  ),
  Post(
    '5',
    'assets/profile_pics/person_katz.jpeg',
    '''Weekend plan: binge the Godfather trilogy with homemade pasta.''',
    '40',
  ),
  Post(
    '6',
    'assets/profile_pics/person_kevin.jpeg',
    '''Debating 2D vs 3D for the new Avatar re-release. Thoughts?''',
    '50',
  ),
  Post(
    '7',
    'assets/profile_pics/person_sandra.jpeg',
    '''Hosting a Miyazaki marathon—starting with Totoro tonight.''',
    '50',
  ),
  Post(
    '8',
    'assets/profile_pics/person_manda.png',
    'Need recommendations for best thriller on streaming right now.',
    '60',
  ),
  Post(
    '9',
    'assets/profile_pics/person_ray.jpeg',
    'Caught an outdoor screening of La La Land with a live band.',
    '70',
  ),
  Post(
    '10',
    'assets/profile_pics/person_tiffani.jpeg',
    'Popcorn and noir night: watching Casablanca under a blanket.',
    '90',
  ),
];
