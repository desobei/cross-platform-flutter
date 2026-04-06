class FoodCategory {
  String name;
  int numberOfListings;
  String imageUrl;

  FoodCategory(this.name, this.numberOfListings, this.imageUrl);
}

List<FoodCategory> categories = [
  FoodCategory('Action', 12, 'assets/categories/burger.png'),
  FoodCategory('Comedy', 10, 'assets/categories/pizza.png'),
  FoodCategory('Drama', 14, 'assets/categories/salad.png'),
  FoodCategory('Sci-Fi', 11, 'assets/categories/coffee.png'),
  FoodCategory('Documentary', 8, 'assets/categories/vegetarian.png'),
  FoodCategory('Animation', 9, 'assets/categories/dessert.png'),
  FoodCategory('Romance', 10, 'assets/categories/italian.png'),
  FoodCategory('Horror', 7, 'assets/categories/seafood.png'),
  FoodCategory('Thriller', 6, 'assets/categories/mexican.png'),
  FoodCategory('Family', 13, 'assets/categories/asian.png'),
];
