import 'dart:ui';

import 'package:flutter/material.dart';

class RoundedCover extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  //I ':' vengono utilizzati per far svolgere la parte di codice prima che venga chiamato il costruttore della classe padre
  //cioè quella che viene estesa

  final String url;

  const RoundedCover({Key? key, required this.url}) : super(key: key);

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
          Ink.image(
            image: NetworkImage(widget.url),
            child: InkWell(
              onTap: () {},
            ),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
