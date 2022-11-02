import 'package:flutter/material.dart';
import 'package:threems/utils/themes.dart';

import '../screens/splash_screen.dart';

class PercentageWidget extends StatefulWidget {
  PercentageWidget({Key? key, required this.percent}) : super(key: key);
  final int percent;

  @override
  State<PercentageWidget> createState() => _PercentageWidgetState();
}

class _PercentageWidgetState extends State<PercentageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: [
              Flexible(
                flex: widget.percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: widget.percent != 100
                          ? Radius.circular(0)
                          : Radius.circular(30),
                      topRight: widget.percent != 100
                          ? Radius.circular(0)
                          : Radius.circular(30),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 100 - widget.percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffECECEC),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height:scrHeight*0.035,
          width: scrWidth*0.3,
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          margin:  EdgeInsets.all(scrWidth*0.02),
          padding:  EdgeInsets.symmetric(vertical: scrHeight*0.01, horizontal: scrWidth*0.02),
          child: Center(
              child: Text(
            '${widget.percent}% Complete',
            style: TextStyle(
              color: Color(0xff8391A1),
              fontSize: FontSize10,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w600,
            ),
          )),
        )
      ],
    );
    ;
  }
}
