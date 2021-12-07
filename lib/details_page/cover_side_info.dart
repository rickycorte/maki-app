
import 'package:flutter/material.dart';
import 'package:maki/details_page/text_shelf.dart';
import 'package:maki/models/anime_details.dart';

import 'elevated_rounded.dart';

class CoverSideInfo extends StatelessWidget {
  final AnimeDetails anime;

  final bool horizontal;

  const CoverSideInfo({Key? key, required this.anime, this.horizontal = false}) : super(key: key);

  List<String> _parseAnimeInfo(){
    List<String> values = [];

    values.add(anime.score.toString());

    if(anime.year != null) {
      values.add("${anime.season}\n${anime.year}");
    }
    else {
      values.add(anime.season);
    }

    values.add(anime.airStatus.replaceAll("_", " "));

    if(anime.format != null) {
      if (anime.episodeCount != null && anime.episodeMinutes != null) {
        values.add("${anime.format?.replaceAll("_", " ")}\n${anime.episodeCount} episod${(anime.episodeCount! > 1 ? "es" : "e")} of ${anime
            .episodeMinutes} min");
      } else {
        values.add(anime.format?.replaceAll("_", " ") as String);
      }
    } else {
      values.add("FORMAT N/A");
    }

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedRounded(
      child: TextShelf(
        items: _parseAnimeInfo(),
        direction: horizontal? TextShelfDirection.horizontal : TextShelfDirection.vertical,
        highlightFirst: true,
      ),
    );
  }

}