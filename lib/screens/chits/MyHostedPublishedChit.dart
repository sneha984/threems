import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../kuri/createkuri.dart';
import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../splash_screen.dart';
import '../../utils/customclip2.dart';
import '../../utils/themes.dart';
import '../../pagess/approvepage.dart';
import 'Chit__Chat_Screen.dart';
import 'Draw_OPTOUT_Page.dart';
import 'chit_winners_Short_List.dart';
import 'create_new_chit_screen.dart';

class MyHostedPublishedChit extends StatefulWidget {
  final String id;
  const MyHostedPublishedChit({Key? key, required this.id}) : super(key: key);

  @override
  State<MyHostedPublishedChit> createState() => _MyHostedPublishedChitState();
}

class _MyHostedPublishedChitState extends State<MyHostedPublishedChit> {
  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  TextEditingController amount = TextEditingController();
  TextEditingController payableAmount = TextEditingController();
  TextEditingController dividend = TextEditingController();

  String? winnerName;
  String? winnerId;

  ChitModel? chit;
  List<UserModel> members = [];
  List<String> membersListForDraw = [];
  // List<UserModel> pendingWinners = [];
  Map<String, UserModel> totalMembers = {};
  Map<String, UserModel> userIdByName = {};
  Map<String, Winners>? mapOfWinners;
  Map<String, Payments>? mapOfCurrentPayments;

