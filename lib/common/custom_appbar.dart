
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.showBackButton = false}) : preferredSize = const Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  final bool showBackButton;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}


class _CustomAppBarState extends State<CustomAppBar>{

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text("Maki"),
        centerTitle: true,
        automaticallyImplyLeading: widget.showBackButton,
    );
  }
}
