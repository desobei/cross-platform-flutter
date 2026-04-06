import 'package:flutter/material.dart';
import '../api/mock_yummy_service.dart';
import '../components/theater_section.dart';
import '../components/category_section.dart';
import '../components/post_section.dart';

class ExplorePage extends StatelessWidget {
  final mockService = MockYummyService();

  ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, AsyncSnapshot<ExploreData> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final theaters = snapshot.data?.theaters ?? [];
          final categories = snapshot.data?.categories ?? [];
          final posts = snapshot.data?.friendPosts ?? [];
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              TheaterSection(theaters: theaters),
              CategorySection(categories: categories),
              PostSection(posts: posts),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
