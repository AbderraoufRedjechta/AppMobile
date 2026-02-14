import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tayabli/features/auth/login_page.dart';

void main() {
  testWidgets('LoginPage has login button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    expect(find.text('Tayabli'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
  });
}
