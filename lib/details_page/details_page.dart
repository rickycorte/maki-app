import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:maki/common/custom_appbar.dart';
import 'package:maki/details_page/cover_side_info.dart';
import 'package:maki/details_page/elevated_rounded.dart';
import 'package:maki/details_page/footer_info.dart';
import 'package:maki/details_page/shelf.dart';
import 'package:maki/details_page/text_shelf.dart';
import 'package:maki/details_page/youtube_embedded.dart';
import 'package:maki/models/anime_character.dart';
import 'package:maki/models/anime_details.dart';
import 'package:maki/models/anime_relation.dart';
import 'package:maki/models/user.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import 'anime_base_info.dart';

// use a steteful page because we may load anime data later than the actual page so a refresh may be needed
class AnimeDetailsPage extends StatefulWidget {
  AnimeDetails? animeData;

  int? anilistID;

  AnimeDetailsPage({Key? key, required this.anilistID}) : super(key: key);

  AnimeDetailsPage.fromPrefetchedAnime({Key? key, required this.animeData})
      : super(key: key);

  _onDetailsFetched(AnimeDetails anime) {
    animeData = anime;
    User.current!.updateAnimeEntryList(anime); 
  }

  @override
  State<AnimeDetailsPage> createState() => _AnimeDetailsPageState();
}

// state item
class _AnimeDetailsPageState extends State<AnimeDetailsPage> {
  void _onRelatedAnimePressed(dynamic anime) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AnimeDetailsPage(
                  anilistID: (anime as AnimeRelation).anilistID,
                )));
  }

  int getResponsiveGridItemCount() {
    var w = MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    if(w > 1100) {
      return 6;
    }
    return 3;
  }
  
  Widget _loadedPageLayout() {
    const elementPadding = 20.0;

    var cover = ElevatedRounded(
        child: ClipRRect(
          borderRadius: const BorderRadius.all( Radius.circular(25)),
          child: CachedNetworkImage(
            imageUrl: widget.animeData!.coverUrl,
            placeholder: (ctx, prog) => Skeleton(height: 250),
          ),
        )
    );

    List<Widget> pageElements = [];

    if(MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio < 1100) {
      // phone vertical layout here
        // cover + side info
        pageElements.add (
            IntrinsicHeight(
                child: Row (
                    children: [
                      Expanded(child: cover),
                      const SizedBox(width: elementPadding,),
                      Expanded(child: CoverSideInfo(anime: widget.animeData!))
                    ]
                )
            )
        );

        pageElements.add(const SizedBox(height: elementPadding));

        // title box
        pageElements.add(
            ElevatedRounded(child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AnimeBaseInfo(anime: widget.animeData)
            )
            )
        );


    } else {
      // phone horizontal and tablet layout here
      pageElements.add(Container(
        constraints: const BoxConstraints(maxHeight: 400,),
        child: Row(
          children: [
            cover,
            const SizedBox(width: 20,),
            Expanded(
              child: ElevatedRounded(child: ClipRRect(child: AnimeBaseInfo(anime: widget.animeData, expandedDesc: true,))),
            ),
          ],
        ),
      ));

      pageElements.add(const SizedBox(height: 20,));

      pageElements.add(
          CoverSideInfo(anime: widget.animeData!, horizontal: true,)
      );

    }


    // plance embed if available
    if (widget.animeData?.trailerUrl != null) {
      pageElements.add(const SizedBox(height: elementPadding));
      pageElements.add(ElevatedRounded(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: YoutubeEmbedded(url: widget.animeData?.trailerUrl ?? "")),
      ));
    }

    if (widget.animeData?.relations != null &&
        (widget.animeData?.relations as List<AnimeRelation>).isNotEmpty) {
      var relations = widget.animeData?.relations as List<AnimeRelation>;

      pageElements.add(const SizedBox(height: elementPadding));
      pageElements.add(ElevatedRounded(child: Padding(
        padding: const EdgeInsets.only(bottom: 16, left: 8, right:8, top: 16),
        child: Shelf(
            items: relations,
            title: "Relations",
            onItemPressed: _onRelatedAnimePressed,
            itemsPerRow: getResponsiveGridItemCount(),
        ),
      ))
      );
    }

    if (widget.animeData?.characters != null &&
        (widget.animeData?.characters as List<AnimeCharacter>).isNotEmpty) {
      var characters = widget.animeData?.characters as List<AnimeCharacter>;

      pageElements.add(const SizedBox(height: elementPadding));
      pageElements.add(ElevatedRounded(child: Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 8, right:8, top: 16),
          child: Shelf(items: characters, title: "Characters", itemsPerRow: getResponsiveGridItemCount(),)))
      );
    }

    pageElements.add(const SizedBox(height: elementPadding));
    pageElements.add(FooterInfo(anime: widget.animeData!));

    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: pageElements,
    );
  }

  Widget _loadFromRemoteLayout() {
    return FutureBuilder<AnimeDetails>(
        future: fetchAnimeDetails(widget.anilistID as int),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            widget._onDetailsFetched(snapshot.data as AnimeDetails);
            return _loadedPageLayout();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackButton: true,
        ),
        body: widget.animeData != null
            ? _loadedPageLayout()
            : _loadFromRemoteLayout(),
      ),
    );
  }
}
