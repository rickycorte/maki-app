
import 'package:flutter/material.dart';
import 'package:maki/details_page/text_shelf.dart';
import 'package:maki/models/anime_details.dart';

import 'elevated_rounded.dart';

class CoverSideInfo extends StatelessWidget {
  final AnimeDetails anime;

  const CoverSideInfo({Key? key, required this.anime}) : super(key: key);

  List<String> _parseAnimeInfo(){
    List<String> values = [];

    values.add(anime.score.toString());

    if(anime.year != null) {
      values.add("${anime.season}\n${anime.year}");
    }
    else {
      values.add(anime.season);
    }

    values.add(anime.airStatus);

    if(anime.format != null) {
      if (anime.episodeCount != null && anime.episodeMinutes != null) {
        values.add("${anime.format}\n${anime.episodeCount} episod${(anime.episodeCount! > 1 ? "es" : "e")} of ${anime
            .episodeMinutes} min");
      } else {
        values.add(anime.format as String);
      }
    } else {
      values.add("Unknown format");
    }

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedRounded(
      child: TextShelf(
        items: _parseAnimeInfo(),
        direction: TextShelfDirection.vertical,
        highlightFirst: true,
      ),
    );
  }

}