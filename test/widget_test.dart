// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:arwika_customer/app.dart';

void main() {
  testWidgets('Splash navigates to home', (WidgetTester tester) async {
    await tester.pumpWidget(const ArwikaCustomerApp());
    expect(find.text('Arwika'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();

    expect(find.text('Arwika Customer'), findsOneWidget);
  });
}
