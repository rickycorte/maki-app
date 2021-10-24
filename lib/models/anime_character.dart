
class AnimeCharacter {

  final String name;
  final String pictureUrl;

  AnimeCharacter({required this.name, required this.pictureUrl});

  // import data from json
  // TODO: look for anilist api for naming
  AnimeCharacter.fromJson(Map<String, dynamic> json) :
      name = json["..."],
      pictureUrl = json["..."];


}