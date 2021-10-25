import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';
import 'package:maki/models/anime.dart';

// use a steteful page because we may load anime data later than the actual page so a refresh may be needed
class AnimeDetailsPage extends StatefulWidget {
  Anime? animeData;

  AnimeDetailsPage(Key? key, int anilistID) : super(key: key) {
    print("We should call Anilist api with: " + anilistID.toString());
  }

  AnimeDetailsPage.fromPrefetchedAnime({Key? key, required this.animeData})
      : super(key: key);

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            // image + side informations
            IntrinsicHeight(
                child: Row(
              children: [
                // image
                Expanded(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.animeData!.coverUrl,
                      fit: BoxFit.fill),
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
                                  "Score\n"+widget.animeData!.score.toString(),
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Text("SEASON\n"+widget.animeData!.season.toUpperCase() + " " + widget.animeData!.year.toString(), textAlign: TextAlign.right),
                            const SizedBox(height: 10),
                            Text("FORMAT\n"+widget.animeData!.format + " - " + widget.animeData!.episodeCount.toString() + " of " + widget.animeData!.episodeMinutes.toString(), textAlign: TextAlign.right),
                            const SizedBox(height: 10),
                            Text("STATUS\n"+widget.animeData!.airStatus, textAlign: TextAlign.right),


                          ],
                        )))
              ],
            )),
            const SizedBox(height: 10),

            //title and genres
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Text(widget.animeData!.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6,),
                Text(widget.animeData!.genres.toString().replaceAll(",", " -").replaceFirst("[", "").replaceFirst("]","") , textAlign: TextAlign.center,) // TODO: replace this shit with a proper function
                ]
            )
            )
          ],
        ));
  }
}
