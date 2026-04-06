import '../models/models.dart';

// ExploreData serves as a data container that holds
// list of theaters, genres, and friend posts.
class ExploreData {
  final List<Theater> theaters;
  final List<FoodCategory> categories;
  final List<Post> friendPosts;

  ExploreData(this.theaters, this.categories, this.friendPosts);
}

// Mock service that grabs sample data to mock up a movie app request/response
class MockYummyService {
  // Batch request that gets theaters, genres, and friend's feed
  Future<ExploreData> getExploreData() async {
    final theaterList = await _getTheaters();
    final categories = await _getCategories();
    final friendPosts = await _getFriendFeed();

    return ExploreData(theaterList, categories, friendPosts);
  }

  // Get sample food categories to display in ui
  Future<List<FoodCategory>> _getCategories() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 100));
    // Return mock categories
    return categories;
  }

  // Get the friend posts to display in ui
  Future<List<Post>> _getFriendFeed() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 100));
    // Return mock posts
    return posts;
  }

  // Get the theaters to display in ui
  Future<List<Theater>> _getTheaters() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Return mock theaters
    return theaters;
  }
}
