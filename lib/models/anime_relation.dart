
// slim version of an anime that keep only track of basing informations to display and load a separate detailed page
import 'package:maki/details_page/shelf.dart';

class AnimeRelation implements IShelfItem {
  final int anilistID;

  final String title;
  final String relation; // eg: parent

  final String coverUrl;

  AnimeRelation({
    required this.anilistID,
    required this.title,
    required this.relation,
    required this.coverUrl
  });

  factory AnimeRelation.fromJson(Map<String, dynamic> json) {
    return AnimeRelation(
      anilistID: json["node"]["id"],
      title: json["node"]["title"]["userPreferred"],
      relation: json["relationType"],
      coverUrl: json["node"]["coverImage"]["large"],
    );
  }

  static List<AnimeRelation> fromJsonArray(Iterable jsonArray, {bool keepOnlyAnime = true}) {
    List<AnimeRelation> result = [];
    for(var item in jsonArray) {

      if(keepOnlyAnime && item["type"] != "ANIME") {
        continue;
      }

      result.add(AnimeRelation.fromJson(item));
    }
    return result;
  }

  @override
  String bottomText() {
    return title;
  }

  @override
  String imageUrl() {
    return coverUrl;
  }

  @override
  String topText() {
    return relation;
  }

}