import 'package:flutter/material.dart';

class themeBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Brightness brightness) builder;

  themeBuilder({required this.builder});

  @override
  _themeBuilderState createState() => _themeBuilderState();
}

class _themeBuilderState extends State<themeBuilder> {
  // ignore: unused_field
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _brightness = Brightness.light;
  }

  void changeState() {
    setState(() {
      _brightness =
          _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness);
  }
}
