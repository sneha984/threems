import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Authentication/root.dart';
import '../model/ChitModel.dart';
import '../model/usermodel.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class UpcomingCollections extends StatefulWidget {
  const UpcomingCollections({Key? key}) : super(key: key);

  @override
  State<UpcomingCollections> createState() => _UpcomingCollectionsState();
}

class _UpcomingCollectionsState extends State<UpcomingCollections> {
  List<ChitModel> myChits = [];
  getChits() {
    myChits = [];
    FirebaseFirestore.instance
        .collection('chit')
        .where('userId', isEqualTo: currentuserid)
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        myChits.add(ChitModel.fromJson(doc.data()!));
      }
      if (mounted) {
        print(myChits.length.toString() + 'oooooooooooooooo');
        getUpComingChits();
      }
    });
  }

  double total = 0;
  getTotal() {
    print('lllllllllll');
    print(upComingCollections.length);

    total = 0;
    for (CollectionModel chit in upComingCollections) {
      total += chit.chit!.payableAmount!;
    }
    setState(() {
      getUsersName();
      print(total.toString() + 'TOtazllllllllllll');
    });
  }

  List<CollectionModel> upComingCollections = [];
  getUpComingChits() {
    upComingCollections = [];
    for (var chit in myChits) {
      List paidUsers = [];
      if (chit.chitType == 'Monthly') {
        print('monthly here');
        // upcoming day
        if (DateTime(
                DateTime.now().year,
                DateTime.now().month,
                chit.chitDate!,
                int.parse(chit.chitTime!.split(':')[0]),
                int.parse(chit.chitTime!.split(':')[1]))
            .isAfter(DateTime.now())) {
          print('Upcoming month ');

          Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month - 1,
              chit.chitDate!,
              int.parse(chit.chitTime!.split(':')[0]),
              int.parse(chit.chitTime!.split(':')[1]))); //To TimeStamp
          FirebaseFirestore.instance
              .collection('chit')
              .doc(chit.chitId)
              .collection('payments')
              .where('verified', isEqualTo: true)
              .where('datePaid', isGreaterThan: dateInTimeStamp)
              .snapshots()
              .listen((innerDoc) {
            print('Upcoming month Stream');
            for (DocumentSnapshot<Map<String, dynamic>> doc in innerDoc.docs) {
              paidUsers.add(doc['userId']);
            }
            for (var user in chit.members!) {
              if (!(paidUsers.contains(user))) {
                final value = CollectionModel(chit: chit, userId: user);
                upComingCollections.add(value);
              }
            }

            if (mounted) {
              setState(() {
                getTotal();
              });
            }
          });
        } else {
          Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              chit.chitDate!,
              int.parse(chit.chitTime!.split(':')[0]),
              int.parse(chit.chitTime!.split(':')[1]))); //To TimeStamp
          FirebaseFirestore.instance
              .collection('chit')
              .doc(chit.chitId)
              .collection('payments')
              .where('verified', isEqualTo: true)
              .where('datePaid', isGreaterThan: dateInTimeStamp)
              .snapshots()
              .listen((innerDoc) {
            for (DocumentSnapshot<Map<String, dynamic>> doc in innerDoc.docs) {
              paidUsers.add(doc['userId']);
            }

            for (var user in chit.members!) {
              if (!(paidUsers.contains(user))) {
                final value = CollectionModel(chit: chit, userId: user);
                upComingCollections.add(value);
              }
            }

            if (mounted) {
              setState(() {
                getTotal();
              });
            }
          });
        }
      } else {
//UPCOMING
        if (DateTime.now().weekday < chit.chitDate!) {
          Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              (DateTime.now().day -
                      (7 - DateTime.now().weekday) +
                      chit.chitDate!) -
                  7)); //To TimeStamp
          FirebaseFirestore.instance
              .collection('chit')
              .doc(chit.chitId)
              .collection('payments')
              .where('verified', isEqualTo: true)
              .where('datePaid', isGreaterThan: dateInTimeStamp)
              .snapshots()
              .listen((innerDoc) {
            for (DocumentSnapshot<Map<String, dynamic>> doc in innerDoc.docs) {
              paidUsers.add(doc['userId']);
            }

            for (var user in chit.members!) {
              if (!(paidUsers.contains(user))) {
                final value = CollectionModel(chit: chit, userId: user);
                upComingCollections.add(value);
              }
            }

            if (mounted) {
              setState(() {
                getTotal();
              });
            }
          });
        } else {
          Timestamp dateInTimeStamp = Timestamp.fromDate(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              (DateTime.now().day -
                  (DateTime.now().weekday - chit.chitDate!)))); //To TimeStamp
          FirebaseFirestore.instance
              .collection('chit')
              .doc(chit.chitId)
              .collection('payments')
              .where('verified', isEqualTo: true)
              .where('datePaid', isGreaterThan: dateInTimeStamp)
              .snapshots()
              .listen((innerDoc) {
            for (DocumentSnapshot<Map<String, dynamic>> doc in innerDoc.docs) {
              paidUsers.add(doc['userId']);
            }

            for (var user in chit.members!) {
              if (!(paidUsers.contains(user))) {
                final value = CollectionModel(chit: chit, userId: user);
                upComingCollections.add(value);
              }
            }

            if (mounted) {
              setState(() {
                getTotal();
              });
            }
          });
        }
      }
    }
  }

  Map<String, UserModel>? userNames;
  getUsersName() {
    userNames = {};
    for (var collection in upComingCollections) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(collection.userId)
          .snapshots()
          .listen((event) {
        userNames![collection.userId!] = UserModel.fromJson(event.data()!);
        if (mounted) {
          setState(() {});
        }
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    getChits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.04,
                left: scrWidth * 0.07,
                bottom: scrHeight * 0.02,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Upcoming Collections",
            style: TextStyle(
                fontSize: scrWidth * 0.045,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: userNames == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 10,
                    child: Container(
                      width: scrWidth,
                      height: scrHeight * 0.09,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text('Collectable Amount In This Month :- '),
                            Text(
                              total.truncate().toString(),
                              style: TextStyle(
                                  color: primarycolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrHeight * 0.02,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: scrWidth * 0.04,
                              ),
                              Text(
                                "Collection",
                                style: TextStyle(
                                  fontSize: scrWidth * 0.027,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff827C7C),
                                ),
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
                              itemCount: upComingCollections.length,
                              itemBuilder: (BuildContext context, int index) {
                                final item = upComingCollections[index];
                                return upComingCollections.isEmpty
                                    ? Center(
                                        child: Text(
                                          'There is nothing to Show',
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: scrHeight * 0.012),
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
                                                              item.chit!
                                                                  .profile!),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    width: scrHeight * 0.012),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: scrHeight *
                                                              0.013),
                                                      child: Text(
                                                        userNames![item.userId]!
                                                            .userName!,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: scrWidth *
                                                                0.045),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: scrHeight * 0.004,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          item.chit!.chitName!,
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
                                                              scrWidth * 0.01,
                                                        ),
                                                        Text(
                                                          item.chit!
                                                              .payableAmount!
                                                              .truncate()
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: scrWidth *
                                                                0.033,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: primarycolor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
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
    );
  }
}

class CollectionModel {
  String? userId;
  ChitModel? chit;

  CollectionModel({
    this.chit,
    this.userId,
  });
}
