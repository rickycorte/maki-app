

import 'package:maki/models/anime.dart';

class AnimeList {

  List<Anime> completed;
  List<Anime> watching;
  List<Anime> planning;
  List<Anime> dropped;

  AnimeList(
      {required this.completed, required this.watching, required this.planning, required this.dropped});

  factory AnimeList.fromAnilist(Map<String, dynamic> json) {

    // check some nulls
    if(json["data"] == null || json["data"]["MediaListCollection"] == null || json["data"]["MediaListCollection"]["lists"] == null) {
      return AnimeList(completed: [], watching: [], planning: [], dropped: []);
    }

    List<Anime> completed = [];
    List<Anime> watching = [];
    List<Anime> planning = [];
    List<Anime> dropped = [];

    // parse the ugly super nested json returned by anilist api
    Iterable listContainer = json["data"]["MediaListCollection"]["lists"];

    for(var subList in listContainer) {
      for(var entry in subList["entries"]) {
         // parse bare minimum data to make the cover page
          var anime = Anime(
              anilistID: entry["mediaId"],
              title: entry["media"]["title"]["userPreferred"],
              coverUrl: entry["media"]["coverImage"]["large"]
          );
          
          //skip adult
          if(entry["media"]["isAdult"]) {
            continue;
          }

          // add to correct sublist
          switch(entry["status"]) {
            case "COMPLETED":
              completed.add(anime);
              break;
            case "PLANNING":
              planning.add(anime);
              break;
            case "DROPPED":
              dropped.add(anime);
              break;
            case "CURRENT":
              watching.add(anime);
              break;
          }
      }
    }

    return AnimeList(completed: completed, watching: watching, planning: planning, dropped: dropped);

  }

}