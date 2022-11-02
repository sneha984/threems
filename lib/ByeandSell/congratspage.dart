import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:threems/screens/splash_screen.dart';

import 'buy_and_sell.dart';

class CongratsPage extends StatefulWidget {
  const CongratsPage({Key? key}) : super(key: key);

  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute
        (builder: (context)=>BuyAndSell()), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff02B558),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: scrHeight*0.3,),
          Center(child: SvgPicture.asset("assets/icons/bigshopimage.svg")),
          SizedBox(height: scrHeight*0.02,),
          Text(
            "Congratulations",
            style: TextStyle(color: Colors.white,
                fontFamily: 'Urbanist',
                fontSize: 20,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: scrHeight*0.02,),
          Center(
            child: Text(
              "Your E-Commerce Store has been created. It’s \ntime to add your first product now!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white,
                  fontFamily: 'Urbanist',
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Lottie.asset('assets/images/congrats.json',
              fit: BoxFit.contain),
        ],
      ),
    );
  }
}
