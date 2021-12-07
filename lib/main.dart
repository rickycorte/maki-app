import 'package:flutter/material.dart';
import 'package:maki/anime_list_tab/anime_list_tab.dart';
import 'package:maki/common/future_anime_cover_grid.dart';
import 'package:maki/login_page/login_page.dart';
import 'package:maki/models/anime.dart';
import 'package:maki/common/anime_cover_grid.dart';
import 'package:maki/demo_runner.dart';
import 'package:maki/profile_page/theme_changer.dart';
import 'package:provider/provider.dart';
import 'common/custom_appbar.dart';
import 'common/custom_bottom_bar.dart';
import 'models/user.dart';
import 'profile_page/option_tab.dart';
import 'profile_page/theme_changer.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (ctx) => ThemeChanger(ThemeData.light()),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: LoginPage(),
      theme: theme.getTheme(),
    );
  }
}
