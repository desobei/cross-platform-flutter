import 'package:flutter_test/flutter_test.dart';

import 'package:yummy/main.dart';

void main() {
  testWidgets('shows initial category view', (tester) async {
    await tester.pumpWidget(const Yummy());

    expect(find.text('Dessert'), findsOneWidget);
    expect(find.textContaining('places'), findsWidgets);
  });

  testWidgets('navigates between tabs', (tester) async {
    await tester.pumpWidget(const Yummy());

    await tester.tap(find.text('Post'));
    await tester.pumpAndSettle();
    expect(find.textContaining('delicious pizza'), findsOneWidget);

    await tester.tap(find.text('Restaurant'));
    await tester.pumpAndSettle();
    expect(find.text('The Blue Prawn'), findsOneWidget);
  });
}
