
// slim version of an anime that keep only track of basing informations to display and load a separate detailed page
class AnimeRelation {
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

  // TODO: make json constructor

}