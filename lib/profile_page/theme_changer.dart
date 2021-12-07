import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChanger with ChangeNotifier {

  ThemeMode mode = ThemeMode.system;

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
    primaryColor: Colors.red,
    primaryColorDark: Colors.red,
    scaffoldBackgroundColor: const Color.fromRGBO(31, 29, 28, 1),
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


  ThemeChanger({this.mode = ThemeMode.system}) {
    applyOldTheme();
  }

  void applyOldTheme() async {
    setDarkTheme(await shouldForceDarkTheme());
    notifyListeners();
  }

  static Future<bool> shouldForceDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getInt("force_dark_theme");
    return Future.value( (val ?? 0) != 0);
  }

  Future<void> setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("force_dark_theme", value ? 1 : 0);
    mode = value ? ThemeMode.dark : ThemeMode.system;
    debugPrint(mode.toString());
    notifyListeners();
  }




}
