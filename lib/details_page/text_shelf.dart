
import 'package:flutter/material.dart';

enum TextShelfDirection { horizontal, vertical }

// heavenly space text items in one row/column
class TextShelf extends StatelessWidget {

  final TextShelfDirection direction;
  final List<String> items;
  final bool highlightFirst;

  const TextShelf({Key? key, required this.items, this.direction = TextShelfDirection.horizontal, this.highlightFirst = false}) : super(key: key);


  Widget _wrapText(String text, {highlight = false}) {
    return Text (
      text,
      textAlign: TextAlign.center,
      style: highlight ? const TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold) : null,
    );
  }

  List<Widget> _mapItems(List<String> items) {
    List<Widget> result = [];

    for(int i =0; i < items.length; i++) {
      result.add(_wrapText(items[i], highlight: highlightFirst && i == 0));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if(direction == TextShelfDirection.horizontal)
    {
      body = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _mapItems(items),
      );
    } else {
      body = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _mapItems(items),
      );
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: body,
    );

  }

}