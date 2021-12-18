import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/common/elevated_rounded.dart';

import 'package:maki/main.dart';

import '../utils.dart';

void main() {
  testWidgets('Counter contain child', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestWrapper(const ElevatedRounded(child: Text("Racconzzz"))));

    // Verify that our counter starts at 0.
    expect(find.text("Racconzzz"), findsOneWidget);

  });
}
