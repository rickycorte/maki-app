import 'package:flutter/material.dart';
import 'package:maki/models/anime_details.dart';

import '../common/elevated_rounded.dart';

class FooterInfo extends StatelessWidget {
  final AnimeDetails anime;

  const FooterInfo({Key? key, required this.anime}) : super(key: key);

  List<Widget> _parseData() {
    List<Widget> result = [];

    result.add(const SizedBox(height: 8));

    result.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          const Text(
            "Studio",
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
          ),
          Text(
            anime.studio,
            style: const TextStyle(
                fontWeight: FontWeight.w900, color: Colors.grey),
          ),
        ],
      ),
    ));

    if (anime.altTitle != null) {
      result.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            const Text(
              "Alternative title",
              // ignore: unnecessary_const
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            Text(
              anime.altTitle!,
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: Colors.grey),
            ),
          ],
        ),
      ));
    }

    if (anime.airStartDate != null && anime.airFinalDate != null) {
      result.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            const Text(
              "Air Period",
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
            ),
            Text(
              "From ${anime.airStartDate} to ${anime.airFinalDate}",
              style: const TextStyle(
                  fontWeight: FontWeight.w900, color: Colors.grey),
            ),
          ],
        ),
      ));
    }

    result.add(const SizedBox(height: 8));

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedRounded(
        child: Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: _parseData(),
      ),
    ));
  }
}
