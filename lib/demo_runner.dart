import 'package:flutter/material.dart';
import 'package:maki/details_page/details_page.dart';

import 'models/anime.dart';

void main() {
  runApp(const DemoRunner());
}


class RunnerBody extends StatelessWidget {

  final Anime sampleAnime = Anime(
      anilistID: 1,
      malID: 1,
      title: "test anime",
      coverUrl: "https://s4.anilist.co/file/anilistcdn/media/anime/cover/large/bx129898-FRUzDtPhRigt.jpg",
      score: 87,
      genres: ["action", "whatever", "raccoons"],
      year: 2050,
      description: "Racoonz are nasty creatures. They eat your trash, they take over you house. You should be scared!",
  );

  RunnerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
        body: ListView(
          children: [
            ElevatedButton(
              child: const Text("Open anime details!"),
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnimeDetailsPage.fromPrefetchedAnime(animeData: sampleAnime) )
                )
              },
            )
          ],
        )
    );
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
        primarySwatch: Colors.blue,
      ),
      home: RunnerBody()
    );
  }
}