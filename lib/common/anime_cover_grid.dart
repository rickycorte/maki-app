import 'package:flutter/material.dart';
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

class _AnimeCoverGridState extends State<AnimeCoverGrid> {

  //TODO:
  // fare le card con la cover stondata come nella pagina dei details
  // in basso mettiamo poi il titolo
  // e tappando sulla card poi viene aperta la pagina dei details
  Widget _makeAnimeCard(Anime anime) {
    return Card(
        elevation: 10,
        child: new Container(
          child: new Text("${anime.title}"),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: widget.displayData.map((e) => _makeAnimeCard(e)).toList()
    );
  }
}
