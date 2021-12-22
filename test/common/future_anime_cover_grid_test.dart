import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/common/anime_cover_grid.dart';
import 'package:maki/common/future_anime_cover_grid.dart';
import 'package:maki/common/rounded_cover.dart';
import 'package:maki/models/anime.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../utils.dart';


void main() {

  testWidgets('Should display cover for every item', (WidgetTester tester) async {

    List<Anime> anime = [
      Anime(anilistID: 1, title: "alpha", coverUrl: ""),
      Anime(anilistID: 2, title: "beta", coverUrl: ""),
    ];


    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(FutureAnimeCoverGrid(futureList: Future.value(anime)))));
    // check if there is a skeleton
    expect(find.byType(Skeleton), findsWidgets);

    // await everything loads
    await tester.pump(const Duration(milliseconds: 1));

    // Verify that the login page is displayed
    expect(find.text("alpha"), findsOneWidget);
    expect(find.text("beta"), findsOneWidget);

    expect(find.byType(RoundedCover), findsNWidgets(anime.length));

  });

  testWidgets('Should not display anything if empty list', (WidgetTester tester) async {

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(FutureAnimeCoverGrid(futureList: Future.value([])))));
    // check if there is a skeleton
    expect(find.byType(Skeleton), findsWidgets);

    // await everything loads
    await tester.pump(const Duration(milliseconds: 1));

    expect(find.byType(RoundedCover), findsNothing);

  });

  testWidgets('Should not allow refresh if no callback is set', (WidgetTester tester) async {

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(FutureAnimeCoverGrid(futureList: Future.value([])))));
    // await everything loads
    await tester.pump(const Duration(milliseconds: 1));

    expect(find.byType(RefreshIndicator), findsNothing);

  });

  testWidgets('Should allow refresh if no callback is set', (WidgetTester tester) async {

    await mockNetworkImagesFor(() => tester.pumpWidget(
        createTestWrapper(
            FutureAnimeCoverGrid(
              futureList: Future.value([]),
              onRefreshCallback: () async => { },
            )
        )
    ));
    // await everything loads
    await tester.pump(const Duration(milliseconds: 1));

    expect(find.byType(RefreshIndicator), findsOneWidget);

  });


}
