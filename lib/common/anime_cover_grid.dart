import 'package:flutter/material.dart';
import 'package:maki/details_page/details_page.dart';
import 'package:maki/models/anime.dart';
import 'package:maki/common/rounded_cover.dart';

class AnimeCoverGrid extends StatefulWidget implements PreferredSizeWidget {
  List<Anime> displayData = [];

  AnimeCoverGrid({Key? key, required this.displayData}) : super(key: key);

  @override
  _AnimeCoverGridState createState() => new _AnimeCoverGridState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

// CREARE WIDGET CHE MI RESTITUISCE LA DETAILS PAGE DELL'ANIME CORRISPONDENTE

class _AnimeCoverGridState extends State<AnimeCoverGrid> {
  // e tappando sulla card poi viene aperta la pagina dei details
  Widget _makeAnimeCard(Anime anime) {
    return GestureDetector(
      onTap: () {
        print("HO PREMUTO SU UNA CASELLA");
      },
      /*  {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    //QUESTO VA BENE SOLO CHE SERVE LA CLASSE ANIME_DETAILS , POI MEDIANTE QUELLA SI POSSONO
                    //RISALIRE A TUTTI I DETTAGLI MEDIANTE L'ANIME
                    //
                    //
                    //CREARE FUNZIONE O METODO CHE RICAVA L'ANIME DETAILS DAL NOME ANIME
                    AnimeDetailsPage.fromPrefetchedAnime(animeData: anime)))
      },
      */
      child: RoundedCover(url: anime.coverUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: widget.displayData.map((e) => _makeAnimeCard(e)).toList());
  }
}
