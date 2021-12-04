

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maki/models/anime.dart';

import 'anime_cover_grid.dart';

typedef FutureCallback = Future<void> Function();

/// wrapper to Anime grind that accepts futures instead of lists
class FutureAnimeCoverGrid extends StatefulWidget {

  Future<List<Anime>> futureList;

  final int elementsPerRow ;
  final FutureCallback? onRefreshCallback;

  FutureAnimeCoverGrid({Key? key, required this.futureList, this.elementsPerRow = 2, this.onRefreshCallback}) : super(key: key);


  @override
  State<FutureAnimeCoverGrid> createState() => _FutureAnimeCoverGridState();
}

class _FutureAnimeCoverGridState extends State<FutureAnimeCoverGrid> {

  Widget _wrapWithRefreshIfAvailable(Widget child) {
    if(widget.onRefreshCallback != null) {
      return RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: widget.onRefreshCallback as FutureCallback,
        child: child,
      );
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Anime>>(
        future: widget.futureList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _wrapWithRefreshIfAvailable(
               // make this view scrollable to allow refresh in case of issues
                SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                        child: const Center(child: Text('An error has occurred!'),),
                        height: MediaQuery.of(context).size.height,
                    )
                )
            );
          } else if (snapshot.hasData) {
            return _wrapWithRefreshIfAvailable(
              //TODO: empty page
                AnimeCoverGrid(displayData: snapshot.data ?? [])
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}