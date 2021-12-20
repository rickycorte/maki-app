import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maki/common/rounded_cover.dart';
import 'package:maki/details_page/shelf.dart';
import 'package:maki/models/anime_character.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../utils.dart';

void main() {

  testWidgets('Should display title', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(const RoundedCover(anilistID: 1, title: "title", url: "",))));

    // Verify that the login page is displayed
    expect(find.text("title"), findsOneWidget);

  });


  testWidgets('Should allow click', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await mockNetworkImagesFor(() => tester.pumpWidget(createTestWrapper(const RoundedCover(anilistID: 1, title: "title", url: "",))));

    // Verify that the login page is displayed
    expect(find.byType(InkWell), findsOneWidget);

  });

}
