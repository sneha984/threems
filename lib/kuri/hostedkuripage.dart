import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../model/Kuri/kuriModel.dart';
import '../model/usermodel.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/customclip2.dart';
import '../utils/themes.dart';
import 'add_member_search_kuri.dart';
import 'add_members_kuri.dart';

class HostedKuriPage extends StatefulWidget {
  final String id;
  const HostedKuriPage({Key? key, required this.id}) : super(key: key);

  @override
  State<HostedKuriPage> createState() => _HostedKuriPageState();
}

class _HostedKuriPageState extends State<HostedKuriPage> {
  Map<String, Payments> latestPayments = {};

  KuriModel? kuri;
  UserModel? currentKuriUser;

  UserModel? kuriOwner;
  getOwner() {
    print(kuri!.userID);
    FirebaseFirestore.instance
        .collection('users')
        .doc(kuri!.userID)
        .snapshots()
        .listen((event) {
      kuriOwner = UserModel.fromJson(event.data()!);

      if (mounted) {
        setState(() {});
      }
    });
  }

  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  Duration? remainingTime;
  int count = 1;
  DateTime? deadLine;
  DateFormat? formatter;
  String? formatted;
  double? percentage = 0;
  List<UserModel> members = [];

  getTime() async {
    DateTime deadLine = kuri!.deadLine!;
    for (int i = count; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      remainingTime = deadLine.difference(DateTime.now());
      // DateTime.now().difference(launch);

    }

    if (mounted) {
      setState(() {});
    }
    getTime();
  }

  listenKuri() {
    FirebaseFirestore.instance
        .collection('kuri')
        .doc(widget.id)
        .snapshots()
        .listen((event) {
      kuri = KuriModel.fromJson(event.data()!);

      deadLine = kuri!.deadLine!;
      formatter = DateFormat('dd MMM');
      formatted = formatter!.format(deadLine!);
      percentage = kuri!.totalReceived! / kuri!.amount!;
      if (mounted) {
        setState(() {
          getOwner();
          getMembers();

          getTime();
        });
      }
    });
  }

