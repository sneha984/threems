import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/screens/chits/hosteddraft.dart';
import 'package:threems/pagess/hosteddrawn.dart';
import 'package:threems/screens/chits/vacantchitjoin.dart';
import 'package:threems/screens/chits/MyHostedPublishedChit.dart';
import 'package:threems/screens/chits/yourchitpage.dart';

import '../../Authentication/root.dart';
import '../../model/ChitModel.dart';
import '../../utils/customclip.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'create_new_chit_screen.dart';

class HostedChitPage extends StatefulWidget {
  const HostedChitPage({Key? key}) : super(key: key);

  @override
  State<HostedChitPage> createState() => _HostedChitPageState();
}

class _HostedChitPageState extends State<HostedChitPage>
    with TickerProviderStateMixin {
  List<ChitModel> myChits = [];
  List<ChitModel> vacantChits = [];
  List<ChitModel> hostedChits = [];

  static const _locale = 'HI';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale, decimalDigits: 2)
          .currencySymbol;

  // addFieldtoAlldoc() {
  //   FirebaseFirestore.instance.collection('chit').get().then(
  //         (value) => value.docs.forEach(
  //           (element) {
  //             FirebaseFirestore.instance
  //                 .collection('chit')
  //                 .doc(element.id)
  //                 .update({'payableAmount': 1000});
  //           },
  //         ),
  //       );
  // }

  getChits() {
    FirebaseFirestore.instance
        .collection('chit')
        .where('delete', isEqualTo: false)
        .snapshots()
        .listen((event) {
      var docs = event.docs;
      myChits = [];
      vacantChits = [];
      hostedChits = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in docs) {
        if (doc['userId'] == currentuserid) {
          hostedChits.add(ChitModel.fromJson(doc.data()!));
        } else if (doc['members'].toList().contains(currentuserid)) {
          myChits.add(ChitModel.fromJson(doc.data()!));
        } else if (((doc['members'].length < doc['membersCount']) &&
            doc['status'] == 1)) {
          vacantChits.add(ChitModel.fromJson(doc.data()!));
        }
      }

      if (mounted) {
        setState(() {
          print('=============------=================');
          print(myChits.length);
          print(hostedChits.length);
          print(vacantChits.length);
        });
      }
    });
  }

  late TabController _tabControllers;
  @override
  void initState() {
    // addFieldtoAlldoc();
    getChits();

    _tabControllers = TabController(length: 3, vsync: this);
    _tabControllers.addListener(_handleTabSelection);

    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabControllers.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.04,
                left: scrWidth * 0.07,
                bottom: scrHeight * 0.02,
                right: scrWidth * 0.05),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Chits",
            style: TextStyle(
                fontSize: scrWidth * 0.045,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [

          Padding(
            padding: EdgeInsets.only(
                right: scrWidth * 0.04,
                top: scrHeight * 0.046,
                bottom: scrHeight * 0.026),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateNewChitScreen(
                              chit: ChitModel(),
                            )));
              },
              child: Container(
                height: scrHeight * 0.07,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primarycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 11,
                      color: Colors.white,
                    ),
                    Text(
                      "Create Chit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CreateChitFont,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.03, bottom: scrHeight * 0.025),
            child: Container(
              height: scrHeight * 0.037,
              child: TabBar(
                  isScrollable: true,
                  indicatorWeight: 0.05,
                  controller: _tabControllers,
                  unselectedLabelColor: Color(0xffA7A7A7),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Urbanist',
                      fontSize: scrWidth * 0.0385),

                  // indicatorPadding: EdgeInsets.only(bottom: scrHeight*0.00,left: scrWidth*0.00,right: scrWidth*0.00),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.5),
                      color: Color.fromRGBO(169, 255, 188, 0.6)),
                  indicatorSize: TabBarIndicatorSize.label,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.only(
                      left: scrWidth * 0.023, right: scrWidth * 0.019),
                  //  indicatorWeight: 1,

                  tabs: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _tabControllers.index = 0;
                        });
                      },
                      child: Tab(
                        child: Container(
                          height: scrHeight * 0.04,
                          width: scrWidth * 0.343,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0, 0.06),
                                  width: scrWidth * 0.003)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: scrWidth * 0.065,
                              ),
                              Text(
                                "Your Chits",
                              ),
                              SizedBox(
                                width: scrWidth * 0.03,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: scrHeight * 0.0035,
                                    top: scrHeight * 0.0035),
                                child: CircleAvatar(
                                  radius: 11,
                                  child: Text(myChits.length.toString(),
                                      style: tababrnumberFont),
                                  backgroundColor: (_tabControllers.index == 0)
                                      ? Color.fromRGBO(0, 128, 54, 0.47)
                                      : Color(0xffD4D4D4),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _tabControllers.index = 1;
                        });
                      },
                      child: Tab(
                        child: Container(
                          height: scrHeight * 0.04,
                          width: scrWidth * 0.343,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0, 0.06),
                                  width: scrWidth * 0.003)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: scrWidth * 0.027,
                              ),
                              Text("Vacant Chits"),
                              SizedBox(
                                width: scrWidth * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: scrHeight * 0.0035,
                                    top: scrHeight * 0.0035),
                                child: CircleAvatar(
                                  radius: 11,
                                  child: Text(vacantChits.length.toString(),
                                      style: tababrnumberFont),
                                  backgroundColor: (_tabControllers.index == 1)
                                      ? Color.fromRGBO(0, 128, 54, 0.47)
                                      : Color(0xffD4D4D4),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _tabControllers.index = 2;
                        });
                      },
                      child: Tab(
                        child: Container(
                          height: scrHeight * 0.04,
                          width: scrWidth * 0.343,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              border: Border.all(
                                  color: Color.fromRGBO(0, 0, 0, 0.06),
                                  width: scrWidth * 0.003)),
                          child: Row(
                            children: [
                              SizedBox(
                                width: scrWidth * 0.025,
                              ),
                              Text("Hosted Chits"),
                              SizedBox(
                                width: scrWidth * 0.024,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: scrHeight * 0.0035,
                                    top: scrHeight * 0.0035),
                                child: CircleAvatar(
                                  radius: 11,
                                  child: Text(hostedChits.length.toString(),
                                      style: tababrnumberFont),
                                  backgroundColor: (_tabControllers.index == 2)
                                      ? Color.fromRGBO(0, 128, 54, 0.47)
                                      : Color(0xffD4D4D4),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabControllers,
            children: [
              //MY CHITS
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: scrHeight * 0.025,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(
                          left: scrHeight * 0.02,
                          right: scrHeight * 0.02,
                          bottom: scrHeight * 0.02,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: myChits.length, // the length
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => YourChitPage(
                                                id: myChits[index].chitId!,
                                              )));
                                },
                                child: Container(
                                  height: scrHeight * 0.17,
                                  width: scrWidth * 0.95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: const Offset(
                                          2.0,
                                          2.0,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                    ],
                                  ),

                                  // height: 147,
                                  // width: 339,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: scrWidth * 0.025,
                                                right: scrWidth * 0.025,
                                                // bottom: scrWidth*0.025,
                                                top: scrWidth * 0.03),
                                            child: Container(
                                              width: scrWidth * 0.15,
                                              height: scrHeight * 0.07,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          myChits[index]
                                                                  .profile ??
                                                              ''))),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: scrHeight * 0.015,
                                              ),
                                              Text(
                                                "Name",
                                                style: chitcardone10,
                                              ),
                                              Text(myChits[index].chitName!,
                                                  style: chitcard15),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: scrWidth * 0.55),
                                                child: Text(
                                                  "Value",
                                                  style: chitcardone10,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                    scrWidth *
                                                                        0.01),
                                                        child: SvgPicture.asset(
                                                          "assets/icons/timericon.svg",
                                                        ),
                                                      ),
                                                      Text(
                                                          "${myChits[index].duration} Months",
                                                          style: tenmonthsfont),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: scrHeight * 0.135,
                                                  ),
                                                  Text(
                                                      '$_currency ${_formatNumber(
                                                        myChits[index]
                                                            .amount!
                                                            .truncate()
                                                            .toString()
                                                            .replaceAll(
                                                                ',', ''),
                                                      )}',
                                                      style: valuefontchit)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: scrWidth * 0.28,
                                            height: scrHeight * 0.03,
                                            // height: 24,
                                            // width: 102,

                                            decoration: BoxDecoration(
                                                color: Color(0xffECECEC),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: scrWidth * 0.03,
                                                    right: scrWidth * 0.035,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/people.svg",
                                                  ),
                                                ),
                                                Text(
                                                    "${myChits[index].members!.length}/${myChits[index].membersCount} Users",
                                                    style: tenbytenfont)
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: scrWidth * 0.1,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Subscription",
                                                style: chitcardone10,
                                              ),
                                              SizedBox(
                                                height: scrHeight * 0.001,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      '$_currency ${_formatNumber(
                                                        myChits[index]
                                                            .subscriptionAmount!
                                                            .truncate()
                                                            .toString()
                                                            .replaceAll(
                                                                ',', ''),
                                                      )}',
                                                      style: valuefontchit),
                                                  Text(
                                                    "/${myChits[index].chitType == 'Monthly' ? "Month" : "Week"}",
                                                    style: chitcardtwomonth10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),

              //VACANT CHITS
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: scrHeight * 0.015,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(
                          left: scrHeight * 0.02,
                          right: scrHeight * 0.02,
                          bottom: scrHeight * 0.02,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: vacantChits.length, // the length
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: scrHeight * 0.01),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VacantChitJoinPage(
                                              id: vacantChits[index].chitId!,
                                            )));
                              },
                              child: Container(
                                height: scrHeight * 0.17,
                                width: scrWidth * 0.95,
                                // height: 147,
                                // width: 339,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      offset: const Offset(
                                        2.0,
                                        2.0,
                                      ),
                                      blurRadius: 20.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                  ],
                                ),

                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: scrWidth * 0.025,
                                              right: scrWidth * 0.025,
                                              // bottom: scrWidth*0.025,
                                              top: scrWidth * 0.03),
                                          child: Container(
                                            width: scrWidth * 0.15,
                                            height: scrHeight * 0.07,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    vacantChits[index]
                                                        .profile!),
                                                fit: BoxFit.fill,
                                              ),
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: scrHeight * 0.015,
                                            ),
                                            Text(
                                              "Name",
                                              style: chitcardone10,
                                            ),
                                            Text(vacantChits[index].chitName!,
                                                style: chitcard15),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: scrWidth * 0.55),
                                              child: Text(
                                                "Value",
                                                style: chitcardone10,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right:
                                                              scrWidth * 0.01),
                                                      child: SvgPicture.asset(
                                                        "assets/icons/timericon.svg",
                                                      ),
                                                    ),
                                                    Text(
                                                        "${vacantChits[index].duration!} Months",
                                                        style: tenmonthsfont),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: scrHeight * 0.135,
                                                ),
                                                Text(
                                                    '$_currency ${_formatNumber(
                                                      vacantChits[index]
                                                          .amount!
                                                          .truncate()
                                                          .toString()
                                                          .replaceAll(',', ''),
                                                    )}',
                                                    style: valuefontchit)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      indent: 30,
                                      endIndent: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: scrWidth * 0.28,
                                          height: scrHeight * 0.03,
                                          // height: 24,
                                          // width: 102,

                                          decoration: BoxDecoration(
                                              color: Color(0xffECECEC),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: scrWidth * 0.03,
                                                  right: scrWidth * 0.035,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/icons/people.svg",
                                                ),
                                              ),
                                              Text(
                                                  "${vacantChits[index].members!.length}/${vacantChits[index].membersCount} Users",
                                                  style: tenbytenfont)
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.1,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Subscription",
                                              style: chitcardone10,
                                            ),
                                            SizedBox(
                                              height: scrHeight * 0.001,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    '$_currency ${_formatNumber(
                                                      vacantChits[index]
                                                          .subscriptionAmount!
                                                          .truncate()
                                                          .toString()
                                                          .replaceAll(',', ''),
                                                    )}',
                                                    style: valuefontchit),
                                                Text(
                                                  "/${vacantChits[index].chitType == 'Monthly' ? 'Month' : 'Week'}",
                                                  style: chitcardtwomonth10,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),

              //HOSTED CHITS
              Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: scrHeight * 0.01,
                        ),
                        ListView.builder(
                            padding: EdgeInsets.only(
                              left: scrHeight * 0.02,
                              right: scrHeight * 0.02,
                              bottom: scrHeight * 0.02,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: hostedChits.length, // the length
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: scrHeight * 0.015),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  hostedChits[index].status == 0
                                                      ? HostedDraftPage(
                                                          id: hostedChits[index]
                                                              .chitId!,
                                                        )
                                                      : MyHostedPublishedChit(
                                                          id: hostedChits[index]
                                                              .chitId!)));
                                    });
                                  },
                                  child: Container(
                                    height: scrHeight * 0.17,
                                    width: scrWidth * 0.95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(
                                            2.0,
                                            2.0,
                                          ),
                                          blurRadius: 20.0,
                                          spreadRadius: 1.0,
                                        ), //BoxShadow
                                      ],
                                    ),

                                    // height: 147,
                                    // width: 339,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: scrWidth * 0.025,
                                                  right: scrWidth * 0.022,
                                                  // bottom: scrWidth*0.025,
                                                  top: scrWidth * 0.03),
                                              child: Container(
                                                width: scrWidth * 0.15,
                                                height: scrHeight * 0.07,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          hostedChits[index]
                                                              .profile!)),
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: scrHeight * 0.015,
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Name",
                                                        style: chitcardone10),
                                                    SizedBox(
                                                      width: scrWidth * 0.467,
                                                    ),
                                                    CustomPaint(
                                                      size: Size(
                                                          scrWidth * 0.4,
                                                          (scrWidth * 0.04)
                                                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                      painter: hostedChits[
                                                                      index]
                                                                  .status !=
                                                              2
                                                          ? RCustomPainter()
                                                          : RPSCustomPainter(),
                                                      child: Container(
                                                        width: scrWidth * 0.17,
                                                        height:
                                                            scrHeight * 0.023,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: scrWidth *
                                                                    0.01),
                                                        child: Center(
                                                          child: hostedChits[
                                                                          index]
                                                                      .status ==
                                                                  0
                                                              ? Text(
                                                                  "Draft",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          scrWidth *
                                                                              0.027,
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                )
                                                              : hostedChits[index]
                                                                          .status ==
                                                                      1
                                                                  ? Text(
                                                                      "Vacant",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize: scrWidth *
                                                                              0.027,
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    )
                                                                  : Text(
                                                                      "Published",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize: scrWidth *
                                                                              0.027,
                                                                          fontFamily:
                                                                              'Urbanist',
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                    hostedChits[index]
                                                        .chitName!,
                                                    style: chitcard15),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: scrWidth * 0.55),
                                                  child: Text("Value",
                                                      style: chitcardone10),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      scrWidth *
                                                                          0.01),
                                                          child:
                                                              SvgPicture.asset(
                                                            "assets/icons/timericon.svg",
                                                          ),
                                                        ),
                                                        Text(
                                                            "${hostedChits[index].duration} Months",
                                                            style:
                                                                tenmonthsfont),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: scrHeight * 0.135,
                                                    ),
                                                    Text(
                                                        '$_currency ${_formatNumber(
                                                          hostedChits[index]
                                                              .amount!
                                                              .truncate()
                                                              .toString()
                                                              .replaceAll(
                                                                  ',', ''),
                                                        )}',
                                                        style: valuefontchit)
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          indent: 30,
                                          endIndent: 30,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: scrWidth * 0.28,
                                              height: scrHeight * 0.03,
                                              decoration: BoxDecoration(
                                                  color: Color(0xffECECEC),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: scrWidth * 0.03,
                                                      right: scrWidth * 0.035,
                                                    ),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/people.svg",
                                                    ),
                                                  ),
                                                  Text(
                                                      "${hostedChits[index].members!.length}/${hostedChits[index].membersCount} Users",
                                                      style: tenbytenfont)
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: scrWidth * 0.1,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text("Subscription",
                                                    style: chitcardone10),
                                                SizedBox(
                                                  height: scrHeight * 0.001,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        '$_currency ${_formatNumber(
                                                          hostedChits[index]
                                                              .subscriptionAmount!
                                                              .truncate()
                                                              .toString()
                                                              .replaceAll(
                                                                  ',', ''),
                                                        )}',
                                                        style: valuefontchit),
                                                    Text(
                                                        "/${hostedChits[index].chitType == 'Monthly' ? 'Month' : 'Week'}",
                                                        style:
                                                            chitcardtwomonth10),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  )),
            ],
          ))
        ],
      ),
    );
  }
}
