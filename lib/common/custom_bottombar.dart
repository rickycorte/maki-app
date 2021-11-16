import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomBottomBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Text("Togliere");
  }
}
