import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:threems/utils/themes.dart';

import '../screens/splash_screen.dart';

class Sleekpage extends StatefulWidget {
  const Sleekpage({Key? key}) : super(key: key);

  @override
  State<Sleekpage> createState() => _SleekpageState();
}

class _SleekpageState extends State<Sleekpage> {

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      // innerWidget: ,
      appearance: CircularSliderAppearance(
        angleRange: 360,
        startAngle: -90,
          size: 100,
          infoProperties: InfoProperties(
            mainLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: scrWidth*0.07,fontFamily: 'Urbanist'),
          ),
          animationEnabled: true,
        customWidths: CustomSliderWidths(
          trackWidth: 10,
          progressBarWidth: 10,
          handlerSize: 10,
        ),
        customColors: CustomSliderColors(
          trackColor:Colors.grey.shade100,
          dotColor: Colors.white,
          hideShadow: true,
          progressBarColor: primarycolor,
        )



      ),
    );
  }
}
