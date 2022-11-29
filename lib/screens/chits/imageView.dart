import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FileViewPage extends StatefulWidget {
  final String url;
  final String type;
  const FileViewPage({Key? key, required this.url, required this.type})
      : super(key: key);

  @override
  State<FileViewPage> createState() => _FileViewPageState();
}

class _FileViewPageState extends State<FileViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.url);
    return Scaffold(
        body: Center(
      child: CachedNetworkImage(imageUrl: widget.url),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// Scaffold(
// body: Center(
// child: _controller.value.isInitialized
// ? AspectRatio(
// aspectRatio: _controller.value.aspectRatio,
// child: VideoPlayer(_controller),
// )
// : Container(),
// ),
// floatingActionButton: FloatingActionButton(
// onPressed: () {
// setState(() {
// _controller.value.isPlaying
// ? _controller.pause()
//     : _controller.play();
// });
// },
// child: Icon(
// _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
// ),
// ),
// );
// }
//
// @override
// void dispose() {
//   super.dispose();
//   _controller.dispose();
// }
// }
