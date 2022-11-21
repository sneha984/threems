import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../layouts/screen_layout.dart';
import '../screens/splash_screen.dart';

class CheckOutPage3 extends StatefulWidget {
  const CheckOutPage3({Key? key}) : super(key: key);

  @override
  State<CheckOutPage3> createState() => _CheckOutPage3State();
}

class _CheckOutPage3State extends State<CheckOutPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                SizedBox(height: 170,),
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


                Text("Order Placed Successfully",
                  style: TextStyle(fontSize: scrWidth*0.041,fontFamily: 'Urbanist',fontWeight: FontWeight.w500),),
                SizedBox(height: scrHeight*0.03,),


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
        ],
      ),
    );
  }
}
