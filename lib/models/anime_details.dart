import 'dart:convert';

import 'package:maki/models/anime.dart';

import 'anime_character.dart';
import 'anime_relation.dart';

class AnimeDetails extends Anime {

  final String? altTitle;

  final String description;

  final List<String> genres;


  final String season; // eg: SUMMER
  final String airStatus; // eg: completed

  final int? episodeCount;
  final int? episodeMinutes;

  final String studio;

  final String rating;

  final String? airStartDate;
  final String? airFinalDate;

  final List<AnimeRelation>? relations;
  final List<AnimeCharacter>? characters;

  final String? trailerUrl;

  AnimeDetails(
      {
        // parent values
        required anilistID,
        required title,
        required coverUrl,
        int score = 0,
        int? malID,
        int? year,
        String? format,
        // child
        required this.genres,
        this.altTitle,
        this.description = "",
        this.season = "Unknown",

        this.airStatus = "Unknown",
        this.episodeCount,
        this.episodeMinutes,
        this.studio = "Unknown",
        this.rating = "Unknown",
        this.airStartDate,
        this.airFinalDate,
        this.relations,
        this.characters,
        this.trailerUrl
      }) : super(
        anilistID: anilistID,
        malID: malID,
        title: title,
        coverUrl: coverUrl,
        year: year,
        format: format,
        score: score,
      );

  //TODO: json constructor
}
