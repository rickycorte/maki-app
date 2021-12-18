

import 'package:flutter/material.dart';

/// wrap a widget with a material app to av oid media query exceptions
Widget createTestWrapper(Widget child){
  return MaterialApp(
    home: child,
  );
}