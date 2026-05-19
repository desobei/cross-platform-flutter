import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/car_store_state.dart';
import '../models/car_store_models.dart';

class CarStoreBottomNav extends StatelessWidget {
  const CarStoreBottomNav({
    super.key,
    required this.state,
    required this.currentTab,
    this.action,
    this.actionPadding = const EdgeInsets.fromLTRB(16, 0, 16, 12),
  });

  final CarStoreState state;
  final CarStoreTab currentTab;
  final Widget? action;
  final EdgeInsetsGeometry actionPadding;

  @override
  Widget build(BuildContext context) {
    final navItems = CarStoreTab.navTabs;
    final selectedIndex = CarStoreTab.navIndex(currentTab);

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (action != null) Padding(padding: actionPadding, child: action),
          NavigationBar(
            selectedIndex: selectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: (index) {
              final tab = CarStoreTab.fromNavIndex(index);
              state.setSelectedTab(tab);
              context.go('/home?tab=${tab.queryValue}');
            },
            destinations: [
              for (final tab in navItems)
                NavigationDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.selectedIcon),
                  label: tab.label,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
