import 'dart:convert';

import 'anime_character.dart';
import 'anime_relation.dart';

import 'package:http/http.dart' as http;

//Link the app to Maki APi

Future<List<Anime>> fetchRecommendations() async {
  final response = await http
      .get(Uri.parse('https://api.makichan.xyz/anime/anilist/xDevily'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonData = jsonDecode(response.body);

    List<Anime> recommendations = [];

    print("SONO PRIMA DELL ASSEGNAZIONE DI RECOMMENDATIONS");

    //IL PROBLEMA E' NELL'AGGIUNGERE L'ELEMENTO ALLA LISTA

    recommendations.add(Anime.fromJson(jsonData["reccomendatios"][0]));
    //print(Anime.fromJson(jsonData["reccomendatios"][0]));
    //print("Lunghezza lista: ");
    //print(jsonData["reccomendatios"].length);
    print("STO FACENDO VEDERE IL RECOMMENDATIONS");
    print(recommendations);

    for (var rec in jsonData["recommendations"]) {
      recommendations.add(Anime.fromJson(rec));
    }

    print("Sono arrivato dopo il FOR da recommendations");
    return recommendations;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load the file');
  }
}

class Anime {
  final int malID;
  final int anilistID;

  final String title;

  final String coverUrl;

  final int score;
  final int year;
  final String format; // eg: TV

  Anime({
    required this.anilistID,
    required this.title,
    required this.coverUrl,
    required this.score,
    required this.malID,
    required this.year,
    required this.format,
  });

  //Save inside the variables the values which come from the API of Maki and Anilist

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        malID: json['mal'],
        anilistID: json['anilist'],
        title: json['title'],
        coverUrl: json['cover_url'],
        format: json['format'],
        year: json['release_year'],
        score: json['score']);
  }

  //TODO: json constructor
}
