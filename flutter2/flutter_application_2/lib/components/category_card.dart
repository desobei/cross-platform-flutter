import 'package:flutter/material.dart';
import '../models/food_category.dart';

class CategoryCard extends StatelessWidget {
  // 1
  final FoodCategory category;

  const CategoryCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Get text theme
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor:
    Theme.of(context).colorScheme.onSurface);
      

    // TODO: Replace with Card widget
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // todo: add stack widget
          Stack(
            children: [
              // 1: Image with rounded top corners
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(8.0),
                ),
                child: Image.asset(category.imageUrl),
              ),

              // 2: Top-left text
              Positioned(
                left: 16.0,
                top: 16.0,
                child: Text(
                  'Yummy',
                  style: textTheme.headlineLarge,
                ),
              ),

              // 3: Bottom-right rotated text
              Positioned(
                bottom: 16.0,
                right: 16.0,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    'Smoothies',
                    style: textTheme.headlineLarge,
                  ),
                ),
              ),
            ],
          ),
          // todo: add listtile widget
          ListTile(
            title: Text(
              category.name,
              style: textTheme.titleSmall,),
            subtitle: Text(
              '${category.numberOfRestaurants} places',
              style: textTheme.bodySmall,),),
            
          
        ],
      ),
    );
  }
}