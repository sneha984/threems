import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:threems/layouts/screen_layout.dart';
import 'package:threems/screens/home_screen.dart';

import '../../utils/themes.dart';
import '../splash_screen.dart';

class PaymentSucessful extends StatefulWidget {
  PaymentSucessful({Key? key}) : super(key: key);

  @override
  State<PaymentSucessful> createState() => _PaymentSucessfulState();
}

class _PaymentSucessfulState extends State<PaymentSucessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: padding15, right: padding15, top: scrWidth * 0.05,
          // vertical: scrWidth * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              height: scrHeight*0.27,
              width: scrWidth*0.6,
              margin: EdgeInsets.symmetric(
                horizontal: scrWidth*0.03,
              ),
              // color: Colors.red,
              child: Lottie.asset('assets/icons/payment_successful.json',
                  fit: BoxFit.contain),
            ),
            SizedBox(height: scrHeight*0.1,),
            Text(
              "You have successfully set up your Fundraiser.\nGo ahead, Share your fundraiser and get a wider audience",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontSize15,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            SizedBox(
              height: scrHeight*0.035,
            ),
            Container(
              height: scrHeight*0.06,
              width: scrWidth*0.78,
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Center(
                child: Text(
                  "Share",
                  style: TextStyle(
                      fontSize: FontSize15,
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: scrWidth * 0.03,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenLayout(),
                  ),
                );
              },
              child: Container(
                height: scrHeight*0.06,
                width: scrWidth*0.78,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  border: Border.all(
                    color: Color(0xffE6E6E6),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Go to home",
                    style: TextStyle(
                        fontSize: FontSize15,
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w500,
                        color: Color(
                          0xff888888,
                        ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
