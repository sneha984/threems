import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/Orders/acceptedpage.dart';
import 'package:threems/Buy&sell/Orders/deliveredpage.dart';
import 'package:threems/Buy&sell/buy_and_sell.dart';
import 'package:threems/utils/themes.dart';

import '../../model/OrderModel.dart';
import '../../model/usermodel.dart';
import '../../screens/charity/donatenowpage.dart';
import '../../screens/splash_screen.dart';
import '../orderdetailspage.dart';
import 'cancelledpage.dart';
import 'orderviewpage.dart';

class Orders extends StatefulWidget {
  final String? storeId;
  const Orders({Key? key,  this.storeId}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin {
  List<OrderModel> pendingList = [];
  List<OrderModel> acceptedList = [];
  List<OrderModel> deliveredList = [];
  List<OrderModel> cancelledList = [];
  getOrders() {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeId)
        .collection('orders')
        .snapshots()
        .listen((event) {
      print(event.docs.length);
      print(event.docs.length);
      pendingList = [];
      acceptedList = [];
      deliveredList = [];
      cancelledList = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        print('status');
        print(doc['status']);
        doc['status'] == 0
            ? pendingList.add(OrderModel.fromJson(doc.data()!))
            : doc['status'] == 1
                ? acceptedList.add(OrderModel.fromJson(doc.data()!))
                : doc['status'] == 2
                    ? deliveredList.add(OrderModel.fromJson(doc.data()!))
                    : cancelledList.add(OrderModel.fromJson(doc.data()!));
      }

      if (mounted) {
        setState(() {
          print(widget.storeId);
          print("1111111111111111111111111");
          print(pendingList[0].time!);
        });
      }
    });
  }

