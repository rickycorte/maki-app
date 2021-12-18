import 'package:flutter/material.dart';
import 'package:maki/login_page/login_page.dart';
import 'package:maki/profile_page/theme_changer.dart';
import 'package:provider/provider.dart';
import 'profile_page/theme_changer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (ctx) => ThemeChanger(),
      child: const MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    debugPrint(theme.mode.toString());
    return MaterialApp(
      home: LoginPage(),
      theme: ThemeChanger.lightTheme,
      darkTheme: ThemeChanger.darkTheme,
      themeMode: theme.mode,
    );
  }
}
