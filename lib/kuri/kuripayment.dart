import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class KuriPaymentPage extends StatefulWidget {
  const KuriPaymentPage({Key? key}) : super(key: key);

  @override
  State<KuriPaymentPage> createState() => _KuriPaymentPageState();
}

class _KuriPaymentPageState extends State<KuriPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: scrHeight*0.136,
              width: scrWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child:  Padding(
                padding: EdgeInsets.only(
                  top: scrHeight*0.07,),
                child: Row(
                  children: [
                    SizedBox(width: scrWidth*0.07,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child:  SvgPicture.asset("assets/icons/arrow.svg",),
                    ),
                    SizedBox(width: scrWidth*0.04,),

                    Text("Kuri Payment",style: TextStyle(
                        fontSize: scrWidth*0.045,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
            ),
            SizedBox(height: scrHeight*0.03,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: scrWidth*0.07,),
                Container(
                    width: scrWidth*0.21,
                    height: scrHeight*0.048,
                    decoration: BoxDecoration(
                        color: Color(0xffF7F8F9),
                        borderRadius: BorderRadius.circular(scrWidth*0.02),
                        border: Border.all(color: Color(0xffDADADA))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: scrHeight*0.025,
                          width: scrWidth*0.09,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/flag.png"),fit: BoxFit.fill)
                          ),
                        ),
                        Text(
                          "INR",
                          style: TextStyle(
                            fontSize: scrWidth*0.045,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                SizedBox(width: scrWidth*0.03,),

                Container(
                  width: scrWidth*0.62,
                  height: scrHeight*0.048,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.04,
                    vertical: scrHeight*0.006,
                  ),
                  decoration: BoxDecoration(
                      color: textFormFieldFillColor,
                      border: Border.all(
                        color: Color(0xffDADADA),
                      ),
                      borderRadius: BorderRadius.circular(scrWidth * 0.026)),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/₹.svg"),
                      Padding(
                        padding:  EdgeInsets.only(bottom: scrHeight*0.012,left: scrWidth*0.02),
                        child: Container(
                          height: scrHeight*0.03,
                          width: scrWidth*0.4,
                          child: TextFormField(
                            cursorHeight: scrWidth * 0.055,
                            cursorWidth: 1,
                            cursorColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(

                              fillColor: textFormFieldFillColor,
                              filled: true,
                              contentPadding: EdgeInsets.only(left:scrWidth*0.01 ,
                                  top: scrHeight*0.01, bottom: scrHeight*0.009),
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(height: scrHeight*0.02,),
            Row(
              children: [
                SizedBox(width: scrWidth*0.065,),
                Text(
                  "Pay to",
                  style: TextStyle(
                    fontSize: scrWidth*0.04,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff827E7E),
                  ),
                ),
                SizedBox(width: scrWidth*0.02,),
                Container(
                    width: scrWidth*0.74,
                    height: scrHeight*0.048,
                    decoration: BoxDecoration(
                        color: Color(0xffF7F8F9),
                        borderRadius: BorderRadius.circular(scrWidth * 0.026),
                        border: Border.all(color: Color(0xffDADADA))),
                    child: Row(
                      children: [
                        SizedBox(width: scrWidth*0.04,),
                        Text(
                          "+91 9072318094",
                          style: TextStyle(
                            fontSize: scrWidth*0.058,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: scrWidth*0.1,),

                        SvgPicture.asset("assets/icons/copy.svg"),
                        SizedBox(width: scrWidth*0.015,),

                        Text(
                          "copy",
                          style: TextStyle(
                            fontSize: scrWidth*0.035,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),


                      ],
                    )),

              ],
            ),
            SizedBox(height: scrHeight*0.017,),

            Row(
              children: [
                SizedBox(width: scrWidth*0.068,),

                Text(
                  "Accepted UPI Apps",
                  style: TextStyle(
                    fontSize: scrWidth*0.04,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff827E7E),
                  ),
                ),
                SizedBox(width: scrWidth*0.09,),

                Container(
                    height: 20,
                    width: 20,
                    child: Image(image: AssetImage("assets/images/gpay.png"))),
                SizedBox(width: 5,),

                Container(
                    height: 20,
                    width: 15,
                    child: Image(image: AssetImage("assets/images/phonepe.png"))),
                SizedBox(width: 5,),

                Container(
                    height: 20,
                    width: 40,
                    child: Image(image: AssetImage("assets/images/paytm (1).png"))),
                SizedBox(width: 5,),

                Container(
                    height: 20,
                    width: 15,
                    child: Image(image: AssetImage("assets/images/whatsp pay.png"))),
                SizedBox(width: 5,),

                Container(
                    height: 20,
                    width: 45,
                    child: Image(image: AssetImage("assets/images/amaz pay (1).png"))),
              ],
            ),
            SizedBox(height: 10,),


            Padding(
              padding:EdgeInsets.only(),
              child: Image(image: AssetImage("assets/icons/card 2.png")),
            ),


            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(8),
              color: Color(0xffDADADA),
              dashPattern: [4,4],
              strokeWidth: 2,
              child: Container(
                height: 64,
                width: 320,
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/Group 135.svg",
                    ),
                    SizedBox(
                      width: scrWidth * 0.02,
                    ),
                    Text(
                      "Upload Screenshot",
                      style: TextStyle(
                        color: Color(0xff8391A1),
                        fontSize: 15,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 118,),
            Text(
              "after the verification of screenshot your payment will count on this kuri",
              style: TextStyle(
                color: Color(0xff827E7E),
                fontSize: 10,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20,),

            GestureDetector(
              onTap: (){
              },
              child: Container(
                height: 45,
                width: 320,
                decoration: BoxDecoration(
                  color: primarycolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    "PAYMENT NOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w800,
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
