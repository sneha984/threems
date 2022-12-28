import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:threems/layouts/screen_layout.dart';

import '../../utils/themes.dart';
import '../splash_screen.dart';

class Sucesspage extends StatefulWidget {
  const Sucesspage({Key? key}) : super(key: key);

  @override
  State<Sucesspage> createState() => _SucesspageState();
}

class _SucesspageState extends State<Sucesspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 241,
                width: 241,
                margin: EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                // color: Colors.red,
                child: Lottie.asset('assets/icons/payment_successful.json',
                    fit: BoxFit.contain),
              ),
              SizedBox(height: scrHeight*0.15,),


              Text("You have succesfully donated",
                style: TextStyle(fontSize: scrWidth*0.041,fontFamily: 'Urbanist',fontWeight: FontWeight.w500),),
              SizedBox(height: scrHeight*0.015,),

              // GestureDetector(
              //   onTap: (){
              //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeMoreCharities()));
              //   },
              //   child: Container(
              //     height: scrHeight*0.06,
              //     width: scrWidth*0.78,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(17),
              //       color: primarycolor,
              //     ),child: Center(child: Text("Share this charity to others ",
              //     style: TextStyle(color: Colors.white,fontSize: scrWidth*0.041,fontFamily: 'Outfit',fontWeight: FontWeight.w500),)),),
              // ),
              SizedBox(height: scrHeight*0.011,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ScreenLayout()));
                },
                child: Container(
                  height: scrHeight*0.06,
                  width: scrWidth*0.78,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: Color(0xffE6E6E6),width: 1)

                  ),child: Center(child: Text("Go to home",
                    style: TextStyle(color: Color(0xff888888),fontSize:  scrWidth*0.041,fontFamily: 'Outfit',fontWeight: FontWeight.w500))),),
              ),
              SizedBox(height: scrHeight*0.14,),
            ],
          ),

        )
    );
  }
}
