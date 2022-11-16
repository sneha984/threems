import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/chits/chitsucesspaid.dart';

import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/customclip2.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'chit_Payment_Page.dart';

class YourChitPage extends StatefulWidget {
  final String id;
  const YourChitPage({Key? key, required this.id}) : super(key: key);

  @override
  State<YourChitPage> createState() => _YourChitPageState();
}

class _YourChitPageState extends State<YourChitPage> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  ChitModel? chit;
  List<UserModel> members = [];

  listenChit() {
    FirebaseFirestore.instance
        .collection('chit')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      chit = ChitModel.fromJson(event.data()!);

      if (mounted) {
        setState(() {
          getMembers();
        });
      }
    });
  }

  getMembers() async {
    members = [];
    for (int i = 0; i < chit!.members!.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(chit!.members![i])
          .get();
      members.add(UserModel.fromJson(doc.data()!));
    }
    setState(() {});
  }

  FocusNode payableAmountNode = FocusNode();

  @override
  void dispose() {
    payableAmountNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    listenChit();
  }

  @override
  Widget build(BuildContext context) {
    return chit == null
        ? Container(
            width: scrWidth,
            height: scrHeight,
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: Stack(
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
                              chit!.status == 2
                                  ? "Registrations Closed"
                                  : "In Vacant",
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
                              image: DecorationImage(
                                  image: NetworkImage(chit!.profile ?? ''),
                                  fit: BoxFit.fill),
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
                                chit!.chitName!,
                                style: TextStyle(
                                    fontSize: scrWidth * 0.045,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Urbanist',
                                    color: Colors.white),
                              ),
                              Text(
                                "${chit!.private! ? "Private" : "Public"} Chit",
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
                                    Text(
                                        '$_currency ${_formatNumber(
                                          chit!.subscriptionAmount!
                                              .truncate()
                                              .toString()
                                              .replaceAll(',', ''),
                                        )}',
                                        style: valuefontchit),
                                    Text(
                                        "/${chit!.chitType == 'Monthly' ? 'Month' : 'Week'}",
                                        style: chitcardtwomonth10),
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
                                            padding: EdgeInsets.all(
                                                scrWidth * 0.025),
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
                                              "Commission",
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
                                              chit!.commission!,
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
                                            padding: EdgeInsets.all(
                                                scrWidth * 0.026),
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
                                              '$_currency ${_formatNumber(
                                                chit!.amount!
                                                    .truncate()
                                                    .toString()
                                                    .replaceAll(',', ''),
                                              )}',
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
                                            padding: EdgeInsets.all(
                                                scrWidth * 0.026),
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
                                              "${chit!.duration!} Months",
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
                                            padding: EdgeInsets.all(
                                                scrWidth * 0.027),
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
                                              "${chit!.members!.length}/${chit!.membersCount}",
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
                                  "Next Draw Date",
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
                                  chit!.chitType == 'Monthly'
                                      ? DateTime(DateTime.now().year, DateTime.now().month, chit!.chitDate!, int.parse(chit!.chitTime!.split(':')[0]), int.parse(chit!.chitTime!.split(':')[1]))
                                              .isAfter(DateTime.now())
                                          ? DateFormat('dd MMM yyyy').format(
                                              DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  chit!.chitDate!))
                                          : DateFormat('dd MMM yyyy').format(
                                              DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month + 1,
                                                  chit!.chitDate!))
                                      :

                                      //Showing Next Date in weekly methode
                                      DateTime.now().weekday < chit!.chitDate!
                                          ? DateFormat('dd MMM yyyy').format(
                                              DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  DateTime.now().weekday -
                                                      chit!.chitDate!))
                                          : DateFormat('dd MMM yyyy').format(
                                              DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  (7 - DateTime.now().weekday) +
                                                      chit!.chitDate!)),
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
                                  "Draw Time",
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
                                  int.parse(chit!.chitTime!.split(':')[0]) > 12
                                      ? (int.parse(chit!.chitTime!
                                                      .split(':')[0]) -
                                                  12) >
                                              9
                                          ? '${int.parse(chit!.chitTime!.split(':')[0]) - 12}:${int.parse(chit!.chitTime!.split(':')[1]) > 9 ? int.parse(chit!.chitTime!.split(':')[1]) : '0${int.parse(chit!.chitTime!.split(':')[1])}'} pm'
                                          : '0${int.parse(chit!.chitTime!.split(':')[0]) - 12}:${int.parse(chit!.chitTime!.split(':')[1]) > 9 ? int.parse(chit!.chitTime!.split(':')[1]) : '0${int.parse(chit!.chitTime!.split(':')[1])}'} pm'
                                      : (int.parse(chit!.chitTime!
                                                  .split(':')[0])) >
                                              9
                                          ? '${int.parse(chit!.chitTime!.split(':')[0])}:${int.parse(chit!.chitTime!.split(':')[1]) > 9 ? int.parse(chit!.chitTime!.split(':')[1]) : '0${int.parse(chit!.chitTime!.split(':')[1])}'} am'
                                          : '0${int.parse(chit!.chitTime!.split(':')[0])}:${int.parse(chit!.chitTime!.split(':')[1]) > 9 ? int.parse(chit!.chitTime!.split(':')[1]) : '0${int.parse(chit!.chitTime!.split(':')[1])}'} am',
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
                        child: Container(
                            height: scrHeight * 0.2,
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
                                        Text("${chit!.members!.length}",
                                            style: valuefontchit),
                                        Text("/${chit!.membersCount}",
                                            style: valuefontchit),
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
                                    itemCount: members.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return members.isEmpty
                                          ? Center(
                                              child: Text(
                                                'There is no members',
                                                style: TextStyle(
                                                  color: Color(0xff02B558),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: scrWidth * 0.02,
                                              height: scrHeight * 0.075,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Color(0xffF3F3F3)),
                                              child: ListTile(
                                                leading: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          scrHeight * 0.015),
                                                  child: Container(
                                                    width: scrWidth * 0.12,
                                                    height: scrHeight * 0.05,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: Colors.black,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              members[index]
                                                                      .userImage ??
                                                                  ""),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                                title: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: scrHeight * 0.01),
                                                  child: Text(
                                                    members[index].userName!,
                                                    style: TextStyle(
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            scrWidth * 0.045),
                                                  ),
                                                ),
                                                trailing: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: scrHeight * 0.01),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/menuicon.svg",
                                                  ),
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              scrHeight * 0.02,
                                                          top: scrHeight *
                                                              0.004),
                                                      child: Text(
                                                        '$_currency ${_formatNumber(
                                                          chit!
                                                              .subscriptionAmount!
                                                              .truncate()
                                                              .toString()
                                                              .replaceAll(
                                                                  ',', ''),
                                                        )}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13,
                                                            color: Color(
                                                                0xff969696)),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: scrWidth * 0.02,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: scrHeight *
                                                              0.018),
                                                      child: Container(
                                                        width: scrWidth * 0.1,
                                                        height:
                                                            scrHeight * 0.017,
                                                        decoration: BoxDecoration(
                                                            color: (index == 1)
                                                                ? Color(
                                                                    0xffF61C0D)
                                                                : Color(
                                                                    0xff02B558),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3)),
                                                        child: Center(
                                                          child: (index == 1)
                                                              ? Text(
                                                                  "Due",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          scrWidth *
                                                                              0.026,
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              : Text(
                                                                  "Paid",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          scrWidth *
                                                                              0.026,
                                                                      color: Colors
                                                                          .white),
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
            bottomNavigationBar: chit!.status == 2
                ? Container(
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
                              "payable Amount",
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
                              '$_currency ${_formatNumber(
                                chit!.subscriptionAmount!
                                    .truncate()
                                    .toString()
                                    .replaceAll(',', ''),
                              )}',
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChitPaymentPage(
                                    chit: chit!,
                                  ),
                                ));

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>VacantChitJoinPage()));
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
                  )
                : Container(
                    height: scrHeight * 0.05,
                    color: primarycolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Chit is not Started yet!!!",
                          style: TextStyle(
                              fontSize: scrWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Urbanist',
                              color: Color(0xffFBED5D)),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
