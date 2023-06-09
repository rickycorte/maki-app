import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:skeleton_animation/skeleton_animation.dart';


class YoutubeEmbedded extends StatefulWidget {

  final String url;

  YoutubeEmbedded({Key? key, required this.url}) : super(key: key);

  @override
  State<YoutubeEmbedded> createState() => _videoPlayerState();
}


class _videoPlayerState extends State<YoutubeEmbedded> {
  

  String? _getThumbnailUrl(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);

    //TODO: si puo fare di meglio come check

    if (uri == null) {
      return null;
    }
    var id = videoUrl.length == 11 ? videoUrl : uri.queryParameters['v'];

    if(id == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/$id';
  }

  void _launchVideo(BuildContext context) async {
    var url = widget.url.length == 11 ? "https://www.youtube.com/watch?v=${widget.url}" : widget.url;

    try {
      await launch(
          url,
          customTabsOption: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: false,
          enableUrlBarHiding: true,
          showPageTitle: false,
          )
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong with your video.")));
      debugPrint(e.toString());
    }
  }

  double _getVideoAspectRatio(BuildContext context) {
     return  MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio > 1100 ? 9/25 : 9/17;
  }

  @override
  Widget build(BuildContext context) {

    String? thumbLink = _getThumbnailUrl(widget.url);

    // skip widget
    if(thumbLink == null) {
      return const Text("No video available");
    }
    
    return GestureDetector(
      onTap: () => { _launchVideo(context) },
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * _getVideoAspectRatio(context),
            child: CachedNetworkImage(
              imageUrl: "$thumbLink/hqdefault.jpg",
              fit: BoxFit.fitWidth,
              placeholder: (ctx, prog) => Skeleton(height: 250),
              errorWidget: (ctx, prog, ext) => Image.asset("assets/images/placeholder-image.jpg", fit: BoxFit.fitWidth),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade900.withOpacity(0.7)),
              child: const Center(
                child: Icon(Icons.play_arrow, size:100, color: Colors.red,),
              ),
            ),
          ),
        ],
      ),
    );

  }



}