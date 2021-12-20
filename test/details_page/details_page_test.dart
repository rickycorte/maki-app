import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/details_page/anime_base_info.dart';
import 'package:maki/details_page/cover_side_info.dart';
import 'package:maki/details_page/details_page.dart';
import 'package:maki/details_page/footer_info.dart';
import 'package:maki/details_page/shelf.dart';
import 'package:maki/details_page/youtube_embedded.dart';

import 'package:maki/main.dart';
import 'package:maki/models/anime_character.dart';
import 'package:maki/models/anime_details.dart';
import 'package:maki/models/anime_relation.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../utils.dart';

void main() {


  testWidgets('Should always show base layout', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: ["genre1", "genre2"]);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(AnimeBaseInfo), findsOneWidget);
    expect(find.byType(CoverSideInfo), findsOneWidget);
    expect(find.byType(FooterInfo), findsOneWidget);

    // check the title to be sure the data is correct
    expect(find.text("alpha"), findsOneWidget);
  });


  testWidgets('Should show video if present', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], trailerUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ");

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(YoutubeEmbedded), findsOneWidget);

  });

  testWidgets('Should not show video if missing', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: []);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(YoutubeEmbedded), findsNothing);

  });

  testWidgets('Should show shelf for characters', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], characters: [AnimeCharacter(name: "pinco", pictureUrl: "", role: "yep")]);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(Shelf), findsOneWidget);

  });

  testWidgets('Should not show shelf for character if empty list', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], characters: []);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(Shelf), findsNothing);
  });


  testWidgets('Should not show shelf for character if missing', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: []);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(Shelf), findsNothing);
  });


  testWidgets('Should show shelf for anime relations', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], relations: [AnimeRelation(title: "", coverUrl: "", anilistID: 1, relation: "b")]);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(Shelf), findsOneWidget);
  });


  testWidgets('Should not show shelf for anime relations if empty list', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], relations: []);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(Shelf), findsNothing);
  });

  testWidgets('Should not show shelf for anime relations if null', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: []);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.byType(Shelf), findsNothing);
  });


  testWidgets('Should show allow interactions for anime relations shelf', (WidgetTester tester) async {

    AnimeDetails anime = AnimeDetails(anilistID: 1, malID: 1, coverUrl: "", title: "alpha",
        score: 10, genres: [], relations: [AnimeRelation(title: "", coverUrl: "", anilistID: 1, relation: "b")]);

    // Build our app and trigger a frame.
    await mockNetworkImagesFor(() =>  tester.pumpWidget(createTestWrapper(AnimeDetailsPage.fromPrefetchedAnime(animeData: anime))));

    expect(find.descendant(of: find.byType(Shelf), matching: find.byType(GestureDetector)), findsOneWidget);
  });

}
