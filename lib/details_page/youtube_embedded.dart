import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubeEmbedded extends StatefulWidget {

  final String url;

  YoutubeEmbedded({Key? key, required this.url}) : super(key: key);

  @override
  State<YoutubeEmbedded> createState() => _videoPlayerState();
}


class _videoPlayerState extends State<YoutubeEmbedded> {

  @override
  Widget build(BuildContext context) {

    String? videoId = YoutubePlayer.convertUrlToId(widget.url);

    // skip widget
    if(videoId == null) {
      //return const SizedBox.shrink();
      return Text("ops, no id");
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: true, ),
    );

    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
  }



}