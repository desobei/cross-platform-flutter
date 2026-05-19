import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/car_store_local_repository.dart';
import '../models/car_store_models.dart';
import '../screens/account_page.dart';
import '../screens/advisor_chat_page.dart';
import '../screens/checkout_page.dart';
import '../screens/discover_page.dart';
import '../screens/login_page.dart';
import '../screens/orders_page.dart';
import '../screens/showroom_page.dart';
import '../services/carapi_car_search_service.dart';
import '../services/cloud_car_features_service.dart';
import '../services/dealer_chat_service.dart';
import '../widgets/car_store_bottom_nav.dart';
import 'car_store_state.dart';
import 'car_store_theme.dart';

class CarStoreApp extends StatefulWidget {
  const CarStoreApp({
    super.key,
    required this.sharedPreferences,
    required this.searchService,
    required this.chatService,
    required this.cloudFeaturesService,
    required this.localRepository,
  });

  final SharedPreferences sharedPreferences;
  final CarApiCarSearchService searchService;
  final DealerChatService chatService;
  final CloudCarFeaturesService cloudFeaturesService;
  final CarStoreLocalRepository localRepository;

  @override
  State<CarStoreApp> createState() => _CarStoreAppState();
}

class _CarStoreAppState extends State<CarStoreApp> {
  late final CarStoreState _state;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _state = CarStoreState(
      preferences: widget.sharedPreferences,
      searchService: widget.searchService,
      chatService: widget.chatService,
      cloudFeaturesService: widget.cloudFeaturesService,
      localRepository: widget.localRepository,
    );
    _router = GoRouter(
      initialLocation: '/login',
      refreshListenable: _state,
      errorBuilder: (context, state) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.route_rounded, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Page not found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => context.go('/home?tab=discover'),
                  child: const Text('Back to CarStore'),
                ),
              ],
            ),
          ),
        ),
      ),
      redirect: (context, state) {
        final loggedIn = _state.loggedIn;
        final onLoginPage = state.uri.path == '/login';

        if (!loggedIn && !onLoginPage) {
          return '/login';
        }

        if (loggedIn && onLoginPage) {
          return '/home?tab=${_state.selectedTab.queryValue}';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) {
            return _transitionPage(
              key: state.pageKey,
              child: LoginPage(
                usesEmailPasswordAuth: _state.usesEmailPasswordAuth,
                onLogIn: _state.signIn,
                onSignUp: _state.signUp,
              ),
            );
          },
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) {
            final tab = CarStoreTab.fromQueryValue(
              state.uri.queryParameters['tab'],
            );
            _state.syncSelectedTab(tab);
            return _transitionPage(
              key: state.pageKey,
              child: CarStoreShell(state: _state, currentTab: tab),
            );
          },
          routes: [
            GoRoute(
              path: 'showroom/:showroomId',
              pageBuilder: (context, state) {
                final tab = CarStoreTab.fromQueryValue(
                  state.uri.queryParameters['tab'],
                );
                final showroomId = state.pathParameters['showroomId']!;
                return _transitionPage(
                  key: state.pageKey,
                  child: ShowroomPage(
                    showroomId: showroomId,
                    tab: tab,
                    state: _state,
                  ),
                );
              },
            ),
            GoRoute(
              path: 'checkout',
              pageBuilder: (context, state) {
                final tab = CarStoreTab.fromQueryValue(
                  state.uri.queryParameters['tab'],
                );
                return _transitionPage(
                  key: state.pageKey,
                  child: CheckoutPage(tab: tab, state: _state),
                );
              },
            ),
            GoRoute(
              path: 'advisor-chat',
              redirect: (_, _) => '/home?tab=${CarStoreTab.advisor.queryValue}',
            ),
            GoRoute(
              path: 'adviser-chat',
              redirect: (_, _) => '/home?tab=${CarStoreTab.advisor.queryValue}',
            ),
          ],
        ),
      ],
    );
  }


  CustomTransitionPage<void> _transitionPage({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<void>(
      key: key,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 240),
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.06, 0.02),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
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
            theme: buildCarStoreTheme(
              brightness: Brightness.light,
              seedColor: _state.seedColor,
            ),
            darkTheme: buildCarStoreTheme(
              brightness: Brightness.dark,
              seedColor: _state.seedColor,
            ),
            builder: (context, child) {
              return CarStoreBackdrop(child: child ?? const SizedBox.shrink());
            },
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
    final navTabs = CarStoreTab.navTabs;
    final selectedIndex = CarStoreTab.navIndex(currentTab);

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: selectedIndex,
          children: [
            for (final tab in navTabs)
              KeyedSubtree(
                key: ValueKey(tab.queryValue),
                child: _buildTab(tab),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CarStoreBottomNav(
        state: state,
        currentTab: currentTab,
      ),
    );
  }

  Widget _buildTab(CarStoreTab tab) {
    return switch (tab) {
      CarStoreTab.discover => DiscoverPage(state: state),
      CarStoreTab.orders => OrdersPage(state: state),
      CarStoreTab.account => AccountPage(state: state),
      CarStoreTab.advisor => AdvisorChatScreen(state: state),
    };
  }
}
