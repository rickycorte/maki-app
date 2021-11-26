
import 'package:maki/details_page/shelf.dart';

class AnimeCharacter implements IShelfItem {

  final String name;
  final String pictureUrl;
  final String role;

  AnimeCharacter({required this.name, required this.pictureUrl, required this.role});


  AnimeCharacter.fromJson(Map<String, dynamic> json) :
      name = json["node"]["name"]["userPreferred"],
      pictureUrl = json["node"]["image"]["large"],
      role = json["role"]
  ;

  static List<AnimeCharacter> fromJsonArray(Map<String, dynamic> json) {

    if(json == null || json["edges"] == null) {
      return [];
    }

    Iterable arr = json["edges"] as Iterable;

    List<AnimeCharacter> res = [];
    for(var character in arr) {
      var c = AnimeCharacter.fromJson(character);
      res.add(c);
    }

    return res;
  }


  @override
  String bottomText() {
    return name;
  }

  @override
  String imageUrl() {
    return pictureUrl;
  }

  @override
  String topText() {
    return role;
  }



}