  getMembers() async {
    members = [];
    for (int i = 0; i < kuri!.members!.length; i++) {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(kuri!.members![i])
          .get();
      members.add(UserModel.fromJson(doc.data()!));
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenKuri();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: kuri == null || kuriOwner == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: scrWidth * 1,
                        height: scrHeight * 0.36,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/icons/background.png"),
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
                            // SvgPicture.asset(
                            //   "assets/icons/editingicon.svg",
                            // ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: scrHeight * 0.02,
                                    ),
                                    Text(
                                      kuri!.kuriName!,
                                      style: TextStyle(
                                          fontSize: scrWidth * 0.045,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Urbanist',
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "The room created by ${kuriOwner!.userName}",
                                      style: TextStyle(
                                          fontSize: scrWidth * 0.04,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Urbanist',
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.71)),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: scrWidth * 0.03),
                                        child: Container(
                                          child: Center(
                                              child: Text(
                                                  remainingTime == null
                                                      ? "..."
                                                      : "${remainingTime?.inDays} Days Left"
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontSize:
                                                          scrWidth * 0.025,
                                                      fontFamily: 'Urbanist'))),
                                          height: scrHeight * 0.023,
                                          width: scrWidth * 0.22,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                          padding: EdgeInsets.only(
                                              left: scrWidth * 0.04),
                                          child: Center(
                                            child: Text(
                                              kuri!.private!
                                                  ? 'Private'
                                                  : 'Public',
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
                                    percent: percentage!,
                                    alignment: MainAxisAlignment.start,
                                    barRadius: Radius.circular(scrWidth * 0.2),
                                    progressColor: primarycolor,
                                    backgroundColor: Color(0xffD9D9D9),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.015,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            '$_currency ${_formatNumber(
                                              kuri!.totalReceived!
                                                  .truncate()
                                                  .toString()
                                                  .replaceAll(',', ''),
                                            )}',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                            '$_currency ${_formatNumber(
                                              kuri!.amount!
                                                  .truncate()
                                                  .toString()
                                                  .replaceAll(',', ''),
                                            )}',
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
                                                    "Deadline",
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
                                                    formatted!,
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
                                                      scrWidth * 0.026),
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
                                                    kuri!.members!.length
                                                        .toString(),
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
                              height: scrHeight * 0.023,
                            ),
                            SizedBox(
                              child: Container(
                                height: scrHeight * 0.47,
                                width: scrWidth * 1,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 25.0,
                                        offset: Offset(0, 4)),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(17.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: scrHeight * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: scrWidth * 0.65),
                                      child: Text(
                                        "Members",
                                        style: TextStyle(
                                          fontSize: scrWidth * 0.027,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xff827C7C),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: scrWidth * 0.09,
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
                                          for (int i = 0;
                                              i < kuri!.payments!.length;
                                              i++) {
                                            if (kuri!.payments![i].userId ==
                                                members[index].userId) {
                                              latestPayments[kuri!
                                                      .payments![i].userId] !=
                                                  kuri!.payments![i];
                                            }
                                          }

                                          var data = members[index];
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
                                                    top: scrHeight * 0.004),
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
                                                            data.userImage!),
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                              ),
                                              title: Padding(
                                                padding: EdgeInsets.only(
                                                    top: scrHeight * 0.01),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      data.userName!,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              scrWidth * 0.045),
                                                    ),
                                                    SizedBox(
                                                      height: scrHeight * 0.004,
                                                    ),
                                                    Container(
                                                      width: scrWidth * 0.15,
                                                      height: scrHeight * 0.017,
                                                      decoration: BoxDecoration(
                                                          color: latestPayments[
                                                                      members[index]
                                                                          .userId] !=
                                                                  null
                                                              ? latestPayments[members[
                                                                              index]
                                                                          .userId]!
                                                                      .verified!
                                                                  ? Color(
                                                                      0xff02B558)
                                                                  : Color(
                                                                      0xff8391A1)
                                                              : Color(
                                                                  0xffF61C0D),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                      child: Center(
                                                        child: Text(
                                                          latestPayments![members[
                                                                          index]
                                                                      .userId] ==
                                                                  null
                                                              ? 'Due'
                                                              : latestPayments![
                                                                          members[index]
                                                                              .userId]!
                                                                      .verified!
                                                                  ? 'Paid'
                                                                  : "Pending",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  scrWidth *
                                                                      0.033,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              trailing:
                                                  PopupMenuButton<MenuItem>(
                                                constraints: BoxConstraints(
                                                    maxWidth: 150,
                                                    minWidth: 150,
                                                    maxHeight: 50,
                                                    minHeight: 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                position:
                                                    PopupMenuPosition.under,
                                                child: SizedBox(
                                                  width: 10,
                                                  height: 10,
                                                  child: SvgPicture.asset(
                                                    "assets/icons/menuicon.svg",
                                                  ),
                                                ),
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    height: 30,
                                                    child: InkWell(
                                                      onTap: () async {
                                                        DocumentSnapshot doc =
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'kuri')
                                                                .doc(kuri!
                                                                    .kuriId)
                                                                .get();

                                                        List allMembers =
                                                            doc['members'];
                                                        allMembers.remove(
                                                            data.userId);
                                                        print(allMembers);

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('kuri')
                                                            .doc(kuri!.kuriId)
                                                            .update({
                                                          'members': allMembers
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Container(
                                                            // padding: EdgeInsets.symmetric(horizontal: 1),
                                                            height: 15,
                                                            width: 15,
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/icons/trash.svg',
                                                              color:
                                                                  Colors.black,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "Remove",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  FontSize13,
                                                              fontFamily:
                                                                  "Urbanist",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
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
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           AddMembersearch(kuri: kuri!),
                                        //     ));
                                      },
                                      child: Container(
                                        height: scrHeight * 0.056,
                                        width: scrWidth * 0.83,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          color: primarycolor,
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Add Members",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xffFFFFFF),
                                              fontSize: 14,
                                              fontFamily: 'Urbanist'),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: scrHeight * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ));
  }
// void pay() {
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         payableAmountNode.addListener(() {
//           setState(() {});
//         });
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           title: Text('Pay the chit amount of September'),
//           titleTextStyle: TextStyle(
//               fontSize: FontSize10,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w600,
//               color: Color(0xff827C7C)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   keyboardType: TextInputType.number,
//                   inputFormatters: <TextInputFormatter>[
//                     CurrencyTextInputFormatter(
//                         locale: 'HI', decimalDigits: 0, symbol: '₹ '),
//                   ],
//                   focusNode: payableAmountNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Payable Amount',
//                     labelStyle: TextStyle(
//                       color: payableAmountNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               DottedBorder(
//                 padding: EdgeInsets.all(0),
//                 borderType: BorderType.RRect,
//                 radius: Radius.circular(8),
//                 color: Color(0xffDADADA),
//                 strokeWidth: 2,
//                 child: Container(
//                   height: 56,
//                   width: 256,
//                   decoration: BoxDecoration(
//                     color: Color(0xffF7F8F9),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         "assets/icons/docCam.svg",
//                         height: scrWidth * 0.04,
//                         width: scrWidth * 0.05,
//                         color: Color(0xff8391A1),
//                         // height: 21,
//                         // width: 25,
//                       ),
//                       SizedBox(
//                         width: scrWidth * 0.02,
//                       ),
//                       Text(
//                         "Upload Screenshot",
//                         style: TextStyle(
//                           color: Color(0xffB0B0B0),
//                           fontSize: FontSize13,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 decoration: BoxDecoration(
//                     color: primarycolor,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Confirm Pay",
//                       style: TextStyle(
//                           fontSize: FontSize16,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

// void joinChit() {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         titlePadding:
//             EdgeInsets.only(top: 29, bottom: 0, left: 20, right: 20),
//         contentPadding:
//             EdgeInsets.only(top: 5, bottom: 23, left: 20, right: 20),
//         title: Text(
//           "Are you sure want to join this Chit?",
//           style: TextStyle(
//             color: Color(0xff2C2C2C),
//             fontSize: FontSize15,
//             fontFamily: "Urbanist",
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         content: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'You can join after the approvel of Admin',
//                 style: TextStyle(
//                   color: Color(0xff827C7C),
//                   fontSize: FontSize10,
//                   fontFamily: "Urbanist",
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 height: 17,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: Color(0xffDEDEDE),
//                       boxShadow: [
//                         //
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: primarycolor,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Confirm",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(34),
//         ),
//       );
//     },
//   );
// }

// void moveToVaccant() {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         contentPadding:
//             EdgeInsets.only(top: 29, bottom: 23, left: 21, right: 21),
//         content: Container(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Is this Chit is moving to Vacant Chit?',
//                 style: TextStyle(
//                   color: Color(0xff2C2C2C),
//                   fontSize: FontSize16,
//                   fontFamily: "Urbanist",
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(
//                 height: 17,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: Color(0xffDEDEDE),
//                       boxShadow: [
//                         //
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Cancel",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 109,
//                     height: 44,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(34),
//                       color: primarycolor,
//                       boxShadow: [
//                         BoxShadow(
//                           blurRadius: 5,
//                           spreadRadius: -4,
//                           // offset: Offset(0, -4),
//                           color: Colors.black.withOpacity(0.15),
//                         ),
//                       ],
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Confirm",
//                         style: TextStyle(
//                           color: Color(0xff2C2C2C),
//                           fontSize: FontSize16,
//                           fontFamily: "Urbanist",
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(34),
//         ),
//       );
//     },
//   );
// }
// FocusNode dialogueAuctionAmountNode = FocusNode();
// FocusNode dialoguePayableAmountNode = FocusNode();
// FocusNode dialogueDividentNode = FocusNode();

// @override
// void dispose() {
//   dialogueAuctionAmountNode.dispose();
//   dialoguePayableAmountNode.dispose();
//   dialogueDividentNode.dispose();
//   super.dispose();
// }

// void payChitAmount() {
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (BuildContext context, setState) {
//         dialogueAuctionAmountNode.addListener(() {
//           setState(() {});
//         });
//         dialoguePayableAmountNode.addListener(() {
//           setState(() {});
//         });
//         dialogueDividentNode.addListener(() {
//           setState(() {});
//         });
//         return AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           title: Text('Pay the chit amount of September'),
//           titleTextStyle: TextStyle(
//               fontSize: FontSize10,
//               fontFamily: 'Urbanist',
//               fontWeight: FontWeight.w600,
//               color: Color(0xff827C7C)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.black,
//                     radius: 16,
//                   ),
//                   Container(
//                       margin: EdgeInsets.all(14),
//                       child: Text(
//                         "akhilgeorge",
//                         style: TextStyle(
//                             fontSize: FontSize16,
//                             fontFamily: 'Urbanist',
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black),
//                       ))
//                 ],
//               ),
//               SizedBox(
//                 height: scrWidth * 0.05,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   focusNode: dialogueAuctionAmountNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Auction Amount',
//                     labelStyle: TextStyle(
//                       color: dialogueAuctionAmountNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     // prefixIcon: Container(
//                     //   height: scrWidth * 0.045,
//                     //   width: 10,
//                     //   padding: EdgeInsets.all(
//                     //       scrWidth * 0.033),
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/subscription.svg',
//                     //     fit: BoxFit.contain,
//                     //     color: textFormUnFocusColor,
//                     //   ),
//                     // ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   focusNode: dialoguePayableAmountNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Payable Amount',
//                     labelStyle: TextStyle(
//                       color: dialoguePayableAmountNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     // prefixIcon: Container(
//                     //   height: scrWidth * 0.045,
//                     //   width: 10,
//                     //   padding: EdgeInsets.all(
//                     //       scrWidth * 0.033),
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/subscription.svg',
//                     //     fit: BoxFit.contain,
//                     //     color: textFormUnFocusColor,
//                     //   ),
//                     // ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.03,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: scrWidth * 0.015,
//                   vertical: 2,
//                 ),
//                 decoration: BoxDecoration(
//                   color: textFormFieldFillColor,
//                   borderRadius: BorderRadius.circular(scrWidth * 0.026),
//                 ),
//                 child: TextFormField(
//                   focusNode: dialogueDividentNode,
//                   cursorHeight: scrWidth * 0.055,
//                   cursorWidth: 1,
//                   cursorColor: Colors.black,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: FontSize15,
//                     fontFamily: 'Urbanist',
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Divident Amount',
//                     labelStyle: TextStyle(
//                       color: dialogueDividentNode.hasFocus
//                           ? primarycolor
//                           : textFormUnFocusColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: FontSize15,
//                       fontFamily: 'Urbanist',
//                     ),
//                     // prefixIcon: Container(
//                     //   height: scrWidth * 0.045,
//                     //   width: 10,
//                     //   padding: EdgeInsets.all(
//                     //       scrWidth * 0.033),
//                     //   child: SvgPicture.asset(
//                     //     'assets/icons/subscription.svg',
//                     //     fit: BoxFit.contain,
//                     //     color: textFormUnFocusColor,
//                     //   ),
//                     // ),
//                     fillColor: textFormFieldFillColor,
//                     filled: true,
//                     contentPadding: EdgeInsets.only(
//                         top: 5,
//                         bottom: scrWidth * 0.033,
//                         left: scrWidth * 0.033),
//                     disabledBorder: InputBorder.none,
//                     enabledBorder: InputBorder.none,
//                     errorBorder: InputBorder.none,
//                     border: InputBorder.none,
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(
//                         color: primarycolor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: scrWidth * 0.06,
//               ),
//               Container(
//                 width: scrWidth,
//                 height: textFormFieldHeight45,
//                 decoration: BoxDecoration(
//                     color: primarycolor,
//                     borderRadius: BorderRadius.circular(8)),
//                 child: Center(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Text(
//                       "Save",
//                       style: TextStyle(
//                           fontSize: FontSize16,
//                           fontFamily: 'Urbanist',
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }
}
