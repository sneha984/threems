import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Simple extends StatefulWidget {
  String youtubeLink;

   Simple({Key? key,required this.youtubeLink}) : super(key: key);

  @override
  State<Simple> createState() => _SimpleState();
}

class _SimpleState extends State<Simple> {
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  var videoId;
  late PlayerState _playerState;
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:videoId=YoutubePlayer.convertUrlToId(widget.youtubeLink).toString(),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    );
  }
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Colors.white,
            handleColor: Colors.white,
          ),
          onReady: () {
            _controller.addListener(listener);
          },
        ),
      ),

    );
  }
}
