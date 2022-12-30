import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/splash_screen.dart';
import '../utils/customclip2.dart';
import '../utils/themes.dart';

class HostedVacantChitPage extends StatefulWidget {
  const HostedVacantChitPage({Key? key}) : super(key: key);

  @override
  State<HostedVacantChitPage> createState() => _HostedVacantChitPageState();
}

class _HostedVacantChitPageState extends State<HostedVacantChitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: scrWidth * 1,
                  height: scrHeight * 0.36,
                  // color: Colors.green,
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
                              "Vacancy Available",
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
                        height: scrHeight * 0.274,
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
                            SizedBox(
                              height: scrHeight * 0.016,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // SizedBox(width: scrWidth*0.1,),
                                Text("Fixed Divident Amount",
                                    style: chitcardtwomonth10),
                                SizedBox(
                                  width: scrWidth * 0.0003,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("₹1.000", style: valuefontchit),
                                    Text("/month", style: chitcardtwomonth10),
                                    SizedBox(
                                      width: scrWidth * 0.005,
                                    ),
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
                              height: scrHeight * 0.015,
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
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.05),
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.05),
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.05),
                                            blurRadius: 5.0,
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(16)),
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
                                              "8/10",
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
                        height: scrHeight * 0.015,
                      ),
                      Container(
                        height: scrHeight * 0.058,
                        width: scrWidth * 1,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffF4F4F4), width: 1),
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
                                  "Next Drawn Date",
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
                                  "Drawn date and Time is not revealed ",
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: scrWidth * 0.043,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: scrHeight * 0.02,
                      ),
                      Container(
                        height: scrHeight * 0.25,
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
                                    Text("2", style: valuefontchit),
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
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(
                                  left: scrWidth * 0.04,
                                  right: scrWidth * 0.04,
                                  top: scrHeight * 0.003),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 2,
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
                                          top: scrHeight * 0.003),
                                      child: Container(
                                        width: scrWidth * 0.12,
                                        height: scrHeight * 0.05,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: Colors.black,
                                          image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7FtTfAHZpWXQI8X4ppt-7QKqQae6h6BYhyw&usqp=CAU"),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    title: Padding(
                                      padding: EdgeInsets.only(
                                          top: scrHeight * 0.003),
                                      child: Text(
                                        "akhilgeorge",
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600,
                                            fontSize: scrWidth * 0.045),
                                      ),
                                    ),
                                    trailing: Padding(
                                      padding: EdgeInsets.only(
                                          left: scrWidth * 0.04),
                                      child: Container(
                                        height: scrHeight * 0.035,
                                        width: scrWidth * 0.2,
                                        decoration: BoxDecoration(
                                            color: Color(0xff02B558),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            "Accept",
                                            style: TextStyle(
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Color(0xffffffff)),
                                          ),
                                        ),
                                      ),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: scrHeight * 0.02,
                      ),
                      SizedBox(
                        child: Container(
                            height: scrHeight * 0.44,
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: scrHeight * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                        Text("8", style: valuefontchit),
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
                                Container(
                                  // height: ,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    // reverse: true,
                                    padding: EdgeInsets.only(
                                        left: scrWidth * 0.04,
                                        right: scrWidth * 0.04,
                                        top: scrHeight * 0.003),
                                    physics: NeverScrollableScrollPhysics(),
                                    // scrollDirection: Axis.vertical,
                                    itemCount: 4,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: scrWidth * 0.02,
                                        height: scrHeight * 0.075,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                                    image: CachedNetworkImageProvider(
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
                                          trailing: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: scrHeight * 0.01),
                                            child: SvgPicture.asset(
                                              "assets/icons/menuicon.svg",
                                            ),
                                          ),
                                          subtitle: Padding(
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
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>YourChitPage()));
        },
        child: Container(
          height: scrHeight * 0.08,
          color: Color(0xff74FCAD),
          child: Center(
              child: Text(
            "You can't publish",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                fontWeight: FontWeight.w600,
                fontFamily: 'Urbanist'),
          )),
        ),
      ),
    );
  }
}
