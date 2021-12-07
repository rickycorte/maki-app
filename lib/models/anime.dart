import 'dart:convert';

import 'package:http/http.dart' as http;

//Link the app to Maki APi

Future<List<Anime>> fetchRecommendations(String username) async {
  final response = await http
      .get(Uri.parse('https://api.makichan.xyz/anime/anilist/$username?k=12'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable jsonData = jsonDecode(response.body)["recommendations"];

    return List<Anime>.from(jsonData.map((obj) => Anime.fromJson(obj)));

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    //TODO: creare una classe apposta per l'eccezione; servono classi per gli errori proprio di connettivita e classi per quando ci sono errori nella richiesta
    throw Exception('Failed to load the file');
  }
}

class Anime {
  final int? malID;
  final int anilistID;

  final String title;

  final String coverUrl;

  final int score;
  final int? year;
  final String? format; // eg: TV

  int? entryID; // anilist API related

  Anime({
    required this.anilistID,
    required this.title,
    required this.coverUrl,
    this.score = 0,
    this.malID,
    this.year,
    this.format,
    this.entryID,
  });


  bool isInUserList() {
    return entryID != null;
  }

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
        malID: json['mal'],
        anilistID: json['anilist'],
        title: json['title'],
        coverUrl: json['cover_url'],
        format: json['format'],
        year: json['release_year'],
        score: json['score'] ?? 0
    );
  }

  @override
  String toString() {
    return "<Anime $anilistID - $title>";
  }

}
