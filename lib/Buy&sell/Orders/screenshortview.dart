import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ScreenShortView extends StatefulWidget {
  final String Image ;
  const ScreenShortView({Key? key, required this.Image}) : super(key: key);

  @override
  State<ScreenShortView> createState() => _ScreenShortViewState();
}

class _ScreenShortViewState extends State<ScreenShortView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
      ),
      body:   PinchZoom(
        child: Image.network(widget.Image),
        resetDuration: const Duration(minutes: 1),
        maxScale: 2.5,
        onZoomStart: (){print('Start zooming');},
        onZoomEnd: (){print('Stop zooming');},
      ),


    );
  }
}
