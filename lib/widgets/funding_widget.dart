import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:threems/utils/themes.dart';

import '../screens/splash_screen.dart';

class FundingWidget extends StatefulWidget {
  String image;
  String title;
  FundingWidget({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  State<FundingWidget> createState() => _FundingWidgetState();
}

class _FundingWidgetState extends State<FundingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: scrWidth * 0.25,
      width: scrWidth * 0.25,
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 68,
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
                color: Color(0xffF1FFF4),
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 2),
                    blurRadius: 15,
                    spreadRadius: 0,
                  ),
                ]),
            child:
            Lottie.asset(widget.image
               // 'assets/icons/cash.json'
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
              // fontSize: 10,
              fontSize: FontSize10,
            ),
          ),
        ],
      ),
    );
  }
}
