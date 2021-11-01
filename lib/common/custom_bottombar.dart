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
    return BottomNavigationBar(
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        // ignore: prefer_const_constructors
        BottomNavigationBarItem(
            icon: const Icon(Icons.crop_square), title: const Text("For you")),
        BottomNavigationBarItem(
            icon: const Icon(Icons.crop_square), title: const Text("My List")),
        BottomNavigationBarItem(
            icon: const Icon(Icons.crop_square), title: const Text("Options")),
      ],
    );
  }
}
