import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/car_store_models.dart';
import '../screens/account_page.dart';
import '../screens/checkout_page.dart';
import '../screens/discover_page.dart';
import '../screens/login_page.dart';
import '../screens/orders_page.dart';
import '../screens/showroom_page.dart';
import 'car_store_state.dart';

class CarStoreApp extends StatefulWidget {
  const CarStoreApp({super.key});

  @override
  State<CarStoreApp> createState() => _CarStoreAppState();
}

class _CarStoreAppState extends State<CarStoreApp> {
  late final CarStoreState _state;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _state = CarStoreState();
    _router = GoRouter(
      initialLocation: '/login',
      refreshListenable: _state,
      redirect: (context, state) {
        final loggedIn = _state.loggedIn;
        final onLoginPage = state.matchedLocation == '/login';

        if (!loggedIn && !onLoginPage) {
          return '/login';
        }

        if (loggedIn && onLoginPage) {
          return '/home?tab=0';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return LoginPage(
              onLogIn: (username, password) async {
                await _state.signIn(username, password);
                if (context.mounted) {
                  context.go('/home?tab=0');
                }
              },
            );
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            final tab = CarStoreTab.fromQueryValue(
              state.uri.queryParameters['tab'],
            );
            return CarStoreShell(state: _state, currentTab: tab);
          },
          routes: [
            GoRoute(
              path: 'showroom/:showroomId',
              builder: (context, state) {
                final tab = CarStoreTab.fromQueryValue(
                  state.uri.queryParameters['tab'],
                );
                final showroomId = state.pathParameters['showroomId']!;
                return ShowroomPage(
                  showroomId: showroomId,
                  tab: tab,
                  state: _state,
                );
              },
            ),
            GoRoute(
              path: 'checkout',
              builder: (context, state) {
                final tab = CarStoreTab.fromQueryValue(
                  state.uri.queryParameters['tab'],
                );
                return CheckoutPage(tab: tab, state: _state);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _router.dispose();
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CarStoreScope(
      state: _state,
      child: AnimatedBuilder(
        animation: _state,
        builder: (context, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'CarStore',
            themeMode: _state.themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: _state.seedColor),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: _state.seedColor,
                brightness: Brightness.dark,
              ),
            ),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

class CarStoreShell extends StatelessWidget {
  const CarStoreShell({
    super.key,
    required this.state,
    required this.currentTab,
  });

  final CarStoreState state;
  final CarStoreTab currentTab;

  @override
  Widget build(BuildContext context) {
    Widget body;
    switch (currentTab) {
      case CarStoreTab.discover:
        body = const DiscoverPage();
      case CarStoreTab.orders:
        body = OrdersPage(state: state);
      case CarStoreTab.account:
        body = AccountPage(state: state);
    }

    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentTab.indexValue,
        destinations: CarStoreTab.values
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.label,
              ),
            )
            .toList(),
        onDestinationSelected: (index) {
          context.go('/home?tab=$index');
        },
      ),
    );
  }
}
