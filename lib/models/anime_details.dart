import 'dart:convert';

import 'anime_character.dart';
import 'anime_relation.dart';

import 'package:http/http.dart' as http;

/*
Future<AnimeDetails> fetchPost() async {
  final response = await http
      .get(Uri.parse('https://api.makichan.xyz/anime/anilist/xDevily'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return AnimeDetails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load the file');
  }
}
*/

class AnimeDetails {
  final int malID;
  final int anilistID;

  final String title;
  final String? altTitle;

  final String description;

  final List<String> genres;

  final String coverUrl;

  final int score;

  final String season; // eg: SUMMER
  final int year;
  final String format; // eg: TV
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
      {required this.anilistID,
      required this.title,
      required this.coverUrl,
      required this.score,
      required this.malID,
      required this.genres,
      required this.year,
      this.altTitle,
      this.description = "",
      this.season = "Unknown",
      this.format = "Unknown",
      this.airStatus = "Unknown",
      this.episodeCount,
      this.episodeMinutes,
      this.studio = "Unknown",
      this.rating = "Unknown",
      this.airStartDate,
      this.airFinalDate,
      this.relations,
      this.characters,
      this.trailerUrl});

  //TODO: json constructor
}
