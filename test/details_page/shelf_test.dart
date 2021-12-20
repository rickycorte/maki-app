import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/shelf.dart';
import 'package:maki/models/anime_character.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../utils.dart';

void main() {

  testWidgets('Should display title', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(createTestWrapper(Shelf(title:"title", items: const [])));

    // Verify that the login page is displayed
    expect(find.text("title"), findsOneWidget);

  });


  testWidgets('Should display all items', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    List<AnimeCharacter> items = [
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role"),
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role")
    ];

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(Shelf(title:"title", items: items))));

    // Verify that the login page is displayed
    expect(find.text("a"), findsNWidgets(items.length));
    expect(find.text("role"), findsNWidgets(items.length));

  });

  testWidgets('Should not allow click if no callback is passed', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    List<AnimeCharacter> items = [
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role"),
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role")
    ];

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(Shelf(title:"title", items: items))));

    // Verify that the login page is displayed
    expect(find.byType(GestureDetector), findsNothing);
  });
  

  testWidgets('Should allow click on every item', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    List<AnimeCharacter> items = [
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role"),
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role")
    ];

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(Shelf(title:"title", items: items, onItemPressed: (id) => {},))));

    // Verify that the login page is displayed
    expect(find.byType(GestureDetector), findsNWidgets(items.length));
  });

  testWidgets('Should not display title if not set', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    List<AnimeCharacter> items = [
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role"),
      AnimeCharacter(name: "a", pictureUrl: "img-url", role: "role")
    ];

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(Shelf(items: items, onItemPressed: (id) => {},))));

    // Verify that the login page is displayed
    expect(find.byType(Text), findsNWidgets(items.length * 2)); // 2 texts for every item excluding title

  });

}
