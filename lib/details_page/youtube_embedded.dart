import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';


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

    return 'https://img.youtube.com/vi/$id/hq720.jpg';
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

  @override
  Widget build(BuildContext context) {

    String? thumbLink = _getThumbnailUrl(widget.url);

    // skip widget
    if(thumbLink == null) {
      return const Text("Something went wrong loading your video");
    }
    
    return GestureDetector(
      onTap: () => { _launchVideo(context) },
      child: Stack(
        children: [
          Image.network(thumbLink, ), // TODO: fallback img
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