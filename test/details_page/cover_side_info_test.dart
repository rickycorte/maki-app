import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/cover_side_info.dart';
import 'package:maki/models/anime_details.dart';

import '../utils.dart';

void main() {



  testWidgets('Should display score', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 10, genres: [], studio: "abc", altTitle: "alt", airStartDate: "1", airFinalDate: "2");

    await tester.pumpWidget(createTestWrapper(CoverSideInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("10"), findsOneWidget);

  });

  testWidgets('Should display placeholder text for missing format', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 10, genres: []);

    await tester.pumpWidget(createTestWrapper(CoverSideInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("FORMAT N/A"), findsOneWidget);

  });

  testWidgets('Should display format', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 10, genres: [], format: "TEST");

    await tester.pumpWidget(createTestWrapper(CoverSideInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("TEST"), findsOneWidget);

  });

  testWidgets('Should display air status', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 10, genres: [], airStatus: "TEST");

    await tester.pumpWidget(createTestWrapper(CoverSideInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("TEST"), findsOneWidget);

  });


  testWidgets('Should display season', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 10, genres: [], season: "NOW");

    await tester.pumpWidget(createTestWrapper(CoverSideInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("NOW"), findsOneWidget);

  });

  testWidgets('Should display season and year', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 10, genres: [], season: "NOW", year:1234);

    await tester.pumpWidget(createTestWrapper(CoverSideInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("NOW\n1234"), findsOneWidget);

  });

}
