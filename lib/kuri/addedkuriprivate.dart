import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../screens/splash_screen.dart';
import '../utils/customclip2.dart';
import '../utils/themes.dart';

class AddedKuriPrivate extends StatefulWidget {
  const AddedKuriPrivate({Key? key}) : super(key: key);

  @override
  State<AddedKuriPrivate> createState() => _AddedKuriPrivateState();
}

class _AddedKuriPrivateState extends State<AddedKuriPrivate> {
  void joinChit() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.only(
              top: scrHeight * 0.025,
              left: scrWidth * 0.05,
              right: scrWidth * 0.02),
          contentPadding: EdgeInsets.only(
              top: scrHeight * 0.002,
              bottom: scrHeight * 0.02,
              left: scrWidth * 0.05,
              right: scrWidth * 0.02),
          title: Text(
            "Are you sure you don't want to continue on this kuri?",
            style: TextStyle(
              color: Color(0xff2C2C2C),
              fontSize: FontSize15,
              fontFamily: "Urbanist",
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: scrHeight * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: scrWidth * 0.3,
                    height: scrHeight * 0.058,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      color: Color(0xffDEDEDE),
                      boxShadow: [
                        //
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: -4,
                          // offset: Offset(0, -4),
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xff2C2C2C),
                          fontSize: FontSize16,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: scrWidth * 0.3,
                    height: scrHeight * 0.058,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(34),
                      color: primarycolor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          spreadRadius: -4,
                          // offset: Offset(0, -4),
                          color: Colors.black.withOpacity(0.15),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Color(0xff2C2C2C),
                          fontSize: FontSize16,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: scrWidth * 0.001,
                  ),
                ],
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: scrWidth * 1,
                height: scrHeight * 0.36,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/icons/background.png"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: scrHeight * 0.085,
                    left: scrWidth * 0.08,
                    right: scrWidth * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        "assets/icons/whitearrow.svg",
                      ),
                    ),
                    PopupMenuButton<MenuItem>(
                      constraints: BoxConstraints(
                          maxWidth: 150,
                          minWidth: 150,
                          maxHeight: 100,
                          minHeight: 100),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      position: PopupMenuPosition.under,
                      child: SvgPicture.asset(
                        "assets/icons/whitemenuicon.svg",
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            // Uri call = Uri.parse('http://wa.me/91${ku!}');
                            //
                            // launchUrl(call);
                          },
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
                      ],
                    ),
                  ],
                ),
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
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),
                            Text(
                              "Rasheed's Daughter Wedding",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.045,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Urbanist',
                                  color: Colors.white),
                            ),
                            Text(
                              "The room created by Rasheed",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                  color: Color.fromRGBO(255, 255, 255, 0.71)),
                            ),
                            // SizedBox(
                            //   height: scrHeight * 0.02,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: scrHeight * 0.025,
                    ),
                    Container(
                      height: scrHeight * 0.245,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: scrWidth * 0.03),
                                child: Container(
                                  child: Center(
                                      child: Text("20 Days Left",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: scrWidth * 0.025,
                                              fontFamily: 'Urbanist'))),
                                  height: scrHeight * 0.023,
                                  width: scrWidth * 0.22,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(
                                          scrWidth * 0.04)),
                                ),
                              ),
                              CustomPaint(
                                size: Size(scrWidth * 0.4,
                                    (scrWidth * 0.04).toDouble()),
                                painter: RPCustomPainter(),
                                child: Container(
                                  width: scrWidth * 0.17,
                                  height: scrHeight * 0.025,
                                  padding:
                                      EdgeInsets.only(left: scrWidth * 0.04),
                                  child: Center(
                                    child: Text(
                                      "Private",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: scrWidth * 0.027,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: scrHeight * 0.02,
                          ),
                          LinearPercentIndicator(
                            //leaner progress bar
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: scrHeight * 0.025,
                            width: scrWidth * 0.86,
                            percent: 0.3,
                            alignment: MainAxisAlignment.start,
                            barRadius: Radius.circular(scrWidth * 0.2),
                            progressColor: primarycolor,
                            backgroundColor: Color(0xffD9D9D9),
                          ),
                          SizedBox(
                            height: scrHeight * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Collected",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff989898),
                                        fontSize: scrWidth * 0.026,
                                        fontFamily: 'Urbanist'),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.002,
                                  ),
                                  Text(
                                    "₹25,000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: primarycolor,
                                        fontSize: scrWidth * 0.026,
                                        fontFamily: 'Urbanist'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: scrWidth * 0.35,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Value",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff989898),
                                        fontSize: scrWidth * 0.026,
                                        fontFamily: 'Urbanist'),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.002,
                                  ),
                                  Text(
                                    "₹5,00,000",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: primarycolor,
                                        fontSize: scrWidth * 0.026,
                                        fontFamily: 'Urbanist'),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            thickness: 0.9,
                            indent: 10,
                            endIndent: 10,
                          ),
                          SizedBox(
                            height: scrHeight * 0.007,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: scrWidth * 0.04,
                              ),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  intensity: 0.5,
                                  surfaceIntensity: 0.3,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(16)),
                                  depth: -1,
                                  shadowLightColorEmboss:
                                      Colors.grey.withOpacity(0.9),
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
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(scrWidth * 0.026),
                                          child: SvgPicture.asset(
                                            "assets/icons/duration.svg",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: scrWidth * 0.015,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: scrHeight * 0.015,
                                          ),
                                          Text(
                                            "Deadline",
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
                                            "22 March",
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
                                  intensity: 0.5,
                                  surfaceIntensity: 0.3,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(16)),
                                  depth: -1,
                                  shadowLightColorEmboss:
                                      Colors.grey.withOpacity(0.9),
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
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(scrWidth * 0.026),
                                          child: SvgPicture.asset(
                                            "assets/icons/members.svg",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: scrWidth * 0.015,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            "25",
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
                      height: scrHeight * 0.2,
                    ),
                    Text(
                      "You Can't view \n  the Members",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: 'Urbanist',
                          color: Color(0xff989898)),
                    )
                  ],
                ),
              ),
            ],
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
                  "₹25,000/5,00,000",
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
              onTap: () {
                joinChit();
              },
              child: Container(
                height: scrHeight * 0.045,
                width: scrWidth * 0.27,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                    child: Text(
                  "Pay",
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
