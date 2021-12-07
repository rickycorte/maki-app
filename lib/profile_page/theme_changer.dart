import 'package:flutter/material.dart';
import 'package:maki/details_page/elevated_rounded.dart';
import 'package:maki/login_page/login_page.dart';
import 'package:maki/models/user.dart';
import 'package:maki/main.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.red,
    primaryColor: Colors.red,
    elevatedButtonTheme: ElevatedButtonThemeData (
        style: ButtonStyle (
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.red)
                )
            )
        )
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Colors.black54,
    primarySwatch: Colors.red,
    primaryColorDark: Colors.red,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
       selectedItemColor: Colors.red
    ),
    elevatedButtonTheme: ElevatedButtonThemeData (
        style: ButtonStyle (
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.red)
                )
            )
        ),
    ),
  );

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
