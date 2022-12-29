import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/kuri/hostedkuripage.dart';

import '../model/Kuri/kuriModel.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'kuriListViewPage.dart';

class Kuripage extends StatefulWidget {
  const Kuripage({Key? key}) : super(key: key);

  @override
  State<Kuripage> createState() => _KuripageState();
}

class _KuripageState extends State<Kuripage> with TickerProviderStateMixin {
  late TabController _tabController;

  List<KuriModel> addedKuri = [];
  List<KuriModel> hostedKuri = [];

  getAddedKuri() {
    print(currentuserid);
    FirebaseFirestore.instance
        .collection('kuri')
        .where('members', arrayContains: currentuserid)
        .snapshots()
        .listen((event) {
      addedKuri = [];
      for (var doc in event.docs) {
        addedKuri.add(KuriModel.fromJson(doc.data()));
      }

      if (mounted) {
        setState(() {
          // bs5Fg1reebM3LX9VO5QrkjSQqEA2
          print(addedKuri.length);
        });
      }
    });
  }

  getHostedKuri() {
    FirebaseFirestore.instance
        .collection('kuri')
        .where('userID', isEqualTo: currentuserid)
        .snapshots()
        .listen((event) {
      hostedKuri = [];
      for (var doc in event.docs) {
        hostedKuri.add(KuriModel.fromJson(doc.data()));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    getAddedKuri();
    getHostedKuri();

    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
            "Kuri",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: scrWidth * 0.04,
                top: scrHeight * 0.045,
                bottom: scrHeight * 0.025),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateKuriPage()));
              },
              child: Container(
                height: scrHeight * 0.07,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrWidth * 0.04),
                  color: primarycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.white,
                    ),
                    Text(
                      "Create Kuri",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CreateChitFont,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    ),
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
                top: scrHeight * 0.03, bottom: scrHeight * 0.014),
            child: Container(
              height: scrHeight * 0.039,
              child: TabBar(
                  isScrollable: true,
                  indicatorWeight: 0.05,
                  controller: _tabController,
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
                  padding: EdgeInsets.only(
                      left: scrWidth * 0.02, right: scrWidth * 0.6),
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.only(
                      left: scrWidth * 0.022, right: scrWidth * 0.019),
                  //  indicatorWeight: 1,

                  tabs: [
                    Tab(
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
                              width: scrWidth * 0.05,
                            ),
                            Text(
                              "Added Kuri",
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
                                child: Text(addedKuri.length.toString(),
                                    style: tababrnumberFont),
                                backgroundColor:
                                    Color.fromRGBO(0, 128, 54, 0.54),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
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
                              width: scrWidth * 0.05,
                            ),
                            Text("Hosted Kuri"),
                            SizedBox(
                              width: scrWidth * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: scrHeight * 0.0035,
                                  top: scrHeight * 0.0035),
                              child: CircleAvatar(
                                radius: 11,
                                child: Text(hostedKuri.length.toString(),
                                    style: tababrnumberFont),
                                backgroundColor:
                                    Color.fromRGBO(0, 128, 54, 0.47),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              addedKuri.isEmpty
                  ? Center(
                      child: Text('You are not added to any Kuri yet.'),
                    )
                  : Container(
                      color: Colors.white,
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: scrHeight * 0.01,
                            left: scrHeight * 0.02,
                            right: scrHeight * 0.02,
                            bottom: scrHeight * 0.02,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: addedKuri.length,
                          itemBuilder: (context, index) {
                            print('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[');
                            print(addedKuri.length);
                            return KuriViewPage(
                              kuri: addedKuri[index],
                            );
                          }),
                    ),
              hostedKuri.isEmpty
                  ? Center(
                      child: Text('You are not added to any Kuri yet.'),
                    )
                  : Container(
                      color: Colors.white,
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: scrHeight * 0.01,
                            left: scrHeight * 0.02,
                            right: scrHeight * 0.02,
                            bottom: scrHeight * 0.02,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: hostedKuri.length,
                          itemBuilder: (context, index) {
                            return KuriViewPage(
                              kuri: hostedKuri[index],
                            );
                          }),
                    ),
            ],
          ))
        ],
      ),
    );
  }
}
