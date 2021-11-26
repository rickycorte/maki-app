import 'package:flutter/material.dart';
import 'package:maki/anime_list_tab/anime_list_tab.dart';
import 'package:maki/options_tab/options_tab.dart';
import 'package:maki/models/anime.dart';
import 'package:maki/common/anime_cover_grid.dart';
import 'package:maki/demo_runner.dart';
import 'common/custom_appbar.dart';
import 'common/custom_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

//Classe per aggiornare la gridbar
AnimeCoverGrid getCover(oldCoverGrid) {
  AnimeCoverGrid newCover = oldCoverGrid;
  return newCover;
}

//Classe per svolgere l'azione dopo il refresh indicator
Future<Null> refreshGridBar() async {
  await Future.delayed(Duration(seconds: 2));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedPageIndex = 0;
  Widget? _cachedRecommendationWidget;

  Widget _futureRecommendationGrid(username) {
    _cachedRecommendationWidget ??= FutureBuilder<List<Anime>>(
        future: fetchRecommendations("xDevily"),
        builder: (context, snapshot) {
          //La chiamo firstCoverGrid perchè è la prima che carico quando apro l'app
          AnimeCoverGrid firstCoverGrid =
              getCover(AnimeCoverGrid(displayData: snapshot.data ?? []));
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: refreshGridBar,
              child: AnimeCoverGrid(displayData: snapshot.data ?? []),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });

    return _cachedRecommendationWidget as Widget;
  }

  Widget _getSelectedTab() {
    switch (_selectedPageIndex) {
      case 1:
        return Text("My list page");
      case 2:
        return Text("Options page");
      default:
        return _futureRecommendationGrid("xDevily");
    }
  }

  void _onNavigationTabChange(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },
      child: Scaffold(
        //appBar: const CustomAppBar(),
        body: _getSelectedTab(),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "For You"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "My List"),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Options"),
          ],
          onTap: _onNavigationTabChange,
          currentIndex: _selectedPageIndex,
        ),
      ),
    );
  }
}
