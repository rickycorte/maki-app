import 'package:flutter/material.dart';

class customGridBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _customGridBarState createState() => new _customGridBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}

class _customGridBarState extends State<customGridBar> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(15, (index) {
        return new Card(
            elevation: 10,
            child: new Container(
              child: new Text("$index"),
            ));
      }),
    );
  }
}
