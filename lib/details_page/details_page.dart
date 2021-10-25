import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';
import 'package:maki/models/anime.dart';


// use a steteful page because we may load anime data later than the actual page so a refresh may be needed
class AnimeDetailsPage extends StatefulWidget
{

  Anime? animeData;

  AnimeDetailsPage(Key? key, int anilistID) : super(key: key)
  {
    print("We should call Anilist api with: "+ anilistID.toString());
  }

  AnimeDetailsPage.fromPrefetchedAnime({Key? key, required this.animeData}) : super(key: key);

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}


class _AnimeDetailsPageState extends State<AnimeDetailsPage>
{
  @override
  Widget build(BuildContext context) {

    return Scaffold (
      appBar: const CustomAppBar(showBackButton: true,),
      body: Text(widget.animeData!.title)
    );
  }

}