import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class UpcommingCardWidget extends StatefulWidget {
  String image;
  String title;
  int count;
  UpcommingCardWidget(
      {Key? key, required this.image, required this.title, required this.count})
      : super(key: key);

  @override
  State<UpcommingCardWidget> createState() => _UpcommingCardWidgetState();
}

class _UpcommingCardWidgetState extends State<UpcommingCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: scrWidth * .152,
      width: scrWidth * .425,
      // height: 55,
      // width: 157,
      decoration: BoxDecoration(
          color: Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(scrWidth * 0.045)),
      child:
          //
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(scrWidth * 0.021),
            // height: 42,
            // width: 49,
            height: scrWidth * 0.116,
            width: scrWidth * 0.136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(scrWidth * 0.035),
              color: Color(0xff28B446),
            ),
            child: SvgPicture.asset(
              widget.image,
              fit: BoxFit.contain,
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: scrWidth * 0.0285,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w600,
            ),
          ),
          CircleAvatar(
            radius: scrWidth * 0.025,
            backgroundColor: Color(0xffF14336),
            child: Center(
              child: Text(
                widget.count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: scrWidth * 0.035,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
