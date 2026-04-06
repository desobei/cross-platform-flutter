import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.state});

  final CarStoreState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primaryContainer,
                theme.colorScheme.secondaryContainer,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Driver profile',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Loyalty points: 1,280\nPreferred showroom: Velocity EV House',
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SwitchListTile(
          value: state.themeMode == ThemeMode.dark,
          title: const Text('Dark mode'),
          subtitle: const Text('Mirrors the chapter account/settings work'),
          onChanged: state.changeThemeMode,
        ),
        const SizedBox(height: 8),
        Text(
          'Accent color',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
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
        FilledButton.tonalIcon(
          onPressed: () async {
            await state.signOut();
            if (context.mounted) {
              context.go('/login');
            }
          },
          icon: const Icon(Icons.logout_rounded),
          label: const Text('Log out'),
        ),
      ],
    );
  }
}

class _ColorChoice extends StatelessWidget {
  const _ColorChoice({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    final state = CarStoreScope.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () => state.changeSeedColor(color),
      child: CircleAvatar(backgroundColor: color, radius: 18),
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
