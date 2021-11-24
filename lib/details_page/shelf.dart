import 'dart:ui';

import 'package:flutter/material.dart';

// interfaces used to get properties to draw the shelf items
abstract class IShelfItem {
  // pass "" to skip
  String topText();
  String bottomText();

  //required
  String imageUrl();
}

class Shelf extends StatelessWidget {

  String title;
  List<IShelfItem> items;
  int itemsPerRow;

  Function(dynamic)? onItemPressed;

  Widget _renderItem(IShelfItem item)  {
    return Column(
        children: [
          AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: [
                  Positioned.fill(child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(item.imageUrl(), fit: BoxFit.cover),
                  )),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight:Radius.circular(10.0)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(color: Colors.red.shade300.withOpacity(0.7)),
                        height: 20,
                        child: Text(item.topText().replaceAll("_", " "),  style: const TextStyle(color: Colors.black)),
                      )
                    ),
                  ),
                ],
              )
          ),
          if(item.bottomText() != "") Text(item.bottomText(), overflow: TextOverflow.ellipsis, maxLines: 2,),
        ]
      );

  }


  Shelf({Key? key, this.title = "", required this.items, this.itemsPerRow = 3, this.onItemPressed = null}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column (
      children: [
        if(title != "") Text(title, style: Theme.of(context).textTheme.headline6,),
        GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: itemsPerRow,
          childAspectRatio: 1/1.3,
          physics: const NeverScrollableScrollPhysics(),
          children: items.map((e) => (onItemPressed == null ? _renderItem(e) : GestureDetector( onTap: () { onItemPressed!(e); }, child: _renderItem(e)))).toList(),
        )

      ],
    );
  }


}