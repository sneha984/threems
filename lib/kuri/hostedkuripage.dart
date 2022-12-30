import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/kuri/createkuri.dart';

import '../Authentication/root.dart';
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

  bool verifying = false;

  getPayments() {
    FirebaseFirestore.instance
        .collection('kuri')
        .doc(widget.id)
        .collection('payments')
        .orderBy('datePaid', descending: false)
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        if (latestPayments[doc['userId']] == null) {
          latestPayments[doc['userId']] = Payments.fromJson(doc.data());
        } else if (latestPayments[doc['userId']]!.verified == true) {
          latestPayments[doc['userId']] = Payments.fromJson(doc.data());
        }
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  Icon? _icon;
  var icons;
  var categoryName;
  getIconData() {
    FirebaseFirestore.instance
        .collection('income')
        .where('categoryName', isEqualTo: 'Kuri')
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot data in event.docs) {
        icons = deserializeIcon(data['icon']);
        categoryName = data['categoryName'];
        // _icon = Icon(icons,color: Colors.white,size: 45,);

      }
      if (mounted) {
        setState(() {});
      }
    });
  }

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
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenKuri();
    getIconData();
    getPayments();
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
                                          var data = members[index];
                                          return InkWell(
                                            onTap: () {
                                              latestPayments[data.userId] !=
                                                      null
                                                  ? verifyPayment(
                                                      latestPayments[
                                                          data.userId]!,
                                                      data)
                                                  : showSnackbar(context,
                                                      '${data.userName!} is not paid yet!!.');
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
                                                          image: CachedNetworkImageProvider(
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
                                                            fontSize: scrWidth *
                                                                0.045),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            scrHeight * 0.004,
                                                      ),
                                                      Container(
                                                        width: scrWidth * 0.15,
                                                        height:
                                                            scrHeight * 0.017,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: latestPayments[members[index]
                                                                            .userId] !=
                                                                        null
                                                                    ? latestPayments[members[index].userId]!
                                                                            .verified!
                                                                        ? Color(
                                                                            0xff02B558)
                                                                        : Color(
                                                                            0xff8391A1)
                                                                    : Color(
                                                                        0xffF61C0D),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3)),
                                                        child: Center(
                                                          child: Text(
                                                            latestPayments![members[
                                                                            index]
                                                                        .userId] ==
                                                                    null
                                                                ? 'Due'
                                                                : latestPayments![
                                                                            members[index].userId]!
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
                                                                color: Colors
                                                                    .white),
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
                                                              .collection(
                                                                  'kuri')
                                                              .doc(kuri!.kuriId)
                                                              .update({
                                                            'members':
                                                                allMembers
                                                          });
                                                          Navigator.pop(
                                                              context);
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
                                                                color: Colors
                                                                    .black,
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
                                                                color: Colors
                                                                    .black,
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddMembersearch(kuri: kuri!),
                                            ));
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

  void verifyPayment(Payments payment, UserModel user) {
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
            title: Text('Verify the Payment'),
            titleTextStyle: TextStyle(
                fontSize: FontSize10,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Color(0xff827C7C)),
            content: Container(
              width: scrWidth * 0.99,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        backgroundImage: NetworkImage(user.userImage!),
                        radius: 16,
                      ),
                      Container(
                          margin: EdgeInsets.all(14),
                          child: Text(
                            user.userName!,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '$_currency ${_formatNumber(payment.amount!.truncate().toString().replaceAll(',', ''))}',
                        style: TextStyle(
                            fontSize: scrWidth * 0.045,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Urbanist',
                            color: Color(0xff008036)),
                      ),
                      // SizedBox(width: scrWidth*0.02,),

                      Container(
                        height: scrHeight * 0.029,
                        width: scrWidth * 0.15,
                        decoration: BoxDecoration(
                            color: payment.verified!
                                ? Color(0xff02B558)
                                : Color(0xff8391A1),
                            borderRadius: BorderRadius.circular(3)),
                        child: Center(
                          child: Text(
                            payment.verified! ? 'Paid' : "Pending",
                            style: TextStyle(
                                fontSize: scrWidth * 0.036,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Urbanist',
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: scrWidth * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          print(payment.datePaid ?? '');
                          GallerySaver.saveImage(payment.url!,
                                  toDcim: true,
                                  albumName:
                                      '${kuri!.kuriName!}-${user.userName!}-${DateFormat('dd-MM-yyyy').format(payment.datePaid ?? DateTime.now())}')
                              .then((success) {
                            Navigator.pop(context);
                            showSnackbar(context,
                                'Download completed. Check your gallery');
                          });

                          // final taskId = await FlutterDownloader.enqueue(
                          //   url: payment.url!,
                          //
                          //   savedDir: '/storage/emulated/0/Download/3MS/',
                          //   showNotification:
                          //       true, // show download progress in status bar (for Android)
                          //   openFileFromNotification:
                          //       true, // click on notification to open downloaded file (for Android)
                          // );

                          // try {
                          //   // Saved with this method.
                          //   var imageId = await ImageDownloader.downloadImage(
                          //       "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png");
                          //   if (imageId == null) {
                          //     return;
                          //   }
                          //
                          //   // Below is a method of obtaining saved image information.
                          //   var fileName =
                          //       await ImageDownloader.findName(imageId);
                          //   var path = await ImageDownloader.findPath(imageId);
                          //   var size =
                          //       await ImageDownloader.findByteSize(imageId);
                          //   var mimeType =
                          //       await ImageDownloader.findMimeType(imageId);
                          // } catch (error) {
                          //   print(error);
                          // }

                          // if (activePayment == null) {
                          //   showSnackbar(
                          //       context, 'There is nothing to view.');
                          // } else {
                          //   // Uint8List response = await http
                          //   //     .get(Uri.parse(activePayment!.url!))
                          //   //     .then((value) => value.bodyBytes);
                          //
                          //   // await launchUrl(Uri.parse(activePayment!.url!))
                          //   //     .then((value) {
                          //   //   showSnackbar(
                          //   //       context, 'Successfully downloaded');
                          //   // });
                          // }
                        },
                        child: Container(
                          height: scrHeight * 0.029,
                          width: scrWidth * 0.26,
                          decoration: BoxDecoration(
                              color: Color(0xff02B558),
                              borderRadius: BorderRadius.circular(3)),
                          child: Center(
                            child: Text(
                              "View Screenshot",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.033,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: scrWidth * 0.06,
                  ),
                  InkWell(
                    onTap: () {
                      if (payment.verified == false) {
                        Navigator.pop(context);
                        FirebaseFirestore.instance
                            .collection('kuri')
                            .doc(widget.id)
                            .collection('payments')
                            .doc(payment.paymentId)
                            .update({'verified': true}).then((value) {
                          FirebaseFirestore.instance
                              .collection('kuri')
                              .doc(widget.id)
                              .update({
                            'totalReceived': FieldValue.increment(
                                double.tryParse(payment.amount.toString())!)
                          });
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(currentuserid)
                              .collection('incomes')
                              .add({
                            'amount':
                                double.tryParse(payment.amount!.toString()),
                            "categoryIcon": serializeIcon(icons),
                            "categoryName": categoryName.toString(),
                            'date': DateTime.now(),
                            'merchant': '',
                          });

                          showSnackbar(context,
                              'amount of ₹${payment.amount!.truncate()} from ${user.userName} is verified');
                        });
                      } else {
                        showSnackbar(
                            context, 'This payment is already verified');
                      }
                    },
                    child: Container(
                      width: scrWidth,
                      height: textFormFieldHeight45,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: GestureDetector(
                          child: Text(
                            "Verify",
                            style: TextStyle(
                                fontSize: FontSize16,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