  late TabController _tabController;
  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    getOrders();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Container(
            color: primarycolor,
            height: 110,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                           top: scrHeight * 0.03,
                            left: scrWidth * 0.02,
                            // bottom: scrHeight * 0.02,
                            right: scrWidth * 0.02),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: scrHeight * 0.027,
                        left: scrWidth * 0.05,
                      ),
                      child: Text(
                        "Orders",
                        style: TextStyle(
                            fontSize: scrWidth * 0.046,
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 32,
                  color: primarycolor,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: TabBar(
                      isScrollable: true,
                      controller: _tabController,
                      labelPadding: EdgeInsets.only(
                          left: scrWidth * 0.023, right: scrWidth * 0.019),
                      unselectedLabelColor: Colors.white,
                      unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          fontSize: 15),
                      labelColor: Color(0xff0D0D0D),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Urbanist',
                          fontSize: 15),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white),
                      tabs: [
                        Tab(
                          child: Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Pending",
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Accepted",
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Delivered",
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 32,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Cancelled",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            controller: _tabController,
            children: [
              pendingList.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        SvgPicture.asset("assets/icons/Group 173.svg"),
                        SizedBox(
                          height: 90,
                        ),
                        Text(
                          "You don't have any order yet",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: pendingList.length,
                      itemBuilder: (context, index) {
                        final order = pendingList[index];

                        return Column(children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrderDetailsPage(
                                              orderModel: pendingList[index],
                                            )));
                              },
                              child: Container(
                                height: 150,
                                width: 360,
                                decoration: BoxDecoration(
                                    color: Color(0xffF3F3F3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.15),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(
                                            2, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Order ${pendingList[index].orderId}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          //TODAY DATE
                                          pendingList[index].time!.day ==
                                                  DateTime.now().day
                                              ? pendingList[index].time!.hour >
                                                      12
                                                  ? "Today ${pendingList[index].time!.hour - 12}:${pendingList[index].time!.minute} PM"
                                                  : pendingList[index]
                                                              .time!
                                                              .hour ==
                                                          0
                                                      ? "Today 12:${pendingList[index].time!.minute} AM"
                                                      : "Today ${pendingList[index].time!.hour}:${pendingList[index].time!.minute} AM"
                                              :

                                              //YESTERDAY DATE
                                              pendingList[index].time!.day ==
                                                      DateTime.now().day - 1
                                                  ? pendingList[index]
                                                              .time!
                                                              .hour >
                                                          12
                                                      ? "Yesterday ${pendingList[index].time!.hour - 12}:${pendingList[index].time!.minute} PM"
                                                      : pendingList[index]
                                                                  .time!
                                                                  .hour ==
                                                              0
                                                          ? "Yesterday 12:${pendingList[index].time!.minute} AM"
                                                          : "Yesterday ${pendingList[index].time!.hour}:${pendingList[index].time!.minute} AM"
                                                  :

                                                  //OTHER DATE
                                                  pendingList[index]
                                                              .time!
                                                              .hour >
                                                          12
                                                      ? "${DateFormat('dd-MMM-yyy').format(pendingList[index].time!)} ${pendingList[index].time!.hour - 12}:${pendingList[index].time!.minute} PM"
                                                      : pendingList[index]
                                                                  .time!
                                                                  .hour ==
                                                              0
                                                          ? "${DateFormat('dd-MMM-yyy').format(pendingList[index].time!)} 12:${pendingList[index].time!.minute} AM"
                                                          : "${DateFormat('dd-MMM-yyy')
                                                      .format(pendingList[index].time!)}"
                                                      " ${pendingList[index].time!.hour}:${pendingList[index].time!.minute} AM",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff969696),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: pendingList[index]
                                              .orderedItems!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),

                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                      pendingList[index]
                                                          .orderedItems![index2]
                                                          .item!,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  // SizedBox(width: 80,),

                                                  Text(
                                                    "x",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),

                                                  Text(
                                                    pendingList[index]
                                                        .orderedItems![index2]
                                                        .count!
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 73,
                                                  ),

                                                  Text(
                                                    "₹${
                                                      order
                                                          .orderedItems![index2]
                                                          .amount!
                                                          .toString()
                                                    }",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffF10000),
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 90),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff969696),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          "₹${order.total!.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff0E0E0E),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                      }),
              acceptedList.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        SvgPicture.asset("assets/icons/Group 173.svg"),
                        SizedBox(
                          height: 90,
                        ),
                        Text(
                          "You don't have any order yet",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: acceptedList.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AcceptedPage(
                                              orderMdl: acceptedList[index],
                                            )));
                              },
                              child: Container(
                                height: 150,
                                width: 360,
                                decoration: BoxDecoration(
                                    color: Color(0xffF3F3F3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.15),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(
                                            2, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Order ${acceptedList[index].orderId}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          //TODAY DATE
                                          acceptedList[index].time!.day ==
                                                  DateTime.now().day
                                              ? acceptedList[index].time!.hour >
                                                      12
                                                  ? "Today ${acceptedList[index].time!.hour - 12}:${acceptedList[index].time!.minute} PM"
                                                  : acceptedList[index]
                                                              .time!
                                                              .hour ==
                                                          0
                                                      ? "Today 12:${acceptedList[index].time!.minute} AM"
                                                      : "Today ${acceptedList[index].time!.hour}:${acceptedList[index].time!.minute} AM"
                                              :

                                              //YESTERDAY DATE
                                              acceptedList[index].time!.day ==
                                                      DateTime.now().day - 1
                                                  ? acceptedList[index]
                                                              .time!
                                                              .hour >
                                                          12
                                                      ? "Yesterday ${acceptedList[index].time!.hour - 12}:${acceptedList[index].time!.minute} PM"
                                                      : acceptedList[index]
                                                                  .time!
                                                                  .hour ==
                                                              0
                                                          ? "Yesterday 12:${acceptedList[index].time!.minute} AM"
                                                          : "Yesterday ${acceptedList[index].time!.hour}:${acceptedList[index].time!.minute} AM"
                                                  :

                                                  //OTHER DATE
                                                  acceptedList[index]
                                                              .time!
                                                              .hour >
                                                          12
                                                      ? "${DateFormat('dd-MMM-yyy').format(acceptedList[index].time!)} ${acceptedList[index].time!.hour - 12}:${acceptedList[index].time!.minute} PM"
                                                      : acceptedList[index]
                                                                  .time!
                                                                  .hour ==
                                                              0
                                                          ? "${DateFormat('dd-MMM-yyy').format(acceptedList[index].time!)} 12:${acceptedList[index].time!.minute} AM"
                                                          : "${DateFormat('dd-MMM-yyy').format(acceptedList[index].time!)} ${acceptedList[index].time!.hour}:${acceptedList[index].time!.minute} AM",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff969696),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: acceptedList[index]
                                              .orderedItems!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),

                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                      acceptedList[index]
                                                          .orderedItems![index2]
                                                          .item!,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  // SizedBox(width: 80,),

                                                  Text(
                                                    "x",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),

                                                  Text(

                                                      acceptedList[index]
                                                          .orderedItems![index2]
                                                          .count!
                                                          .toString()
                                                   ,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 73,
                                                  ),

                                                  Text(
                                                    "₹${
                                                      acceptedList[index]
                                                          .orderedItems![index2]
                                                          .amount!.toStringAsFixed(2)
                                                    }",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffF10000),
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 90),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff969696),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          "₹${acceptedList[index].total!.toStringAsFixed(2)}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff0E0E0E),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                      }),
              deliveredList.isEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        SvgPicture.asset("assets/icons/Group 173.svg"),
                        SizedBox(
                          height: 90,
                        ),
                        Text(
                          "You don't have any order yet",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: deliveredList.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DeliveredPage(
                                            order: deliveredList[index])));
                              },
                              child: Container(
                                height: 150,
                                width: 360,
                                decoration: BoxDecoration(
                                    color: Color(0xffF3F3F3),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.15),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(
                                            2, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Order ${deliveredList[index].orderId}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            deliveredList[index].time!.day ==
                                                DateTime.now().day
                                                ? deliveredList[index].time!.hour >
                                                12
                                                ? "Today ${deliveredList[index].time!.hour - 12}:${deliveredList[index].time!.minute} PM"
                                                : deliveredList[index]
                                                .time!
                                                .hour ==
                                                0
                                                ? "Today 12:${deliveredList[index].time!.minute} AM"
                                                : "Today ${deliveredList[index].time!.hour}:${deliveredList[index].time!.minute} AM"
                                                :

                                            //YESTERDAY DATE
                                            deliveredList[index].time!.day ==
                                                DateTime.now().day - 1
                                                ?deliveredList[index]
                                                .time!
                                                .hour >
                                                12
                                                ? "Yesterday ${deliveredList[index].time!.hour - 12}:${deliveredList[index].time!.minute} PM"
                                                : deliveredList[index]
                                                .time!
                                                .hour ==
                                                0
                                                ? "Yesterday 12:${deliveredList[index].time!.minute} AM"
                                                : "Yesterday ${deliveredList[index].time!.hour}:${deliveredList[index].time!.minute} AM"
                                                :

                                            //OTHER DATE
                                            deliveredList[index]
                                                .time!
                                                .hour >
                                                12
                                                ? "${DateFormat('dd-MMM-yyy').format(deliveredList[index].time!)} ${deliveredList[index].time!.hour - 12}:"
                                                "${deliveredList[index].time!.minute} PM"
                                                :deliveredList[index]
                                                .time!
                                                .hour ==
                                                0
                                                ? "${DateFormat('dd-MMM-yyy').format(deliveredList[index].time!)} 12:${deliveredList[index].time!.minute} AM"
                                                : "${DateFormat('dd-MMM-yyy')
                                                .format(deliveredList[index].time!)}"
                                                " ${deliveredList[index].time!.hour}:${deliveredList[index].time!.minute} AM",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff969696),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: deliveredList[index]
                                              .orderedItems!
                                              .length,
                                          itemBuilder: (context, index2) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),

                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                      deliveredList[index]
                                                          .orderedItems![index2]
                                                          .item!,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  // SizedBox(width: 80,),

                                                  Text(
                                                    "x",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),

                                                  Text(
                                                   deliveredList[index]
                                                          .orderedItems![index2]
                                                          .count!
                                                          .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 73,
                                                  ),

                                                  Text(
                                                     " ₹${ deliveredList[index]
                                                          .orderedItems![index2]
                                                          .amount!
                                                          .toString()}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xffF10000),
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 90),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff969696),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Text(
                                          "₹${deliveredList[index].total}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff0E0E0E),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]);
                      }),
              cancelledList.isEmpty
                  ? Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  SvgPicture.asset("assets/icons/Group 173.svg"),
                  SizedBox(
                    height: 90,
                  ),
                  Text(
                    "You don't have any order yet",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
                  : ListView.builder(
                  itemCount: cancelledList.length,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CancelledPage(
                                         orderModels:cancelledList[index],)));
                          },
                          child: Container(
                            height: 150,
                            width: 360,
                            decoration: BoxDecoration(
                                color: Color(0xffF3F3F3),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.15),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(
                                        2, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Order ${cancelledList[index].orderId}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      cancelledList[index].time!.day ==
                                          DateTime.now().day
                                          ? cancelledList[index].time!.hour >
                                          12
                                          ? "Today ${cancelledList[index].time!.hour - 12}:${cancelledList[index].time!.minute} PM"
                                          : cancelledList[index]
                                          .time!
                                          .hour ==
                                          0
                                          ? "Today 12:${cancelledList[index].time!.minute} AM"
                                          : "Today ${cancelledList[index].time!.hour}:${cancelledList[index].time!.minute} AM"
                                          :

                                      //YESTERDAY DATE
                                      cancelledList[index].time!.day ==
                                          DateTime.now().day - 1
                                          ?cancelledList[index]
                                          .time!
                                          .hour >
                                          12
                                          ? "Yesterday ${cancelledList[index].time!.hour - 12}:${cancelledList[index].time!.minute} PM"
                                          : cancelledList[index]
                                          .time!
                                          .hour ==
                                          0
                                          ? "Yesterday 12:${cancelledList[index].time!.minute} AM"
                                          : "Yesterday ${cancelledList[index].time!.hour}:${cancelledList[index].time!.minute} AM"
                                          :

                                      //OTHER DATE
                                      cancelledList[index]
                                          .time!
                                          .hour >
                                          12
                                          ? "${DateFormat('dd-MMM-yyy').format(cancelledList[index].time!)} ${cancelledList[index].time!.hour - 12}:"
                                          "${cancelledList[index].time!.minute} PM"
                                          :cancelledList[index]
                                          .time!
                                          .hour ==
                                          0
                                          ? "${DateFormat('dd-MMM-yyy').format(cancelledList[index].time!)} 12:${cancelledList[index].time!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy')
                                          .format(cancelledList[index].time!)}"
                                          " ${cancelledList[index].time!.hour}:${cancelledList[index].time!.minute} AM",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xff969696),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: cancelledList[index]
                                          .orderedItems!
                                          .length,
                                      itemBuilder: (context, index2) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),

                                              Container(
                                                width: 150,
                                                child: Text(
                                                  cancelledList[index]
                                                      .orderedItems![index2]
                                                      .item!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontFamily:
                                                      'Urbanist',
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                              ),
                                              // SizedBox(width: 80,),

                                              Text(
                                                "x",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: 'Urbanist',
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),

                                              Text(
                                                  cancelledList[index]
                                                      .orderedItems![index2]
                                                      .count!
                                                      .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontFamily: 'Urbanist',
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 73,
                                              ),

                                              Text(
                                                 " ₹${cancelledList[index]
                                                      .orderedItems![index2]
                                                      .amount!
                                                      .toString()}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:
                                                    Color(0xffF10000),
                                                    fontFamily: 'Urbanist',
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(right: 90),
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff969696),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Text(
                                      "₹${cancelledList[index].total}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xff0E0E0E),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]);
                  }),

            ],
          ))
        ]),
      ),
    );
  }
}
