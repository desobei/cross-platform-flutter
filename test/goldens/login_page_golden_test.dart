import 'package:cross_platform/app/car_store_theme.dart';
import 'package:cross_platform/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  Widget buildLoginSurface({required Brightness brightness}) {
    return CarStoreBackdrop(
      child: LoginPage(
        usesEmailPasswordAuth: false,
        onLogIn: (_, _) async => null,
        onSignUp: (_, _) async => null,
      ),
    );
  }

  Future<void> pumpLoginGolden(
    WidgetTester tester, {
    required Brightness brightness,
  }) async {
    final theme = buildCarStoreTheme(
      brightness: brightness,
      seedColor: const Color(0xFF1D4ED8),
    );

    await tester.pumpWidgetBuilder(
      buildLoginSurface(brightness: brightness),
      wrapper: materialAppWrapper(theme: theme),
      surfaceSize: const Size(430, 932),
    );
    await tester.pumpAndSettle();
  }

  testGoldens('login page light theme matches golden', (tester) async {
    await pumpLoginGolden(tester, brightness: Brightness.light);
    await screenMatchesGolden(tester, 'login_page_light');
  });

  testGoldens('login page dark theme matches golden', (tester) async {
    await pumpLoginGolden(tester, brightness: Brightness.dark);
    await screenMatchesGolden(tester, 'login_page_dark');
  });
}
