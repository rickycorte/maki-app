

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maki/models/anime.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

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

  List<Widget> _repeatWiget(Widget widget, int times){
    List<Widget> res = [];
    for(int i = 0; i < times; i++){
      res.add(widget);
    }
    return res;
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
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: Image.asset("assets/images/sorry.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'Sorry, something went wrong on our side.\nPlease retry!',
                                    style: Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                          ),
                        ),
                        height: MediaQuery.of(context).size.height,
                    )
                )
            );
          } else if (snapshot.hasData) {
            return _wrapWithRefreshIfAvailable(
              //TODO: empty page
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: AnimeCoverGrid(displayData: snapshot.data ?? []),
                )
            );
          } else {
            return GridView.count(
                  crossAxisCount: widget.elementsPerRow,
                  childAspectRatio: 1/1.5,
                  children: _repeatWiget(
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            child: Skeleton()
                        )
                    )
                , 12),
              );
          }
        });
  }
}