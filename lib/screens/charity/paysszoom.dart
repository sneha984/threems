import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class PayZoomPage extends StatefulWidget {
  final String img;
  const PayZoomPage({Key? key, required this.img}) : super(key: key);

  @override
  State<PayZoomPage> createState() => _PayZoomPageState();
}

class _PayZoomPageState extends State<PayZoomPage> {
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
      child: Image.network(widget.img),
      resetDuration: const Duration(minutes: 1),
      maxScale: 2.5,
      onZoomStart: (){print('Start zooming');},
      onZoomEnd: (){print('Stop zooming');},
    ),

    );
  }
}
