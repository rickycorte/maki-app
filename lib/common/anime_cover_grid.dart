import 'package:flutter/material.dart';
import 'package:maki/details_page/details_page.dart';
import 'package:maki/models/anime.dart';

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
  //TODO:
  // fare le card con la cover stondata come nella pagina dei details
  // in basso mettiamo poi il titolo
  // e tappando sulla card poi viene aperta la pagina dei details
  Widget _makeAnimeCard(Anime anime) {
    return GestureDetector(
      onTap: () {},
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
      child: Card(
        elevation: 10,
        child: new Container(
          child: Image.network(anime.coverUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        children: widget.displayData.map((e) => _makeAnimeCard(e)).toList());
  }
}
