import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';
import '../data/car_store_repository.dart';
import '../models/car_store_models.dart';

class ShowroomPage extends StatelessWidget {
  const ShowroomPage({
    super.key,
    required this.showroomId,
    required this.tab,
    required this.state,
  });

  final String showroomId;
  final CarStoreTab tab;
  final CarStoreState state;

  @override
  Widget build(BuildContext context) {
    final showroom = CarStoreRepository.showroomById(showroomId);
    final listings = CarStoreRepository.listingsForShowroom(showroomId);
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth >= 1000
        ? 3
        : screenWidth >= 700
        ? 2
        : 1;

    return Scaffold(
      floatingActionButton: state.reservationItems.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () =>
                  context.go('/home/checkout?tab=${tab.indexValue}'),
              icon: const Icon(Icons.shopping_bag_outlined),
              label: Text('${state.reservationItems.length} reserved'),
            ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
            expandedHeight: 220,
            title: Text(showroom.name),
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      showroom.accentColor,
                      showroom.accentColor.withValues(alpha: 0.65),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 110, 20, 20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      showroom.description,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final car = listings[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => _openCarSheet(context, car, state),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 88,
                            decoration: BoxDecoration(
                              color: car.accentColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(
                              Icons.directions_car_filled_rounded,
                              color: car.accentColor,
                              size: 42,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            car.title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(car.highlight),
                          const SizedBox(height: 6),
                          Text(car.rangeOrMileage),
                          const Spacer(),
                          Text(
                            '\$${car.price}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: listings.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.88,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCarSheet(
    BuildContext context,
    CarListing car,
    CarStoreState state,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                car.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(car.description),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text(car.transmission)),
                  Chip(label: Text(car.drivetrain)),
                  Chip(label: Text(car.rangeOrMileage)),
                ],
              ),
              const SizedBox(height: 16),
              Text('Colors: ${car.colors.join(', ')}'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    state.addReservation(car, 'Signature package');
                    Navigator.of(context).pop();
                  },
                  child: const Text('Reserve this car'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
