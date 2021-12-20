import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/footer_info.dart';
import 'package:maki/models/anime_details.dart';

import '../utils.dart';

void main() {



  testWidgets('Should display all infos', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 0, genres: [], studio: "abc", altTitle: "alt", airStartDate: "1", airFinalDate: "2");

    await tester.pumpWidget(createTestWrapper(FooterInfo(anime: anime)));

    // Verify that the login page is displayed
    expect(find.text("Studio"), findsOneWidget);
    expect(find.text("Alternative title"), findsOneWidget);
    expect(find.text("Air Period"), findsOneWidget);

  });


  testWidgets('Should not display air info is not present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 0, genres: [], studio: "abc", altTitle: "alt");

    await tester.pumpWidget(createTestWrapper(FooterInfo(anime: anime)));

    // Verify that the login page is displayed

    expect(find.text("Air Period"), findsNothing);

  });

  testWidgets('Should always display studio', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 0, genres: []);

    await tester.pumpWidget(createTestWrapper(FooterInfo(anime: anime)));

    // Verify that the login page is displayed

    expect(find.text("Studio"), findsOneWidget);

  });

  testWidgets('Should not display alt title if not set', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "",
        score: 0, genres: []);

    await tester.pumpWidget(createTestWrapper(FooterInfo(anime: anime)));

    // Verify that the login page is displayed

    expect(find.text("Alternative title"), findsNothing);

  });


}
