import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/anime_base_info.dart';
import 'package:maki/details_page/text_shelf.dart';
import 'package:maki/models/anime_details.dart';

import '../utils.dart';

void main() {


  testWidgets('Should display title', (WidgetTester tester) async {
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: []);

    await tester.pumpWidget(createTestWrapper(Material(child: AnimeBaseInfo(anime: anime,))));

    // Verify that the login page is displayed
    expect(find.text("alpha"), findsOneWidget);

  });

  testWidgets('Should display description', (WidgetTester tester) async {
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], description: "hallo!");

    await tester.pumpWidget(createTestWrapper(Material(child: AnimeBaseInfo(anime: anime,))));

    // Verify that the login page is displayed
    expect(find.text("hallo!"), findsOneWidget);

  });

  testWidgets('Should display genres', (WidgetTester tester) async {
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: ["genre1", "genre2"]);

    await tester.pumpWidget(createTestWrapper(Material(child: AnimeBaseInfo(anime: anime,))));

    // Verify that the login page is displayed
    expect(find.textContaining("genre1"), findsOneWidget);
    expect(find.textContaining("genre2"), findsOneWidget);

  });


}
