import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../app/car_store_state.dart';
import '../data/car_store_repository.dart';
import '../models/car_store_models.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.state});

  final CarStoreState state;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: state,
      builder: (context, _) {
        final theme = Theme.of(context);
        final scheme = theme.colorScheme;
        final favorites = CarStoreRepository.listings
            .where((listing) => state.favoriteCarIds.contains(listing.id))
            .toList(growable: false);

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
          children: [
            Text(
              'Account',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage preferences and personalize your showroom experience.',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 18),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 88,
                      height: 64,
                      child: Lottie.asset(
                        'assets/animations/car_pulse.json',
                        repeat: true,
                        animate: true,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Animated showroom profile with Lottie, slide transitions and scale interactions.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    theme.colorScheme.primaryContainer,
                    theme.colorScheme.secondaryContainer,
                  ],
                ),
                border: Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: scheme.primary,
                        child: Text(
                          'AD',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: scheme.onPrimary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Alex Driver',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Driver profile',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Loyalty points: 1,280\nPreferred showroom: Velocity EV House\nSaved cars: ${state.favoriteCarIds.length}',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Saved cars',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            if (favorites.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'No saved cars yet. Tap the heart icon in Discover or a showroom to save one.',
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              )
            else
              for (final car in favorites) _SavedCarRow(car: car),
            const SizedBox(height: 20),
            Card(
              child: SwitchListTile(
                value: state.themeMode == ThemeMode.dark,
                title: const Text('Dark mode'),
                subtitle: const Text(
                  'Switch between daytime and nighttime palette',
                ),
                onChanged: state.changeThemeMode,
                secondary: Icon(
                  state.themeMode == ThemeMode.dark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Accent color',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children:
                  const [
                    Color(0xFF0F4C81),
                    Color(0xFF9A031E),
                    Color(0xFF3D5A40),
                    Color(0xFF7B2CBF),
                  ].map((color) {
                    return _ColorChoice(color: color);
                  }).toList(),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton.tonalIcon(
                  onPressed: () async {
                    await state.signOut();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Log out'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ColorChoice extends StatelessWidget {
  const _ColorChoice({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final state = CarStoreScope.of(context);
    final selected = state.seedColor == color;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () => state.changeSeedColor(color),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected
                ? Theme.of(context).colorScheme.onSurface
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: color,
          child: selected
              ? const Icon(Icons.check_rounded, size: 16, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}

class _SavedCarRow extends StatelessWidget {
  const _SavedCarRow({required this.car});

  final CarListing car;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imagePath = CarStoreRepository.carImageAsset(car.id);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 72,
                height: 56,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: car.accentColor.withOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        color: car.accentColor,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    car.highlight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '\$${car.price}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarStoreScope extends InheritedWidget {
  const CarStoreScope({super.key, required this.state, required super.child});

  final CarStoreState state;

  static CarStoreState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CarStoreScope>();
    assert(scope != null, 'CarStoreScope not found in widget tree');
    return scope!.state;
  }

  @override
  bool updateShouldNotify(CarStoreScope oldWidget) => state != oldWidget.state;
}
