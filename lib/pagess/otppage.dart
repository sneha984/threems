import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'detailspage.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Padding(
            padding: EdgeInsets.only(top: scrHeight*0.02,
                left: scrWidth*0.07,bottom: scrHeight*0.02,right: scrWidth*0.05),
            child:SvgPicture.asset("assets/icons/arrow.svg",),
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: scrWidth*0.07),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: scrHeight*0.008,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("We have send a 6 digit OTP on \n+91 9072318094",style: TextStyle(fontFamily: 'Outfit',
                    fontWeight: FontWeight.w600,fontSize: scrWidth*0.05

                ),),
                SizedBox(height: scrHeight*0.008,),

                Text("Enter the OTP below to verify your number",style: TextStyle(fontFamily: 'Outfit',
                    fontWeight: FontWeight.w400,fontSize: scrWidth*0.035,color: Color(0xff000000).withOpacity(0.5)
                ),),

              ],
            ),
            SizedBox(height: scrHeight*0.048,),
            Padding(
              padding:  EdgeInsets.only(left: scrWidth*0.018),
              child: Pinput(
                defaultPinTheme: PinTheme(
                  height:scrHeight*0.06,
                  width: scrWidth*0.12,
                  decoration: BoxDecoration(
                    color: Color(0xffEEEEEE),
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                length: 6,
              ),
            ),
            SizedBox(height: scrHeight*0.07,),

            GestureDetector(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage()));
              },
              child: Container(
                height: scrHeight*0.055,
                width: scrWidth*0.87,
                decoration: BoxDecoration(
                  color:primarycolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child:  Text(
                    "CONTINUE",
                    style: style
                  ),
                ),
              ),
            ),
            SizedBox(height: scrHeight*0.02,),




          ],
        ),
      ),

    );
  }
}
