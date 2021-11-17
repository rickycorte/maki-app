import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';
import 'package:maki/details_page/youtube_embedded.dart';
import 'package:maki/models/anime_details.dart';

import 'cover_info.dart';

// use a steteful page because we may load anime data later than the actual page so a refresh may be needed
class AnimeDetailsPage extends StatefulWidget {
  AnimeDetails? animeData;

  AnimeDetailsPage(Key? key, int anilistID) : super(key: key) {
    print("We should call Anilist api with: " + anilistID.toString());
  }

  AnimeDetailsPage.fromPrefetchedAnime({Key? key, required this.animeData})
      : super(key: key);
  
  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

// state item
class _AnimeDetailsPageState extends State<AnimeDetailsPage> {

  @override
  Widget build(BuildContext context) {
    const elementPadding = 20.0;

    List<Widget> pageElements = [CoverInfo(anime: widget.animeData as AnimeDetails)]; // top info are guaranteed to be present

    if(widget.animeData?.trailerUrl != null) {
      pageElements.add(const SizedBox(height: elementPadding));
      pageElements.add(YoutubeEmbedded(url: widget.animeData?.trailerUrl ?? ""));
    }

      return Scaffold(
          appBar: const CustomAppBar(
            showBackButton: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(10.0),
            children: pageElements,
          ));
  }
}
