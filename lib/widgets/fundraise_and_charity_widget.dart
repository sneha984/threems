import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class FundraiseAndCharityWidget extends StatefulWidget {
  final String icon;
  final String title;
  const FundraiseAndCharityWidget(
      {super.key, required this.icon, required this.title});

  @override
  State<FundraiseAndCharityWidget> createState() =>
      _FundraiseAndCharityWidgetState();
}

class _FundraiseAndCharityWidgetState extends State<FundraiseAndCharityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: scrWidth * 0.156,

      width: scrWidth * .42,
      decoration: BoxDecoration(
        color: Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(scrWidth * 0.045),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: scrWidth * 0.1,
            width: scrWidth * 0.1,
            child: SvgPicture.asset(widget.icon),
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: FontSize15,
              fontFamily: 'Urbanist',
            ),
          ),
        ],
      ),
    );
  }
}
