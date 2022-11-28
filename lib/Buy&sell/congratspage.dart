import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';
import 'package:threems/screens/splash_screen.dart';

import '../layouts/screen_layout.dart';
import '../model/Buy&sell.dart';
import 'buy_and_sell.dart';

class CongratsPage extends StatefulWidget {
  final String id;
  final int status;

  const CongratsPage({Key? key, required this.id, required this.status}) : super(key: key);

  @override
  State<CongratsPage> createState() => _CongratsPageState();
}

class _CongratsPageState extends State<CongratsPage> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          ScreenLayout(index: 1,tabIndex: 1,),), (route) => false);
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute
      //   (builder: (context)=>
      //     StoreDetailsFill2(id: widget.id,)
      // ), (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff02B558),
      body: Stack(
        children: [
          Column(
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

            ],
          ),
          Positioned(
            top: 10,
            bottom: 0,
            right: 10,
            left: 10,
            child: Lottie.asset('assets/images/congrats.json',
                fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
