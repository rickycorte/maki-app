import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

import 'anime.dart';
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
        this.airStartDate,
        this.airFinalDate,
        this.relations,
        this.characters,
        this.trailerUrl
      }) : super(
        anilistID: anilistID,
        malID: malID,
        title: title ?? altTitle,
        coverUrl: coverUrl,
        year: year,
        format: format,
        score: score,
      );

    static String? _parseTrailer(Map<String, dynamic> json){
      return json["trailer"] != null && json["trailer"]["site"] == "youtube" ? json["trailer"]["id"] : null;
    }

    static String _fmtDate(Map<String, dynamic> json) {

      if(json == null || json["day"] == null || json["month"] == null || json["year"] == null) {
        return "Unknown";
      }

      return "${json["day"]}/${json["month"]}/${json["year"]}";
    }

    static String _mainStudio(Map<String, dynamic> json) {
      if(json == null || json["edges"] == null || json["edges"].isNotEmpty) {
        return "Unknown Studio";
      }

      return json["edges"][0]["node"]["name"]; //TODO: check for main
    }

    factory AnimeDetails.fromAnilistJson(Map<String, dynamic> json) {
      return AnimeDetails(
          anilistID: json["id"],
          title: json["title"]["english"],
          coverUrl: json["coverImage"]["extraLarge"],
          score: json["meanScore"] ?? 0,
          year: json["seasonYear"],
          format: json["format"],
          genres: json["genres"].cast<String>(),
          altTitle: json["title"]["romaji"],
          season: json["season"] ?? "Unknown",
          airStatus: json["status"] ?? "Unknown",
          description: json["description"] ?? "",
          episodeCount: json["episodes"],
          episodeMinutes: json["duration"],
          trailerUrl: _parseTrailer(json),

          // TODO: parse the main one only (the 0 one should be the main but i'm not sure)
          studio:  _mainStudio(json["studios"]),

          //TODO: fix null cases
          airStartDate: _fmtDate(json["startDate"]),
          airFinalDate: _fmtDate(json["endDate"]),

          //TODO: parse them in their own classes
          relations: AnimeRelation.fromJsonArray(json["relations"]["edges"]),
          characters: null,

      );
    }
}


const _anilist_fetch_query = """
query media(\$id: Int, \$type: MediaType, \$isAdult: Boolean) {
  Media(id: \$id, type: \$type, isAdult: \$isAdult) {
    id
    title {
      english
      romaji
    }
    coverImage {
      extraLarge
    }
    startDate {
      year
      month
      day
    }
    endDate {
      year
      month
      day
    }
    description
    season
    seasonYear
    type
    format
    status(version: 2)
    episodes
    duration
    genres
    meanScore
    popularity
    relations {
      edges {
        id
        relationType(version: 2)
        node {
          id
          title {
            userPreferred
          }
          format
          type
          coverImage {
            large
          }
        }
      }
    }
    characterPreview: characters(perPage: 6, sort: [ROLE, RELEVANCE, ID]) {
      edges {
        id
        role
        node {
          id
          name {
            userPreferred
          }
          image {
            large
          }
        }
      }
    }
    studios {
      edges {
        isMain
        node {
          id
          name
        }
      }
    }

    trailer {
      id
      site
    }
    mediaListEntry {
      id
      status
      score
    }
  }
}
""";

Future<AnimeDetails> fetchAnimeDetails(int animeID) async {
  final response = await http.post(
    Uri.parse('https://graphql.anilist.co/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body:  jsonEncode({
      "query": _anilist_fetch_query,
      "variables": { "id": animeID }
    })
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var jsonData = jsonDecode(response.body)["data"]["Media"];

    return AnimeDetails.fromAnilistJson(jsonData);

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    //TODO: creare una classe apposta per l'eccezione; servono classi per gli errori proprio di connettivita e classi per quando ci sono errori nella richiesta
    throw Exception('Failed to load the file');
  }
}
