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

  Widget _renderItem(IShelfItem item)  {
    return  ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 800, maxWidth: 400),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(item.imageUrl(), fit: BoxFit.cover),
      ),
    );

  }

  Shelf({Key? key, this.title = "", required this.items, this.itemsPerRow = 3}) : super(key: key);

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
          physics: const NeverScrollableScrollPhysics(),
          children: items.map((e) => _renderItem(e)).toList(),
        )

      ],
    );
  }


}