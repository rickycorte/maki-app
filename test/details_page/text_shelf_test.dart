import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/text_shelf.dart';
import 'package:maki/login_page/ask_login_screen.dart';

import '../utils.dart';

void main() {

  testWidgets('Should show all items passed in horizontal', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(createTestWrapper(const TextShelf(items: ["a", "b", "c"], direction: TextShelfDirection.horizontal)));

    // Verify that the login page is displayed
    expect(find.text("a"), findsOneWidget);
    expect(find.text("b"), findsOneWidget);
    expect(find.text("c"), findsOneWidget);

  });

  testWidgets('Should show all items passed in vertical', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(createTestWrapper(const TextShelf(items: ["a", "b", "c"], direction: TextShelfDirection.vertical)));

    // Verify that the login page is displayed
    expect(find.text("a"), findsOneWidget);
    expect(find.text("b"), findsOneWidget);
    expect(find.text("c"), findsOneWidget);

  });


  testWidgets('Should highlighted first element', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(createTestWrapper(const TextShelf(items: ["a", "b", "c"], highlightFirst: true,)));

    var highlightedText = find.text("a").evaluate().single.widget as Text;
    var normalText = find.text("b").evaluate().single.widget as Text;

    // Verify that the login page is displayed
    expect(highlightedText.style != normalText.style, true);

  });


}
