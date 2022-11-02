import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/pagess/winnerpage.dart';

import '../../utils/customclip2.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';


class Hostedchitperspage extends StatefulWidget {
  const Hostedchitperspage({Key? key}) : super(key: key);

  @override
  State<Hostedchitperspage> createState() => _HostedchitperspageState();
}

class _HostedchitperspageState extends State<Hostedchitperspage> {

  FocusNode dialogueAuctionAmountNode = FocusNode();
  FocusNode dialoguePayableAmountNode = FocusNode();
  FocusNode dialogueDividentNode = FocusNode();

  @override
  void dispose() {
    dialogueAuctionAmountNode.dispose();
    dialoguePayableAmountNode.dispose();
    dialogueDividentNode.dispose();
    super.dispose();
  }

  void payChitAmount() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          dialogueAuctionAmountNode.addListener(() {
            setState(() {});
          });
          dialoguePayableAmountNode.addListener(() {
            setState(() {});
          });
          dialogueDividentNode.addListener(() {
            setState(() {});
          });
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Pay the chit amount of September'),
            titleTextStyle: TextStyle(
                fontSize: FontSize10,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xff827C7C)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 16,
                    ),
                    Container(
                        margin: EdgeInsets.all(14),
                        child: Text(
                          "akhilgeorge",
                          style: TextStyle(
                              fontSize: FontSize16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ))
                  ],
                ),
                SizedBox(
                  height: scrWidth * 0.05,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: dialogueAuctionAmountNode,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Auction Amount',
                      labelStyle: TextStyle(
                        color: dialogueAuctionAmountNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                    fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.03,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: dialoguePayableAmountNode,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Payable Amount',
                      labelStyle: TextStyle(
                        color: dialoguePayableAmountNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                    fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.03,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.026),
                  ),
                  child: TextFormField(
                    focusNode: dialogueDividentNode,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Divident Amount',
                      labelStyle: TextStyle(
                        color: dialogueDividentNode.hasFocus
                            ? primarycolor
                            : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      // prefixIcon: Container(
                      //   height: scrWidth * 0.045,
                      //   width: 10,
                      //   padding: EdgeInsets.all(
                      //       scrWidth * 0.033),
                      //   child: SvgPicture.asset(
                      //     'assets/icons/subscription.svg',
                      //     fit: BoxFit.contain,
                      //     color: textFormUnFocusColor,
                      //   ),
                      // ),
                    fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.06,
                ),
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>WinnerPage()));
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: FontSize16,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: scrWidth * 1,
            height: scrHeight * 0.36,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/icons/background.png"),
                    fit: BoxFit.fill)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: scrHeight * 0.09,
                      left: scrWidth * 0.06,
                      bottom: scrHeight * 0.008),
                  child: SvgPicture.asset(
                    "assets/icons/whitearrow.svg",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: scrHeight * 0.09),
                child: CustomPaint(
                  size: Size(
                      scrWidth * 0.4,
                      (scrWidth * 0.04)
                          .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                  painter: RPCustomPainter(),
                  child: Container(
                    width: scrWidth * 0.33,
                    height: scrHeight * 0.027,
                    padding: EdgeInsets.only(left: scrWidth * 0.04),
                    child: Center(
                      child: Text(
                        "Registrations Closed",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: scrWidth * 0.027,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.14,
                left: scrWidth * 0.06,
                right: scrWidth * 0.06),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: scrWidth * 0.15,
                      height: scrHeight * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: scrWidth * 0.03,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "First Logic Chit",
                          style: TextStyle(
                              fontSize: scrWidth * 0.045,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Urbanist',
                              color: Colors.white),
                        ),
                        Text(
                          "Private Chit",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                              color: Color.fromRGBO(255, 255, 255, 0.71)),
                        ),
                        SizedBox(
                          height: scrHeight * 0.02,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: scrWidth * 0.34,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: scrHeight * 0.02),
                      child: SvgPicture.asset(
                        "assets/icons/editingicon.svg",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                Container(
                  height: scrHeight * 0.23,
                  width: scrWidth * 1,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 25.0,
                            offset: Offset(0, 4)),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.5)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: scrHeight * 0.018,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Subscription", style: chitcardtwomonth10),
                          SizedBox(
                            width: scrWidth * 0.1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("₹2.000", style: valuefontchit),
                              Text("/month", style: chitcardtwomonth10),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 0.9,
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                        height: scrHeight * 0.005,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: scrWidth * 0.04,
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(
                              intensity:0.5 ,
                              surfaceIntensity: 0.3,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16)),
                              depth: -1,
                              shadowLightColorEmboss: Colors.grey.withOpacity(0.9),
                              lightSource: LightSource.topLeft,
                              shadowDarkColorEmboss: Colors.white,
                              oppositeShadowLightSource: true,
                            ),
                            child: Container(
                              height: scrHeight * 0.067,
                              width: scrWidth * 0.38,
                              decoration: BoxDecoration(
                                  color: Color(0xffEEEEEE),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: scrWidth * 0.02,
                                  ),
                                  Container(
                                    height: scrHeight * 0.048,
                                    width: scrWidth * 0.12,
                                    decoration: BoxDecoration(
                                        color: Color(0xff02B558),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: EdgeInsets.all(9),
                                      child: SvgPicture.asset(
                                        "assets/icons/commision.svg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.02,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: scrHeight * 0.013,
                                      ),
                                      Text(
                                        "Commision",
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.026,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff827C7C)),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.003,
                                      ),
                                      Text(
                                        "2%",
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.042,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Urbanist'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: scrWidth * 0.035,
                          ),

                          Neumorphic(
                            style: NeumorphicStyle(
                              intensity:0.5 ,
                              surfaceIntensity: 0.3,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16)),
                              depth: -1,
                              shadowLightColorEmboss: Colors.grey.withOpacity(0.9),
                              lightSource: LightSource.topLeft,
                              shadowDarkColorEmboss: Colors.white,
                              oppositeShadowLightSource: true,
                            ),
                            child: Container(
                              height: scrHeight * 0.067,
                              width: scrWidth * 0.38,
                              decoration: BoxDecoration(
                                  color: Color(0xffEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: scrWidth * 0.02,
                                  ),
                                  Container(
                                    height: scrHeight * 0.048,
                                    width: scrWidth * 0.12,
                                    decoration: BoxDecoration(
                                        color: Color(0xff02B558),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        "assets/icons/chit value.svg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.02,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: scrHeight * 0.015,
                                      ),
                                      Text(
                                        "Chit Value",
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.026,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff827C7C)),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.003,
                                      ),
                                      Text(
                                        "₹50,000",
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.042,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Urbanist'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: scrHeight * 0.013,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: scrWidth * 0.04,
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(
                              intensity:0.5 ,
                              surfaceIntensity: 0.3,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16)),
                              depth: -1,
                              shadowLightColorEmboss: Colors.grey.withOpacity(0.9),
                              lightSource: LightSource.topLeft,
                              shadowDarkColorEmboss: Colors.white,
                              oppositeShadowLightSource: true,
                            ),
                            child: Container(
                              height: scrHeight * 0.067,
                              width: scrWidth * 0.38,
                              decoration: BoxDecoration(
                                  color: Color(0xffEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: scrWidth * 0.02,
                                  ),
                                  Container(
                                    height: scrHeight * 0.048,
                                    width: scrWidth * 0.12,
                                    decoration: BoxDecoration(
                                        color: Color(0xff02B558),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        "assets/icons/duration.svg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.015,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: scrHeight * 0.015,
                                      ),
                                      Text(
                                        "Duration/Monthly",
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.026,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff827C7C)),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.003,
                                      ),
                                      Text(
                                        "10 Months",
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.042,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Urbanist'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: scrWidth * 0.04,
                          ),
                          Neumorphic(
                            style: NeumorphicStyle(
                              intensity:0.5 ,
                              surfaceIntensity: 0.3,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(16)),
                              depth: -1,
                              shadowLightColorEmboss: Colors.grey.withOpacity(0.9),
                              lightSource: LightSource.topLeft,
                              shadowDarkColorEmboss: Colors.white,
                              oppositeShadowLightSource: true,
                            ),
                            child: Container(
                              height: scrHeight * 0.067,
                              width: scrWidth * 0.38,
                              decoration: BoxDecoration(
                                  color: Color(0xffEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.05),
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: scrWidth * 0.02,
                                  ),
                                  Container(
                                    height: scrHeight * 0.048,
                                    width: scrWidth * 0.12,
                                    decoration: BoxDecoration(
                                        color: Color(0xff02B558),
                                        borderRadius: BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        "assets/icons/members.svg",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.015,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: scrHeight * 0.012,
                                      ),
                                      Text(
                                        "Members",
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.026,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff827C7C)),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.003,
                                      ),
                                      Text(
                                        "10/10",
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.042,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Urbanist'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.01,
                ),
                Container(
                  height: scrHeight * 0.058,
                  width: scrWidth * 1,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF4F4F4), width: 1),
                      color: Color(0xff02B558),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: scrWidth * 0.025,
                      ),
                      SvgPicture.asset(
                        "assets/icons/date.svg",
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: scrWidth * 0.021,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: scrHeight * 0.008,
                          ),
                          Text(
                            "Next Auction Date",
                            style: TextStyle(
                                fontSize: scrWidth * 0.026,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Urbanist',
                                color: Color(0xffFBED5D)),
                          ),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                            "10 Sep 2022",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: scrWidth * 0.042,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: scrWidth * 0.26,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: scrHeight * 0.01,
                          ),
                          Text(
                            "Auction Time",
                            style: TextStyle(
                                fontSize: scrWidth * 0.026,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Urbanist',
                                color: Color(0xffFBED5D)),
                          ),
                          SizedBox(
                            height: 0.02,
                          ),
                          Text(
                            "07:00 pm",
                            style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: scrWidth * 0.042,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: scrWidth * 0.01,
                      ),
                      SvgPicture.asset(
                        "assets/icons/timen.svg",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.015,
                ),

                Expanded(
                  // height: 390,

                  child: Container(
                      height: scrHeight * 0.372,
                      width: scrWidth * 1,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 25.0,
                              offset: Offset(0, 4)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            17.5,
                          ),
                          topLeft: Radius.circular(
                            17.5,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: scrHeight * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "Members",
                                style: TextStyle(
                                  fontSize: scrWidth * 0.027,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff827C7C),
                                ),
                              ),
                              SizedBox(
                                width: scrWidth * 0.09,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("10", style: valuefontchit),
                                  Text("/10", style: valuefontchit),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 0.9,
                            indent: 10,
                            endIndent: 10,
                          ),
                          Expanded(
                            child: ListView.separated(
                               shrinkWrap: true,
                              // reverse: true,
                              padding: EdgeInsets.only(
                                  left: scrWidth * 0.04,
                                  right: scrWidth * 0.04,
                                  top: scrHeight * 0.003),
                              physics: BouncingScrollPhysics(),
                               scrollDirection: Axis.vertical,
                              itemCount: 5,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: scrWidth * 0.02,
                                  height: scrHeight * 0.075,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xffF3F3F3)),
                                  child: ListTile(
                                    leading: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: scrHeight * 0.015),
                                      child: Container(
                                        width: scrWidth * 0.12,
                                        height: scrHeight * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.black,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7FtTfAHZpWXQI8X4ppt-7QKqQae6h6BYhyw&usqp=CAU"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          top: scrHeight * 0.01),
                                      child: Text(
                                        "akhilgeorge",
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                            fontSize: scrWidth * 0.045),
                                      ),
                                    ),
                                    trailing: PopupMenuButton<MenuItem>(
                                      constraints: BoxConstraints(
                                          maxWidth: 150,
                                          minWidth: 150,
                                          maxHeight: 200,
                                          minHeight: 200),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      position: PopupMenuPosition.under,
                                      child:SvgPicture.asset(
                                        "assets/icons/menuicon.svg",
                                      ),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          height: 30,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 15,
                                                width: 15,
                                                child: SvgPicture.asset(
                                                  'assets/icons/whatsapp.svg',
                                                  color: Colors.black,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Whatsapp",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize13,
                                                  fontFamily: "Urbanist",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 1),
                                                height: 15,
                                                width: 15,
                                                child: SvgPicture.asset(
                                                  'assets/icons/call.svg',
                                                  color: Colors.black,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Call",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize13,
                                                  fontFamily: "Urbanist",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 1),
                                                height: 15,
                                                width: 15,
                                                child: SvgPicture.asset(
                                                  'assets/icons/trash.svg',
                                                  color: Colors.black,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Remove",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize13,
                                                  fontFamily: "Urbanist",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 1),
                                                height: 15,
                                                width: 15,
                                                child: SvgPicture.asset(
                                                  'assets/icons/connected.svg',
                                                  color: Colors.black,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Add to friend",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize13,
                                                  fontFamily: "Urbanist",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                // padding: EdgeInsets.symmetric(horizontal: 1),
                                                height: 15,
                                                width: 15,
                                                child: SvgPicture.asset(
                                                  'assets/icons/replace.svg',
                                                  color: Colors.black,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Replace ",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: FontSize13,
                                                  fontFamily: "Urbanist",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 30,
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 5),
                                              width: 115,
                                              height: 21,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Color(0xffF61C0D),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "PAY CHIT AMOUNT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: FontSize10,
                                                    fontFamily: "Urbanist",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: scrHeight * 0.02,
                                              top: scrHeight * 0.004),
                                          child: Text(
                                            "₹5,000",
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13,
                                                color: Color(0xff969696)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.02,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: scrHeight * 0.018),
                                          child: Container(
                                            width: scrWidth * 0.1,
                                            height: scrHeight * 0.017,
                                            decoration: BoxDecoration(
                                                color: (index == 2)
                                                    ? Color(0xffF61C0D)
                                                    : Color(0xff02B558),
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            child: Center(
                                              child: (index == 2)
                                                  ? Text(
                                                      "Due",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: scrWidth *
                                                              0.026,
                                                          color:
                                                              Colors.white),
                                                    )
                                                  : Text(
                                                      "Paid",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: scrWidth *
                                                              0.026,
                                                          color:
                                                              Colors.white),
                                                    ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  height: scrHeight * 0.01,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: scrHeight * 0.08,
        color: primarycolor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: scrHeight * 0.02,
                ),
                Text(
                  "Total Collected Amount",
                  style: TextStyle(
                      fontSize: scrWidth * 0.026,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist',
                      color: Color(0xffFBED5D)),
                ),
                SizedBox(
                  height: scrHeight * 0.002,
                ),
                Text(
                  "₹35,000/50,000",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: scrWidth * 0.044,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                )
              ],
            ),
            SizedBox(
              width: scrWidth * 0.04,
            ),
            GestureDetector(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>WinnerPage()));
                setState(() {
                  payChitAmount();

                });

              },
              child: Container(
                height: scrHeight * 0.045,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                    child: Text(
                  "Auction",
                  style: TextStyle(
                      fontSize: scrWidth * 0.047,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist'),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

}
