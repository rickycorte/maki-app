import 'package:flutter/material.dart';
import 'package:maki/models/anime_details.dart';
import 'package:maki/models/user.dart';

class CoverInfo extends StatefulWidget {
  AnimeDetails? anime;

  CoverInfo({Key? key, required this.anime}) : super(key: key);

  @override
  State<CoverInfo> createState() => CoverInfoState();
}

class CoverInfoState extends State<CoverInfo> {
  //variabile per tener conto delle linee da far vedere nella descrizione dell'anime
  int? number_of_line = null;

  //Variabile per nascondere la descrizione con effetto fade oppure no
  TextOverflow descripton_exposure = TextOverflow.visible;

  //Variabile per controllare la forma del botton con cui nascondere la descrizione
  IconData botton_description = Icons.keyboard_arrow_down_outlined;

  Widget _roundedCover(String url, {double radius = 10}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(url, fit: BoxFit.fill),
    );
  }

  Widget _scoreAndSeasonInfo(context,
      {Alignment containerAlignment = Alignment.topRight,
      TextAlign textAlignment = TextAlign.right}) {
    String scoreText = "SCORE\n${widget.anime!.score}";
    String seasonText =
        "SEASON\n${widget.anime!.season} ${widget.anime!.year ?? "Unknown year"}";
    String formatText = "FORMAT\n${widget.anime!.format ?? "Unknown format"}";

    if (widget.anime!.episodeCount != null &&
        widget.anime!.episodeMinutes != null) {
      formatText +=
          "\n${widget.anime!.episodeCount} eps of ${widget.anime!.episodeMinutes}min";
    }

    String statusText = "STATUS\n${widget.anime!.airStatus}";

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
    for (int i = 0; i < widget.anime!.genres.length; i++) {
      formattedGenres += " - " + widget.anime!.genres[i];
    }

    formattedGenres = formattedGenres.isNotEmpty
        ? formattedGenres.substring(3)
        : formattedGenres; // remove the " - " characters added by the first element

    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              widget.anime!.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          if (formattedGenres.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                formattedGenres,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          SizedBox(
            height: 45.0,
            child: ElevatedButton(
              onPressed: () => User.current!.addToPlanning(widget.anime!),
              child: const Text("Add To My List"),
            ),
          ),
        ],
      ),
    );
  }

  //Funzione per cambiare lo stato per nascondere o no la descrizione
  void updateDescription() {
    setState(
      () {
        if (number_of_line == null) {
          number_of_line = 3;
          descripton_exposure = TextOverflow.fade;
          botton_description = Icons.keyboard_arrow_down_outlined;
        } else {
          number_of_line = null;
          descripton_exposure = TextOverflow.visible;
          botton_description = Icons.keyboard_arrow_up_outlined;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const elementPadding = 20.0;

    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              // image
              Expanded(child: _roundedCover(widget.anime!.coverUrl)),
              // side infos
              Expanded(child: _scoreAndSeasonInfo(context))
            ],
          ),
        ),
        const SizedBox(height: elementPadding),
        _buildTitleBlock(context),
        const SizedBox(height: elementPadding),
        Text(
          widget.anime!.description
              .replaceAll("<br>", "\n")
              .replaceAll(RegExp(r"<\/?b>|<\/?i>"), ""),
          overflow: descripton_exposure,
          maxLines: number_of_line,
          textAlign: TextAlign.center,
        ),
        Center(
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            // ignore: prefer_const_constructors
            child: SizedBox(
              height: 22.0,
              width: 55.0,
              child: IconButton(
                // ignore: prefer_const_constructors
                icon: Icon(
                  botton_description,
                  size: 25,
                  color: Colors.black,
                ),
                onPressed: () {
                  updateDescription();
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
