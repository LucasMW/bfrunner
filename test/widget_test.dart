// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bf_test/main.dart';

void main() {
  testWidgets("Hello World", (WidgetTester tester) async {
    final program =
        '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.';
    await tester.pumpWidget(MyApp());
    expect(find.text("Program"), findsOneWidget);
    expect(find.text("Hello World"), findsNothing);

    await tester.enterText(find.byType(TextField), program);
    expect(find.text(program), findsOneWidget);

    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    expect(find.text("Hello World!\n"), findsOneWidget);
  });
  testWidgets("Execution Counter", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
    for (int i = 1; i < 10; i++) {
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pump();
      expect(find.text(i.toString()), findsNothing);
      expect(find.text((i + 1).toString()), findsOneWidget);
    }
  });
}
