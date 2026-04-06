import 'package:cross_platform/app/car_store_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CarStore shows login before entering the app', (tester) async {
    await tester.pumpWidget(const CarStoreApp());
    await tester.pumpAndSettle();

    expect(
      find.text('Sign in to continue into your curated garage.'),
      findsOneWidget,
    );
    expect(find.text('Log in'), findsOneWidget);
  });

  testWidgets('logging in opens discover and showroom flow', (tester) async {
    await tester.pumpWidget(const CarStoreApp());
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Build your next garage'), findsOneWidget);
    expect(find.text('Nearby showrooms'), findsOneWidget);

    await tester.tap(find.text('Velocity EV House'));
    await tester.pumpAndSettle();

    expect(find.text('Velocity EV House'), findsWidgets);
    expect(find.text('2025 Tesla Model S Plaid'), findsOneWidget);
  });
}
