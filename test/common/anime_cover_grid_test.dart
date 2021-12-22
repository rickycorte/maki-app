import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/common/anime_cover_grid.dart';
import 'package:maki/common/rounded_cover.dart';
import 'package:maki/models/anime.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../utils.dart';

void main() {

  testWidgets('Should display cover for every item', (WidgetTester tester) async {
    List<Anime> animes = [
      Anime(anilistID: 1, title: "alpha", coverUrl: ""),
      Anime(anilistID: 2, title: "beta", coverUrl: ""),
    ];

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(AnimeCoverGrid(displayData: animes,))));

    // Verify that the login page is displayed
    expect(find.text("alpha"), findsOneWidget);
    expect(find.text("beta"), findsOneWidget);

    expect(find.byType(RoundedCover), findsNWidgets(animes.length));

  });

  testWidgets('Should not display anything if empty list', (WidgetTester tester) async {

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(AnimeCoverGrid(displayData: [],))));

    expect(find.byType(RoundedCover), findsNothing);

  });

}
