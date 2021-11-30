

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maki/models/anime.dart';

import 'anime_cover_grid.dart';

/// wrapper to Anime grind that accepts futures instead of lists
class FutureAnimeCoverGrid extends StatefulWidget {

  Future<List<Anime>> futureList;

  FutureAnimeCoverGrid({Key? key, required this.futureList}) : super(key: key);


  @override
  State<FutureAnimeCoverGrid> createState() => _FutureAnimeCoverGridState();
}

class _FutureAnimeCoverGridState extends State<FutureAnimeCoverGrid> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Anime>>(
        future: widget.futureList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return AnimeCoverGrid(displayData: snapshot.data ?? []);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}