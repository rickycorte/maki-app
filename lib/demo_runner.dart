import 'package:flutter/material.dart';
import 'package:maki/details_page/details_page.dart';
import 'package:maki/models/anime.dart';
import 'login_page/login_page.dart';
import 'main.dart';
import 'models/anime_details.dart';
import 'models/user.dart';

void main() async {
  runApp(const DemoRunner());
}

class RunnerBody extends StatelessWidget {
  final AnimeDetails sampleAnime = AnimeDetails(
      anilistID: 1,
      malID: 1,
      title: "test anime",
      coverUrl:
          "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx129898-FRUzDtPhRigt.jpg",
      score: 87,
      genres: ["action", "whatever", "raccoons"],
      year: 2050,
      format: "Piscina",
      description:
          "Racoonz are nasty creatures. They eat your trash, they take over you house. You should be scared!",
      trailerUrl: "https://www.youtube.com/watch?v=VDgsP-6TPFw");

  RunnerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        ElevatedButton(
          child: const Text("Open anime details!"),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimeDetailsPage.fromPrefetchedAnime(
                        animeData: sampleAnime)))
          },
        ),
        ElevatedButton(
          child: const Text("Open fetched details!"),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimeDetailsPage(
                          anilistID: 21202,
                        )))
          },
        ),
        ElevatedButton(
          child: const Text("Details: video thumb crash"),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimeDetailsPage(
                          anilistID: 21324,
                        )))
          },
        ),
        ElevatedButton(
          child: const Text("Open home"),
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const MyApp()))
          },
        ),

        ElevatedButton(
          child: const Text("Login"),
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage())
            )
          },
        ),
      ],
    ));
  }
}

// page that can be used as main page to run a specific page without braking the main real screen
class DemoRunner extends StatelessWidget {
  const DemoRunner({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: RunnerBody());
  }
}
