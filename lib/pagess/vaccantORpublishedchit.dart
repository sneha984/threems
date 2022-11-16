import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/pagess/approvepage.dart';
import 'package:threems/pagess/winnerpage.dart';

import '../kuri/createkuri.dart';
import '../model/ChitModel.dart';
import '../model/usermodel.dart';
import '../screens/splash_screen.dart';
import '../utils/customclip2.dart';
import '../utils/themes.dart';

class VaccantOrPublishedChit extends StatefulWidget {
  final String id;
  const VaccantOrPublishedChit({Key? key, required this.id}) : super(key: key);

  @override
  State<VaccantOrPublishedChit> createState() => _VaccantOrPublishedChitState();
}

class _VaccantOrPublishedChitState extends State<VaccantOrPublishedChit> {
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

  FocusNode dialogueAuctionAmountNode = FocusNode();
  FocusNode dialoguePayableAmountNode = FocusNode();
  FocusNode dialogueDividentNode = FocusNode();

  @override
  void initState() {
    super.initState();
    listenChit();
  }

  @override
  void dispose() {
    dialogueAuctionAmountNode.dispose();
    dialoguePayableAmountNode.dispose();
    dialogueDividentNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chit == null
        ? Center(child: CircularProgressIndicator())
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
                              chit!.membersCount == chit!.members!.length
                                  ? "Registrations Closed"
                                  : "On Progress",
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
                                    image: NetworkImage(chit!.profile!))),
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
                                chit!.private! ? "Private Chit" : "Public Chit",
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
                                      return GestureDetector(
                                        onTap: () {
                                          if (chit!.status == 2) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApprovePage()));
                                          }
                                        },
                                        child: Container(
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
                                                      image: NetworkImage(
                                                          members[index]
                                                              .userImage!),
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
                                            subtitle: chit!.status == 2
                                                ? Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom:
                                                                    scrHeight *
                                                                        0.02,
                                                                top: scrHeight *
                                                                    0.004),
                                                        child: Text(
                                                          "₹5,000",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 13,
                                                              color: Color(
                                                                  0xff969696)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: scrWidth * 0.02,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                bottom:
                                                                    scrHeight *
                                                                        0.018),
                                                        child: Container(
                                                          width: (index == 0)
                                                              ? scrWidth * 0.15
                                                              : scrWidth * 0.1,
                                                          height:
                                                              scrHeight * 0.017,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: (index ==
                                                                          0)
                                                                      ? Color(
                                                                          0xff8391A1)
                                                                      : (index ==
                                                                              2)
                                                                          ? Color(
                                                                              0xffF61C0D)
                                                                          : Color(
                                                                              0xff02B558),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3)),
                                                          child: Center(
                                                            child: (index == 0)
                                                                ? Text(
                                                                    "Pending",
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
                                                                : (index == 2)
                                                                    ? Text(
                                                                        "Due",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Urbanist',
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize: scrWidth *
                                                                                0.026,
                                                                            color:
                                                                                Colors.white),
                                                                      )
                                                                    : Text(
                                                                        "Due",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                'Urbanist',
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize: scrWidth *
                                                                                0.026,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : SizedBox(),
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
                      ),
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
                          width: scrWidth * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ApprovePage()));
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
                              "Draw",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.047,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist'),
                            )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
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
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: scrHeight * 0.08,
                    color: primarycolor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (members.length == chit!.membersCount!) {
                              moveToVaccant(1);
                            } else {
                              showSnackbar(context,
                                  'Your chit is must be full to publish');
                            }

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>HostedVacantChitPage()));
                          },
                          child: Container(
                            height: scrHeight * 0.08,
                            width: scrWidth * 0.5,
                            child: Center(
                                child: Text(
                              "Publish",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.05,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                  color: Colors.white),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
          );
  }

  void moveToVaccant(int status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.only(top: 29, bottom: 23, left: 21, right: 21),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Do you want to publish this Chit?',
                  style: TextStyle(
                    color: Color(0xff2C2C2C),
                    fontSize: 15,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        intensity: 0.5,
                        surfaceIntensity: 0.3,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(34)),
                        depth: -1,
                        shadowLightColorEmboss: Colors.grey.withOpacity(0.9),
                        lightSource: LightSource.topLeft,
                        shadowDarkColorEmboss: Colors.white,
                        oppositeShadowLightSource: true,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 109,
                          height: 44,
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
                                fontSize: 15,
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Neumorphic(
                      style: NeumorphicStyle(
                        intensity: 0.5,
                        surfaceIntensity: 0.3,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(34)),
                        depth: -1,
                        shadowLightColorEmboss: Colors.black,
                        lightSource: LightSource.topLeft,
                        shadowDarkColorEmboss: Colors.white,
                        oppositeShadowLightSource: true,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('chit')
                              .doc(widget.id)
                              .update({'status': 2}).then((value) {
                            Navigator.pop(context);
                            showSnackbar(
                                context, 'Successfully published your chit');
                          });
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 109,
                          height: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(34),
                            color: Color(0xff02B558),
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
                                fontSize: 15,
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
          ),
        );
      },
    );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WinnerPage()));
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
}
