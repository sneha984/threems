import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';

const Color primarycolor = Color(0xff008036);
Color secondarycolor = Colors.grey.withOpacity(0.2);
const Color otpBackgroundColor = Color(0xffF7F8F9);
const Color otpSumittedBorderColor = Color(0xffffffff);
const Color appBarColor = Color.fromRGBO(255, 255, 255, 1);
Color textFormFieldBorderColor = Colors.grey[200]!;
Color navBarUnSelColor = Color(0xff9F9F9F);
Color tabBarColor = Color(0xff02B558);
Color textFormFieldFillColor = Color(0xffF3F3F3);
Color textFormUnFocusColor = Color(0xffB0B0B0);

Color dotIndicatorColor = Color(0xffDADADA);

//textColor
const Color primaryTextColor = Colors.black;
const Color secondaryTextColor = Color(0xffabb0be);

//padding
double padding15 = scrWidth * 0.04;
double upcomingWidtitleSize = scrWidth * 0.033;
double textFormFieldPadding19 = scrWidth * 0.055;
double textFormFieldWidth280 = scrWidth * 0.8;
double textFormFieldHeight45 = scrWidth * 0.13;

//IconSize
double createRoomIconSize = scrWidth * 0.05;
double bottomNavbarIconSize = scrWidth * 0.07;
double upcomingWidIconSize = scrWidth * 0.07;
double upcomingWidCountSize = scrWidth * 0.024;

double FontSize30 = scrWidth * 0.06;
double FontSize10 = scrWidth * 0.028;
double FontSize8 = scrWidth * 0.026;
double FontSize13 = scrWidth * 0.035;
double FontSize14 = scrWidth * 0.036;
double FontSize15 = scrWidth * 0.039;

double FontSize17 = scrWidth * 0.052;
double FontSize16 = scrWidth * 0.045;
double HintTextF = scrWidth * 0.043;
double LoginWithF = scrWidth * 0.04;

double CardFont1 = scrWidth * 0.036;
double CardFont2 = scrWidth * 0.043;
double ChitsFont = scrWidth * 0.05;
double tabbarFont = scrWidth * 0.04;
double CreateChitFont = scrWidth * 0.032;
double RoomCreateF = scrWidth * 0.05;
double TextFormHeight = scrHeight * 0.07;
double TextFormWidth = scrWidth * 0.9;
Color TextFormContainer = Colors.grey.shade100;
//................................................................//
const Color carousaldotcolor= Color(0xffD9D9D9);
const Color signupcolor=Color.fromRGBO(0, 128, 54, 0.55);
// Color secondarycolor=Colors.grey.withOpacity(0.2);
// double CardFont1=scrWidth*0.029;
// double CardFont2=scrWidth*0.036;
// double ChitsFont=scrWidth*0.05;
// double tabbarFont=scrWidth*0.04;
// double CreateChitFont=scrWidth*0.03;
// double RoomCreateF=scrWidth*0.05;
// double TextFormHeight=scrHeight * 0.069;
// double TextFormWidth=scrWidth * 0.9;
// Color TextFormContainer=Colors.grey.shade100;
TextStyle style= TextStyle(
    color: Colors.white,
    fontSize: scrWidth*0.05,fontFamily: 'Outfit',fontWeight: FontWeight.w600
);
TextStyle onboardingtitle= TextStyle(fontSize: scrWidth*0.045,fontFamily: 'Outfit',fontWeight: FontWeight.w500);
TextStyle onboardingdesc=TextStyle(fontSize: scrWidth*0.031,fontFamily: 'Outfit',fontWeight: FontWeight.w400,color: Color(0xff615F5F));
TextStyle description=TextStyle(fontFamily: 'Outfit',
    fontWeight: FontWeight.w400,fontSize: scrWidth*0.031,color: Color(0xff000000).withOpacity(0.5)
);
TextStyle googlelogin=TextStyle(fontSize:scrWidth*0.045,fontFamily: 'Outfit',fontWeight: FontWeight.w500,color: Color(0xff615F5F));

TextStyle tababrnumberFont=TextStyle(
    color: Colors.black,
    fontSize:  scrWidth*0.04,
    fontFamily: 'Urbanist',
    fontWeight: FontWeight.w500);
TextStyle chitcardone10=TextStyle(
    fontSize: scrWidth*0.027,
    color: Color(0xff989898),
    fontFamily: 'Urbanist',
    fontWeight:
    FontWeight.w700);
TextStyle chitcardtwomonth10=TextStyle(
    fontSize: scrWidth*0.027,
    color: Color(0xff989898),
    fontFamily: 'Urbanist',
    fontWeight:
    FontWeight.w600);

TextStyle chitcard15=TextStyle(
  color: Color(0xff2C2C2C),
  fontSize: scrWidth*0.042,
  fontWeight: FontWeight.w700,
  fontFamily: 'Urbanist',
);
TextStyle tenmonthsfont=TextStyle(
  fontSize: scrWidth*0.035,
  fontWeight:
  FontWeight.w700,
  fontFamily: 'Urbanist',
  color:Color(0xffA4A4A4),
);
TextStyle valuefontchit=TextStyle(
  fontSize: scrWidth*0.035,
  fontWeight:
  FontWeight.w700,
  fontFamily: 'Urbanist',
  color: primarycolor,
);
TextStyle tenbytenfont=TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: scrWidth*0.027,
    fontFamily: 'Urbanist'

);

