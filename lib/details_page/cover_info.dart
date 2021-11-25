import 'package:flutter/material.dart';
import 'package:maki/models/anime_details.dart';

//TODO: ho mosso tutto il blocco superiore fino alla descrizione cosi possiamo alterare facilmente tutto il layout di questi elementi

class CoverInfo extends StatelessWidget {
  AnimeDetails anime;

  CoverInfo({Key? key, required this.anime}) : super(key: key);

  Widget _roundedCover(String url, {double radius = 10}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(url, fit: BoxFit.fill),
    );
  }

  Widget _scoreAndSeasonInfo(context,
      {Alignment containerAlignment = Alignment.topRight,
      TextAlign textAlignment = TextAlign.right}) {
    String scoreText = "SCORE\n${anime.score}";
    String seasonText =
        "SEASON\n${anime.season} ${anime.year ?? "Unknown year"}";
    String formatText = "FORMAT\n${anime.format ?? "Unknown format"}";

    if (anime.episodeCount != null && anime.episodeMinutes != null) {
      formatText += "\n${anime.episodeCount} eps of ${anime.episodeMinutes}min";
    }

    String statusText = "STATUS\n${anime.airStatus}";

    final theme = Theme.of(context);

    return Container(
        alignment: containerAlignment,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                scoreText,
                textAlign: textAlignment,
                style: theme.textTheme.headline6,
              ),
            ),
            Text(
              seasonText,
              textAlign: textAlignment,
              style: theme.textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            Text(
              formatText.replaceAll("_", " "),
              textAlign: textAlignment,
              style: theme.textTheme.bodyText1,
            ),
            const SizedBox(height: 10),
            Text(
              statusText.replaceAll("_", " "),
              textAlign: textAlignment,
              style: theme.textTheme.bodyText1,
            ),
          ],
        ));
  }

  Widget _buildTitleBlock(context) {
    // prepare data to output
    String formattedGenres = "";
    for (int i = 0; i < anime.genres.length; i++) {
      formattedGenres += " - " + anime.genres[i];
    }

    formattedGenres = formattedGenres.isNotEmpty ? formattedGenres.substring(3) : formattedGenres; // remove the " - " characters added by the first element

    return Container(
        alignment: Alignment.center,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            anime.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          if (formattedGenres.isNotEmpty)
            Text(
              formattedGenres,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
            ),
        ]));
  }

  @override
  Widget build(BuildContext context) {

    const elementPadding = 20.0;

    return Column(children: [
      IntrinsicHeight(
          child: Row(
        children: [
          // image
          Expanded(child: _roundedCover(anime.coverUrl)),
          // side infos
          Expanded(child: _scoreAndSeasonInfo(context))
        ],
      )),
      const SizedBox(height: elementPadding),
      _buildTitleBlock(context),

      const SizedBox(height: elementPadding),
      Text(
        anime.description.replaceAll("<br>", "\n").replaceAll(RegExp(r"<\/?b>|<\/?i>"), ""),
        textAlign: TextAlign.center,
      )

    ]);
  }
}
