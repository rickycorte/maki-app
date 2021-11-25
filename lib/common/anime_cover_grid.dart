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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AnimeDetailsPage(anilistID: anime.anilistID,))
        );
      },

      child: RoundedCover(url: anime.coverUrl, title: anime.title,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1/1.5,
        children: widget.displayData.map((e) => _makeAnimeCard(e)).toList());
  }
}
