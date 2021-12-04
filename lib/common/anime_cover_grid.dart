import 'package:flutter/material.dart';
import 'package:maki/details_page/details_page.dart';
import 'package:maki/models/anime.dart';
import 'package:maki/common/rounded_cover.dart';

class AnimeCoverGrid extends StatefulWidget implements PreferredSizeWidget {
  List<Anime> displayData = [];

  final int elementsPerRow;

  AnimeCoverGrid({Key? key, required this.displayData, this.elementsPerRow = 2}) : super(key: key);

  @override
  _AnimeCoverGridState createState() => _AnimeCoverGridState();

  @override
  Size get preferredSize => throw UnimplementedError();
}


class _AnimeCoverGridState extends State<AnimeCoverGrid> {
  // e tappando sulla card poi viene aperta la pagina dei details
  // TODO: cache images locally
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
    // TODO: empty list page
    return GridView.count(
        crossAxisCount: widget.elementsPerRow,
        childAspectRatio: 1/1.5,
        children: widget.displayData.map((e) => _makeAnimeCard(e)).toList());
  }
}
