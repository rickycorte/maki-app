import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.white]),
      ),
      child: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 56,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                bottomIcon(Icon(Icons.star), "For You"),
                bottomIcon(Icon(Icons.list), "My List"),
                bottomIcon(Icon(Icons.settings), "Options")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomIcon(Icon icona, String testo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icona,
        Text(testo),
      ],
    );
  }
}
