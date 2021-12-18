import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/youtube_embedded.dart';

import 'package:maki/main.dart';

import '../utils.dart';

void main() {

  testWidgets('Should show youtube thumbnail', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestWrapper(YoutubeEmbedded(url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',)));

    // Verify that our counter starts at 0.
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Should display error text when broken link', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestWrapper(YoutubeEmbedded(url: 'https://www.google.com/',)));

    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('Should be clickable if valid link', (WidgetTester tester) async {

    // Build our app and trigger a frame.
    await tester.pumpWidget(createTestWrapper(YoutubeEmbedded(url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',)));

    await tester.tap(find.byType(GestureDetector));

  });
}
