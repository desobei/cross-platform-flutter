import 'package:flutter/material.dart';

import '../components/theater_landscape_card.dart';
import '../models/theater.dart';

class TheaterSection extends StatelessWidget {
  final List<Theater> theaters;
  const TheaterSection({super.key, required this.theaters});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w800);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 8.0,
            ),
            child: Text('Now Showing Near You', style: titleStyle),
          ),
          SizedBox(
            height: 230,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: theaters.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 300,
                  child: TheaterLandscapeCard(
                    theater: theaters[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
