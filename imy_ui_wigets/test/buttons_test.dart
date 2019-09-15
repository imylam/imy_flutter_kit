import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imy_ui_wigets/imy_ui_wigets.dart';

void main() {
  testWidgets('Check supplied text is used', (WidgetTester tester) async {
    const suppliedText = "Hello, World!";

    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: GoogleButton(
            onPressed: () {},
            text: suppliedText,
          ),
        ),
      ),
    );

    expect(find.text(suppliedText), findsOneWidget);
  });
}