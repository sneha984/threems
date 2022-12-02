import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/Orders/acceptedpage.dart';
import 'package:threems/Buy&sell/Orders/deliveredpage.dart';
import 'package:threems/Buy&sell/buy_and_sell.dart';
import 'package:threems/utils/themes.dart';

import '../../model/OrderModel.dart';
import '../../model/usermodel.dart';
import '../../screens/splash_screen.dart';
import 'cancelledpage.dart';
import 'orderviewpage.dart';

class Orders extends StatefulWidget {
  final String storeId;
  const Orders({Key? key, required this.storeId}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin{
  List <OrderModel> pendingList=[];
  List <OrderModel> acceptedList=[];
  List  <OrderModel> deliveredList=[];
  List  <OrderModel> cancelledList=[];
  getOrders(){
    FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeId)
        .collection('orders')
        .snapshots()
        .listen((event) {
          print(event.docs.length);
          print(event.docs.length);
          pendingList=[];
          acceptedList=[];
          deliveredList=[];
          cancelledList=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs) {
        print('status');
        print(doc['status']);
        doc['status'] == 0
            ?pendingList.add(OrderModel.fromJson(doc.data()!))
            : doc['status'] == 1
            ? acceptedList.add(OrderModel.fromJson(doc.data()!))
            : doc['status']==2
            ? deliveredList.add(OrderModel.fromJson(doc.data()!)):
             cancelledList.add(OrderModel.fromJson(doc.data()!));
      }

      if (mounted) {
        setState(() {
          print(widget.storeId);
          print("1111111111111111111111111");
          print(pendingList.length);
        });
      }
        });

  }

  late  TabController _tabController;
    void _handleTabSelection() {
      setState(() {
      });
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
        body: Column(
          children: [
            Container(
              color: primarycolor,
              height: 110,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: scrHeight * 0.027,
                            left: scrWidth*0.03
                          ),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              "assets/icons/whitearrow.svg",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: scrHeight * 0.027,
                          left: scrWidth * 0.05,),
                        child: Text("Orders",style:TextStyle(
                            fontSize: scrWidth * 0.046,
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                  SizedBox(height: 18,),
                  Container(
                    height: 32,
                    color: primarycolor,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 8),
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                         labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
                        unselectedLabelColor: Colors.white,
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist',fontSize:15),
                        labelColor: Color(0xff0D0D0D),
                        labelStyle: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Urbanist',fontSize: 15),
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
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Pending",),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Accepted",),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Delivered",),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Cancelled",),
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
                pendingList.isEmpty?
                Column(
                  children: [
                    SvgPicture.asset("assets/svg/noorders.svg"),
                    Text("You don't have any order yet",style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),)
                  ],
                )
                :Container(
                  height: scrHeight*6,
                  child: ListView.builder(
                    itemCount:pendingList.length,
                      itemBuilder: (context,index){
                       // final pending=pendingList[index];
                    return Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>OrderViewPage(orderModel: pendingList[index],)));
                        },
                        child: Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Customer Name:${pendingList[index].address!.name}"),
                                SizedBox(height: 5),
                                Text("Phone Number:${pendingList[index].address!.phoneNumber}"),
                                SizedBox(height: 5,),
                                Text("DateTime:${pendingList[index].time}"),
                              ],
                            ),
                          ),

                        ),
                      ),
                    );
                  }),
                ),
                Container(
                  height: scrHeight*6,
                  child: ListView.builder(
                      itemCount:acceptedList.length,
                      itemBuilder: (context,index){
                        // final pending=pendingList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>AcceptedPage(orderMdl: acceptedList[index],)));
                            },
                            child: Container(
                              height: 100,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Customer Name:${acceptedList[index].address!.name}"),
                                    SizedBox(height: 5),
                                    Text("Phone Number:${acceptedList[index].address!.phoneNumber}"),
                                    SizedBox(height: 5,),
                                    Text("DateTime:${acceptedList[index].time}"),
                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  height: scrHeight*6,
                  child: ListView.builder(
                      itemCount:deliveredList.length,
                      itemBuilder: (context,index){
                        // final pending=pendingList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>DeliveredPage(order: deliveredList[index],)));
                            },
                            child: Container(
                              height: 100,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Customer Name:${deliveredList[index].address!.name}"),
                                    SizedBox(height: 5),
                                    Text("Phone Number:${deliveredList[index].address!.phoneNumber}"),
                                    SizedBox(height: 5,),
                                    Text("DateTime:${deliveredList[index].time}"),
                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                      }),
                ),
                Container(
                  height: scrHeight*6,
                  child: ListView.builder(
                      itemCount:cancelledList.length,
                      itemBuilder: (context,index){
                        // final pending=pendingList[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>CancelledPage(orderModels: cancelledList[index],)));
                            },
                            child: Container(
                              height: 100,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,top: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Customer Name:${cancelledList[index].address!.name}"),
                                    SizedBox(height: 5),
                                    Text("Phone Number:${cancelledList[index].address!.phoneNumber}"),
                                    SizedBox(height: 5,),
                                    Text("DateTime:${cancelledList[index].time}"),
                                  ],
                                ),
                              ),

                            ),
                          ),
                        );
                      }),
                ),
              ],
            ))
          ]
      ),),
    );
  }
}
