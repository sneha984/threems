import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../Authentication/root.dart';
import '../../kuri/createkuri.dart';
import '../../model/ChitModel.dart';
import '../../model/usermodel.dart';
import '../../utils/customclip2.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'Chit__Chat_Screen.dart';
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
  List<String> membersListForDraw = [];

  Map<String, UserModel> totalMembers = {};
  Map<String, UserModel> userIdByName = {};
  Map<String, Winners>? mapOfWinners;
  Map<String, Payments>? mapOfCurrentPayments;
  double total = 0;
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
          total = 0;
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            total += doc['amount'];
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
          total = 0;
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            total += doc['amount'];
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
          total = 0;
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            total += doc['amount'];
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
          total = 0;
          for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
            total += doc['amount'];
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
      print(totalMembers.length);
      print(']]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]');
      print(mapOfWinners!.keys);
      print(mapOfWinners![chit!.winners![chit!.winners!.length - 1].userId]!
          .userId!);
      print(totalMembers[mapOfWinners!.keys.first]);
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

    getWinners();
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
    return chit == null && mapOfWinners == null
        ? Container(
            width: scrWidth,
            height: scrHeight,
            color: Colors.white,
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            image: NetworkImage(
                                                chit!.profile ?? ''),
                                            fit: BoxFit.fill),
                                      ),
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
                                          "${chit!.private! ? "Private" : "Public"} Chit",
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
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: scrHeight * 0.02),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                name: chit!.chitName!,
                                                id: chit!.chitId!,
                                                chit: chit!,
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

                                            //if Day is upcoming
                                            DateTime.now().weekday <
                                                    chit!.chitDate!
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
                                                    .format(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + (7 - DateTime.now().weekday) + chit!.chitDate!)),
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
                            chit!.winners!.isNotEmpty && mapOfWinners != null
                                ? Neumorphic(
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
                                                          fontSize:
                                                              scrWidth * 0.045),
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
                                                            fontSize: scrWidth *
                                                                0.024,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Color(
                                                                0xff008036))),
                                                    SizedBox(
                                                      height: scrHeight * 0.004,
                                                    ),
                                                    Text(
                                                        "$_currency ${_formatNumber(chit!.amount!.truncate().toString().replaceAll(',', ''))}",
                                                        style: TextStyle(
                                                            fontSize: scrWidth *
                                                                0.045,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                          fontSize:
                                                              scrWidth * 0.024,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: Color(
                                                              0xff008036)),
                                                    ),
                                                    SizedBox(
                                                      height: scrHeight * 0.004,
                                                    ),
                                                    Text(
                                                        "$_currency ${_formatNumber(mapOfWinners![chit!.winners![chit!.winners!.length - 1].userId]!.amount!.truncate().toString().replaceAll(',', ''))}",
                                                        style: TextStyle(
                                                            fontSize: scrWidth *
                                                                0.045,
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                          fontSize:
                                                              scrWidth * 0.024,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: Color(
                                                              0xff008036)),
                                                    ),
                                                    SizedBox(
                                                      height: scrHeight * 0.004,
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
                                  )
                                : Container(),
                            SizedBox(
                              height: scrHeight * 0.015,
                            ),
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return members.isEmpty
                                                ? Center(
                                                    child: Text(
                                                      'There is no members',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xff02B558),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: scrWidth * 0.02,
                                                    height: scrHeight * 0.075,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color:
                                                            Color(0xffF3F3F3)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            mapOfWinners == null
                                                                ? SizedBox()
                                                                : mapOfWinners!
                                                                        .keys
                                                                        .contains(
                                                                            members[index].userId!)
                                                                    ? Stack(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: scrHeight * 0.012),
                                                                            child:
                                                                                Container(
                                                                              width: scrWidth * 0.12,
                                                                              height: scrHeight * 0.05,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(16),
                                                                                color: Colors.black,
                                                                                image: DecorationImage(image: NetworkImage(members[index].userImage!), fit: BoxFit.cover),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Positioned(
                                                                            bottom:
                                                                                -1,
                                                                            left:
                                                                                35,
                                                                            top:
                                                                                22,
                                                                            child:
                                                                                SvgPicture.asset(
                                                                              "assets/icons/profilewinner.svg",
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    : Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: scrHeight * 0.012),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              scrWidth * 0.12,
                                                                          height:
                                                                              scrHeight * 0.05,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16),
                                                                            color:
                                                                                Colors.black,
                                                                            image:
                                                                                DecorationImage(image: NetworkImage(members[index].userImage!), fit: BoxFit.cover),
                                                                          ),
                                                                        ),
                                                                      ),
                                                            SizedBox(
                                                                width:
                                                                    scrHeight *
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
                                                                  padding: EdgeInsets.only(
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
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          fontSize: scrWidth *
                                                                              0.036,
                                                                          color:
                                                                              Color(0xff969696)),
                                                                    ),
                                                                    SizedBox(
                                                                      width: scrWidth *
                                                                          0.015,
                                                                    ),
                                                                    Container(
                                                                      width: scrWidth *
                                                                          0.15,
                                                                      height: scrHeight *
                                                                          0.017,
                                                                      decoration: BoxDecoration(
                                                                          color: mapOfCurrentPayments![members[index].userId] != null
                                                                              ? mapOfCurrentPayments![members[index].userId]!.verified!
                                                                                  ? Color(0xff02B558)
                                                                                  : Color(0xff8391A1)
                                                                              : Color(0xffF61C0D),
                                                                          borderRadius: BorderRadius.circular(3)),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          mapOfCurrentPayments![members[index].userId] == null
                                                                              ? 'Due'
                                                                              : mapOfCurrentPayments![members[index].userId]!.verified!
                                                                                  ? 'Paid'
                                                                                  : "Pending",
                                                                          style: TextStyle(
                                                                              fontSize: scrWidth * 0.033,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontFamily: 'Urbanist',
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            mapOfWinners == null
                                                                ? SizedBox()
                                                                : mapOfWinners!
                                                                        .keys
                                                                        .contains(
                                                                            members[index].userId!)
                                                                    ? Container(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              height: scrHeight * 0.02,
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsets.only(left: scrWidth * 0.05),
                                                                              child: Text(
                                                                                '$_currency ${_formatNumber(mapOfWinners![members[index].userId!]!.amount!.truncate().toString().replaceAll(',', ''))}',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(fontFamily: 'Urbanist', fontWeight: FontWeight.w600, fontSize: scrWidth * 0.034, color: primarycolor),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              DateFormat('MMMM yyyy').format(mapOfWinners![members[index].userId!]!.date!),
                                                                              style: TextStyle(fontFamily: 'Urbanist', fontWeight: FontWeight.w600, fontSize: scrWidth * 0.022, color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        width: scrWidth *
                                                                            0.000001,
                                                                        height: scrHeight *
                                                                            0.02,
                                                                      ),
                                                            // Padding(
                                                            //   padding: (index ==
                                                            //           0)
                                                            //       ? EdgeInsets.only(
                                                            //           left: scrWidth *
                                                            //               0.035)
                                                            //       : EdgeInsets.only(
                                                            //           left: scrWidth *
                                                            //               0.21),
                                                            //   child: SvgPicture
                                                            //       .asset(
                                                            //     "assets/icons/menuicon.svg",
                                                            //   ),
                                                            // ),
                                                            SizedBox(
                                                                width:
                                                                    scrHeight *
                                                                        0.012),
                                                          ],
                                                        ),
                                                      ],
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
                        InkWell(
                          onTap: () {
                            if (mapOfWinners!.keys.contains(currentuserid!)) {
                              showSnackbar(context, 'Already paid this month');
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChitPaymentPage(
                                      chit: chit!,
                                    ),
                                  ));
                            }

                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>VacantChitJoinPage()));
                          },
                          child: Container(
                            height: scrHeight * 0.045,
                            width: scrWidth * 0.25,
                            decoration: BoxDecoration(
                              color: mapOfWinners!.keys.contains(currentuserid!)
                                  ? Colors.grey
                                  : Colors.white,
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
