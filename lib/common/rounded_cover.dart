import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

class RoundedCover extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  //I ':' vengono utilizzati per far svolgere la parte di codice prima che venga chiamato il costruttore della classe padre
  //cioè quella che viene estesa

  final String url;
  final String title;

  const RoundedCover({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _CustomRoundedCoverState createState() => _CustomRoundedCoverState();
}

class _CustomRoundedCoverState extends State<RoundedCover> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top:0,
            bottom: 0,
            right: 0,
            left:0,
            child: CachedNetworkImage(
              imageUrl: widget.url,
              fit: BoxFit.fill,
              placeholder: (ctz, progress) => Skeleton(),
            ),
          ),
          Positioned(
              bottom: 0,
              left:0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0)],
                        begin: const Alignment(0,0),
                        end: const Alignment(0,-1),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top:15.0, bottom: 10.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,),
                ),
            )
          )
        ],
      ),
    );
  }
}
