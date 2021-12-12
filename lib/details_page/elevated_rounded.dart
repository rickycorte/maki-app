import 'package:flutter/material.dart';

class ElevatedRounded extends StatelessWidget {
  final Widget child;

  const ElevatedRounded({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(25)),
      elevation: 15,
      child: child,
    );
  }
}
