import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';
import 'package:maki/models/anime_details.dart';

// use a steteful page because we may load anime data later than the actual page so a refresh may be needed
class AnimeDetailsPage extends StatefulWidget {
  AnimeDetails? animeData;

  AnimeDetailsPage(Key? key, int anilistID) : super(key: key) {
    print("We should call Anilist api with: " + anilistID.toString());
  }

  AnimeDetailsPage.fromPrefetchedAnime({Key? key, required this.animeData})
      : super(key: key);

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

// state item
class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  // build the cover hear line with anime cover + side data
  Widget _buildCoverWithSideInfo() {
    String scoreText = "SCORE\n" + widget.animeData!.score.toString();
    String seasonText = "SEASON\n" +
        widget.animeData!.season +
        " " +
        widget.animeData!.year.toString();
    String formatText = "FORMAT\n" + widget.animeData!.format;
    if (widget.animeData!.episodeCount != null &&
        widget.animeData!.episodeMinutes != null) {
      formatText += " - " + widget.animeData!.episodeCount.toString();
      formatText +=
          " eps of " + widget.animeData!.episodeMinutes.toString() + "min";
    }

    String statusText = "STATUS\n" + widget.animeData!.airStatus;

    return IntrinsicHeight(
        child: Row(
      children: [
        // image
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(widget.animeData!.coverUrl, fit: BoxFit.fill),
        )),
        // side infos
        Expanded(
            child: Container(
                alignment: Alignment.topRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        scoreText,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(seasonText, textAlign: TextAlign.right),
                    const SizedBox(height: 10),
                    Text(formatText, textAlign: TextAlign.right),
                    const SizedBox(height: 10),
                    Text(statusText, textAlign: TextAlign.right),
                  ],
                )))
      ],
    ));
  }

  // build block with title and genres under
  Widget _buildTitleBlock() {
    // prepare data to output
    String formattedGenres = "";
    for (int i = 0; i < widget.animeData!.genres.length; i++) {
      formattedGenres += " - " + widget.animeData!.genres[i];
    }

    formattedGenres = formattedGenres
        .substring(3); // remove the " - " characters added by the first element

    return Container(
        alignment: Alignment.center,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text(
            widget.animeData!.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          if (formattedGenres.isNotEmpty)
            Text(
              formattedGenres,
              textAlign: TextAlign.center,
            ),
        ]));
  }

  Widget _buildCollapsableDescription() {
    return Text(
      widget.animeData!.description,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const elementPadding = 20.0;

    return Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            // image + side informations
            _buildCoverWithSideInfo(),
            const SizedBox(height: elementPadding),

            //title and genres
            _buildTitleBlock(),

            const SizedBox(height: elementPadding),

            _buildCollapsableDescription(),
          ],
        ));
  }
}