  getActivePayments() {
    mapOfCurrentPayments = {};

    if (chit!.chitType == 'Monthly') {
      // upcoming day
      if (DateTime(
              DateTime.now().year,
              DateTime.now().month,
              chit!.chitDate!,
              int.parse(chit!.chitTime!.split(':')[0]),
              int.parse(chit!.chitTime!.split(':')[1]))
          .isAfter(DateTime.now())) {
        Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
            DateTime.now().year,
            DateTime.now().month - 1,
            chit!.chitDate!,
            int.parse(chit!.chitTime!.split(':')[0]),
            int.parse(chit!.chitTime!.split(':')[1]))); //To TimeStamp
        FirebaseFirestore.instance
            .collection('chit')
            .doc(widget.id)
            .collection('payments')
            .where('datePaid', isGreaterThan: dateInTimeStamp)
            .snapshots()
            .listen((event) {
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            mapOfCurrentPayments![doc['userId']] =
                Payments.fromJson(doc.data()!);
          }

          if (mounted) {
            setState(() {});
          }
        });
      } else {
        Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            chit!.chitDate!,
            int.parse(chit!.chitTime!.split(':')[0]),
            int.parse(chit!.chitTime!.split(':')[1]))); //To TimeStamp
        FirebaseFirestore.instance
            .collection('chit')
            .doc(widget.id)
            .collection('payments')
            .where('datePaid', isGreaterThan: dateInTimeStamp)
            .snapshots()
            .listen((event) {
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            mapOfCurrentPayments![doc['userId']] =
                Payments.fromJson(doc.data()!);
          }

          if (mounted) {
            setState(() {});
          }
        });
      }
    } else {
//UPCOMING

      if (DateTime.now().weekday < chit!.chitDate!) {
        Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            (DateTime.now().day -
                    (7 - DateTime.now().weekday) +
                    chit!.chitDate!) -
                7)); //To TimeStamp
        FirebaseFirestore.instance
            .collection('chit')
            .doc(widget.id)
            .collection('payments')
            .where('datePaid', isGreaterThan: dateInTimeStamp)
            .snapshots()
            .listen((event) {
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            mapOfCurrentPayments![doc['userId']] =
                Payments.fromJson(doc.data()!);
          }

          if (mounted) {
            setState(() {});
          }
        });
      } else {
        Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            (DateTime.now().day -
                (DateTime.now().weekday - chit!.chitDate!)))); //To TimeStamp
        FirebaseFirestore.instance
            .collection('chit')
            .doc(widget.id)
            .collection('payments')
            .where('datePaid', isGreaterThan: dateInTimeStamp)
            .snapshots()
            .listen((event) {
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            mapOfCurrentPayments![doc['userId']] =
                Payments.fromJson(doc.data()!);
          }

          if (mounted) {
            setState(() {});
          }
        });
      }
    }

    print('[[[[[[[[[[[[[[[[[[[[]]]]]]]]]]]]]]]]]]]]');
    // print(mapOfCurrentPayments!.length ?? 0);
    setState(() {});
  }

  getWinners() {
    print('++++++++++++++++');
    List<Winners> winners = chit!.winners!;
    mapOfWinners = {};

    for (var winner in winners) {
      mapOfWinners![winner.userId!] = winner;

      if (membersListForDraw.contains(winner.userId!)) {
        membersListForDraw.remove(winner.userId!);
      }
    }
    setState(() {
      print(membersListForDraw.length);
      print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
    });
  }

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
          getActivePayments();
        });
      }
    });
  }

  getMembers() async {
    members = [];
    membersListForDraw = [];
    for (int i = 0; i < chit!.members!.length; i++) {
      membersListForDraw.add(chit!.members![i]);
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(chit!.members![i])
          .get();
      totalMembers[chit!.members![i]] = UserModel.fromJson(doc.data()!);
      members.add(UserModel.fromJson(doc.data()!));
    }
    setState(() {
      print('-----------------');
      print(totalMembers.length);
      getWinners();
    });
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
    return chit == null || mapOfWinners == null
        ? Container(
            width: scrHeight,
            height: scrWidth,
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()))
        : Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: scrWidth * 1,
                        height: scrHeight * 0.36,
                        // color: Colors.green,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/icons/background.png"),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Container(
                                    width: scrWidth * 0.15,
                                    height: scrHeight * 0.07,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.white,
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(chit!.profile!))),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.03,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        chit!.private!
                                            ? "Private Chit"
                                            : "Public Chit",
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.04,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Urbanist',
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.71)),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.02,
                                      ),
                                    ],
                                  ),
                                ]),

                                // SizedBox(
                                //   width: scrWidth * 0.34,
                                // ),
                                Row(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: scrHeight * 0.02),
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreen(
                                                  name: chit!.chitName!,
                                                  id: chit!.chitId!,
                                                  profile: chit!.profile!,
                                                  members: totalMembers,
                                                ),
                                              ));
                                        },
                                        child: Icon(
                                          Icons.chat_outlined,
                                          color: Colors.white,
                                        )),
                                  ),
                                  SizedBox(
                                    width: scrWidth * 0.05,
                                  ),
                                  chit!.status! < 2
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              bottom: scrHeight * 0.02),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateNewChitScreen(
                                                      chit: chit!,
                                                    ),
                                                  ));
                                            },
                                            child: SvgPicture.asset(
                                              "assets/icons/editingicon.svg",
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ])
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Subscription",
                                          style: chitcardtwomonth10),
                                      SizedBox(
                                        width: scrWidth * 0.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                  SizedBox(
                                    height: scrHeight * 0.016,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // SizedBox(width: scrWidth*0.1,),
                                      Text(
                                          "Fixed Dividend Amount(only in draw methode)",
                                          style: chitcardtwomonth10),
                                      SizedBox(
                                        width: scrWidth * 0.0003,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              chit!.dividendAmount == null
                                                  ? '0'
                                                  : '$_currency ${_formatNumber(
                                                      chit!.dividendAmount!
                                                          .truncate()
                                                          .toString()
                                                          .replaceAll(',', ''),
                                                    )}',
                                              style: valuefontchit),
                                          Text(
                                              "/${chit!.chitType == 'Monthly' ? 'Month' : 'Week'}",
                                              style: chitcardtwomonth10),
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
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
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
                                                        BorderRadius.circular(
                                                            16)),
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
                                                        fontSize:
                                                            scrWidth * 0.026,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff827C7C)),
                                                  ),
                                                  SizedBox(
                                                    height: scrHeight * 0.003,
                                                  ),
                                                  Text(
                                                    chit!.commission!,
                                                    style: TextStyle(
                                                        fontSize:
                                                            scrWidth * 0.042,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
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
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.05),
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
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                                                        fontSize:
                                                            scrWidth * 0.026,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff827C7C)),
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
                                                        fontSize:
                                                            scrWidth * 0.042,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
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
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.05),
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
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                                                        fontSize:
                                                            scrWidth * 0.026,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff827C7C)),
                                                  ),
                                                  SizedBox(
                                                    height: scrHeight * 0.003,
                                                  ),
                                                  Text(
                                                    "${chit!.duration!} Months",
                                                    style: TextStyle(
                                                        fontSize:
                                                            scrWidth * 0.042,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
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
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.05),
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
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
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
                                                        fontSize:
                                                            scrWidth * 0.026,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xff827C7C)),
                                                  ),
                                                  SizedBox(
                                                    height: scrHeight * 0.003,
                                                  ),
                                                  Text(
                                                    "${chit!.members!.length}/${chit!.membersCount}",
                                                    style: TextStyle(
                                                        fontSize:
                                                            scrWidth * 0.042,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                  border: Border.all(
                                      color: Color(0xffF4F4F4), width: 1),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                ? DateFormat('dd MMM yyyy')
                                                    .format(DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        chit!.chitDate!))
                                                : DateFormat('dd MMM yyyy').format(DateTime(
                                                    DateTime.now().year,
                                                    DateTime.now().month + 1,
                                                    chit!.chitDate!))
                                            :

                                            //Showing Next Date in weekly methode

                                            DateTime.now().weekday <
                                                    chit!.chitDate!

                                                //if Day is upcoming
                                                ? DateFormat('dd MMM yyyy')
                                                    .format(DateTime(
                                                        DateTime.now().year,
                                                        DateTime.now().month,
                                                        (DateTime.now().day +
                                                            (chit!.chitDate! -
                                                                DateTime.now()
                                                                    .weekday))))

                                                //if Day is ended
                                                : DateFormat('dd MMM yyyy')
                                                    .format(DateTime(DateTime.now().year, DateTime.now().month, (DateTime.now().day + (7 - DateTime.now().weekday) + chit!.chitDate!))),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        int.parse(chit!.chitTime!
                                                    .split(':')[0]) >
                                                12
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
                            chit!.winners!.length > 0
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShortListWinners(
                                              chit: chit!,
                                              totalMembers: totalMembers,
                                            ),
                                          ));
                                    },
                                    child: Neumorphic(
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
                                        height: scrHeight * 0.16,
                                        width: scrWidth * 1,
                                        decoration: BoxDecoration(
                                            color: Color(0xffEEEEEE),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: scrWidth * 0.05,
                                              right: scrWidth * 0.05),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: scrHeight * 0.01,
                                              ),
                                              Text(
                                                "Last Time Winner",
                                                style: TextStyle(
                                                  fontSize: scrWidth * 0.027,
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff827C7C),
                                                ),
                                              ),
                                              SizedBox(
                                                height: scrHeight * 0.001,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 16,
                                                        // backgroundColor: Colors.grey,
                                                        backgroundImage: NetworkImage(
                                                            totalMembers[mapOfWinners![chit!
                                                                        .winners![
                                                                            chit!.winners!.length -
                                                                                1]
                                                                        .userId]!
                                                                    .userId]!
                                                                .userImage!),
                                                      ),
                                                      SizedBox(
                                                        width: scrWidth * 0.02,
                                                      ),
                                                      Text(
                                                        totalMembers[mapOfWinners![chit!
                                                                    .winners![chit!
                                                                            .winners!
                                                                            .length -
                                                                        1]
                                                                    .userId]!
                                                                .userId]!
                                                            .userName!,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: scrWidth *
                                                                0.045),
                                                      ),
                                                    ],
                                                  ),

                                                  // SizedBox(
                                                  //   width: scrWidth * 0.33,
                                                  // ),
                                                  SvgPicture.asset(
                                                    "assets/icons/winner.svg",
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: scrHeight * 0.019,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text("Chit Amount",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  scrWidth *
                                                                      0.024,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color: Color(
                                                                  0xff008036))),
                                                      SizedBox(
                                                        height:
                                                            scrHeight * 0.004,
                                                      ),
                                                      Text("$_currency ${_formatNumber(chit!.amount!.truncate().toString().replaceAll(',', ''))}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  scrWidth *
                                                                      0.045,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color: Color(
                                                                  0xff000000))),
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   width: scrWidth * 0.16,
                                                  // ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Paid Amount",
                                                        style: TextStyle(
                                                            fontSize: scrWidth *
                                                                0.024,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Color(
                                                                0xff008036)),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            scrHeight * 0.004,
                                                      ),
                                                      Text("$_currency ${_formatNumber(mapOfWinners![chit!.winners![chit!.winners!.length - 1].userId]!.amount!.truncate().toString().replaceAll(',', ''))}",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  scrWidth *
                                                                      0.045,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color: Color(
                                                                  0xff000000))),
                                                    ],
                                                  ),
                                                  // SizedBox(
                                                  //   width: scrWidth * 0.19,
                                                  // ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        "Dividend",
                                                        style: TextStyle(
                                                            fontSize: scrWidth *
                                                                0.024,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Color(
                                                                0xff008036)),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            scrHeight * 0.004,
                                                      ),
                                                      Text(
                                                        "$_currency ${_formatNumber(((chit!.amount!) - (mapOfWinners![chit!.winners![chit!.winners!.length - 1].userId]!.amount!)).truncate().toString().replaceAll(',', ''))}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                scrWidth * 0.04,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Color(
                                                                0xff000000)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: scrHeight * 0.006,
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                    "after reducing commission ",
                                                    style: TextStyle(
                                                        fontSize:
                                                            scrWidth * 0.024,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            Color(0xff929A95))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),

                            //LIST VIEW
                            SizedBox(
                              height: 390,
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                      Container(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          // reverse: true,
                                          padding: EdgeInsets.only(
                                              left: scrWidth * 0.04,
                                              right: scrWidth * 0.04,
                                              top: scrHeight * 0.003),
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          // scrollDirection: Axis.vertical,
                                          itemCount: members.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                              onTap: () {
                                                if (chit!.status == 2) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ApprovePage(
                                                                id: members[
                                                                        index]
                                                                    .userId!,
                                                                chit: chit!,
                                                              )));
                                                }
                                              },
                                              child: Container(
                                                width: scrWidth * 0.02,
                                                height: scrHeight * 0.075,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Color(0xffF3F3F3)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        mapOfWinners!.keys
                                                                .contains(members[
                                                                        index]
                                                                    .userId!)
                                                            ? Stack(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: scrHeight *
                                                                            0.012),
                                                                    child:
                                                                        Container(
                                                                      width: scrWidth *
                                                                          0.12,
                                                                      height:
                                                                          scrHeight *
                                                                              0.05,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16),
                                                                        color: Colors
                                                                            .black,
                                                                        image: DecorationImage(
                                                                            image:
                                                                                NetworkImage(members[index].userImage!),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    bottom: -1,
                                                                    left: 35,
                                                                    top: 22,
                                                                    child: SvgPicture
                                                                        .asset(
                                                                      "assets/icons/profilewinner.svg",
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: scrHeight *
                                                                        0.012),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      scrWidth *
                                                                          0.12,
                                                                  height:
                                                                      scrHeight *
                                                                          0.05,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            16),
                                                                    color: Colors
                                                                        .black,
                                                                    image: DecorationImage(
                                                                        image: NetworkImage(members[index]
                                                                            .userImage!),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                  ),
                                                                ),
                                                              ),
                                                        SizedBox(
                                                            width: scrHeight *
                                                                0.012),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: scrHeight *
                                                                          0.013),
                                                              child: Text(
                                                                members[index]
                                                                    .userName!,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        scrWidth *
                                                                            0.045),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  scrHeight *
                                                                      0.004,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "$_currency ${_formatNumber(chit!.payableAmount!.truncate().toString().replaceAll('.', ''))}",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          scrWidth *
                                                                              0.036,
                                                                      color: Color(
                                                                          0xff969696)),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      scrWidth *
                                                                          0.015,
                                                                ),
                                                                Container(
                                                                  width:
                                                                      scrWidth *
                                                                          0.15,
                                                                  height:
                                                                      scrHeight *
                                                                          0.017,
                                                                  decoration: BoxDecoration(
                                                                      color: mapOfCurrentPayments![members[index].userId] != null
                                                                          ? mapOfCurrentPayments![members[index].userId]!.verified!
                                                                              ? Color(0xff02B558)
                                                                              : Color(0xff8391A1)
                                                                          : Color(0xffF61C0D),
                                                                      borderRadius: BorderRadius.circular(3)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      mapOfCurrentPayments![members[index].userId] ==
                                                                              null
                                                                          ? 'Due'
                                                                          : mapOfCurrentPayments![members[index].userId]!.verified!
                                                                              ? 'Paid'
                                                                              : "Pending",
                                                                      style: TextStyle(
                                                                          fontSize: scrWidth *
                                                                              0.033,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // SizedBox(
                                                                //   width:
                                                                //       scrWidth *
                                                                //           0.11,
                                                                // ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        mapOfWinners!.keys
                                                                .contains(members[
                                                                        index]
                                                                    .userId!)
                                                            ? Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        scrHeight *
                                                                            0.02,
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: scrWidth *
                                                                            0.05),
                                                                    child: Text(
                                                                      '$_currency ${_formatNumber(mapOfWinners![members[index].userId!]!.amount!.truncate().toString().replaceAll(',', ''))}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize: scrWidth *
                                                                              0.034,
                                                                          color:
                                                                              primarycolor),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    DateFormat(
                                                                            'MMMM yyyy')
                                                                        .format(
                                                                            mapOfWinners![members[index].userId!]!.date!),
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            'Urbanist',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        fontSize:
                                                                            scrWidth *
                                                                                0.022,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container(
                                                                width: scrWidth *
                                                                    0.000001,
                                                                height:
                                                                    scrHeight *
                                                                        0.02,
                                                              ),
                                                        // Padding(
                                                        //   padding: (index == 0)
                                                        //       ? EdgeInsets.only(
                                                        //           left:
                                                        //               scrWidth *
                                                        //                   0.035)
                                                        //       : EdgeInsets.only(
                                                        //           left:
                                                        //               scrWidth *
                                                        //                   0.21),
                                                        //   child:
                                                        //       SvgPicture.asset(
                                                        //     "assets/icons/menuicon.svg",
                                                        //   ),
                                                        // ),
                                                        SizedBox(
                                                            width: scrHeight *
                                                                0.012),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
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
                                    builder: (context) => OptOutPage(
                                          chit: chit!,
                                          membersListForDraw:
                                              membersListForDraw,
                                          totalMembers: totalMembers,
                                        )));
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
                              moveToVacant(1);
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

  void moveToVacant(int status) {
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
    print(membersListForDraw.length);
    winnerName = null;
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
                Container(
                  // color: Colors.pink,
                  width: scrWidth,
                  // width: 160,
                  height: textFormFieldHeight45,
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.033),
                  ),
                  padding: EdgeInsets.only(
                      left: scrWidth * 0.051, right: scrWidth * 0.04),
                  child: DropdownButton(
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      size: scrWidth * 0.07,
                    ),
                    iconDisabledColor: Color(0xff908F8F),
                    underline: Container(),
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(scrWidth * 0.033),
                    style: TextStyle(
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    hint: Container(
                      // width: 110,
                      width: scrWidth * 0.6,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person,
                            size: scrWidth * 0.07,
                          ),
                          Text(
                            "Choose Winner",
                            style: TextStyle(
                              fontSize: FontSize15,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    value: winnerName,
                    onChanged: (value) {
                      winnerName = value.toString();
                      print(value);
                      // winnerId = value;
                      print('WINNER ID IS+++++++');
                      print(winnerName);
                      print(winnerId);

                      setState(() {});
                    },
                    items: membersListForDraw
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child:
                                Text(totalMembers[value.toString()]!.userName!),
                          ),
                        )
                        .toList(),
                  ),
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
                    controller: amount,
                    keyboardType: TextInputType.number,
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
                      labelText: 'Chit Amount',
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
                    controller: payableAmount,
                    keyboardType: TextInputType.number,
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
                    controller: dividend,
                    keyboardType: TextInputType.number,
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
                      labelText: 'Dividend Amount',
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
                InkWell(
                  onTap: () {
                    double pay = chit!.subscriptionAmount! -
                        (double.tryParse(dividend.text)! / chit!.membersCount!);
                    print('hehe');
                    print(pay);
                    if (winnerName != null &&
                        amount.text != '' &&
                        payableAmount.text != '' &&
                        dividend.text != '') {
                      final winnerMember = Winners(
                          amount: double.tryParse(payableAmount.text),
                          userId: winnerName,
                          date: DateTime.now());
                      var map = winnerMember.toJson();
                      print(map);
                      FirebaseFirestore.instance
                          .collection('chit')
                          .doc(chit!.chitId)
                          .update({
                        'winners': FieldValue.arrayUnion([map]),
                        'payableAmount': chit!.subscriptionAmount! -
                            (double.tryParse(dividend.text)! /
                                chit!.membersCount!)
                      }).then((value) {
                        winnerName = null;
                        amount.text = '';
                        payableAmount.text = '';
                        dividend.text = '';
                        Navigator.pop(context);
                      });
                    } else {
                      winnerName == null
                          ? showSnackbar(context, 'Please choose winner')
                          : amount.text == ''
                              ? showSnackbar(context, 'Please enter Amount')
                              : payableAmount.text == ''
                                  ? showSnackbar(
                                      context, 'Please enter Payable Amount')
                                  : showSnackbar(
                                      context, 'Please enter Dividend');
                    }
                  },
                  child: Container(
                    width: scrWidth,
                    height: textFormFieldHeight45,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
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
