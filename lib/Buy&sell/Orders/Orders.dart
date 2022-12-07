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
import '../../screens/charity/donatenowpage.dart';
import '../../screens/splash_screen.dart';
import '../orderdetailspage.dart';
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
                    SizedBox(height: 150,),
                    SvgPicture.asset("assets/icons/Group 173.svg"),
                    SizedBox(height: 90,),

                    Text("You don't have any order yet",style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),)
                  ],
                ):
                ListView.builder(
                  itemCount: pendingList.length,
                    itemBuilder: (context,index){
                  return  Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: 10,right: 10,top: 20),
                            child: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage(orderModel: pendingList[index],)));
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
                                        offset: Offset(2, 3), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        SizedBox(width: 20,),
                                        Text(
                                          "Order ${pendingList[index].orderId}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Today 05:00 PM",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xff969696),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: pendingList[index].orderedItems!.length,
                                          itemBuilder: (context,index2){
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  SizedBox(width: 20,),

                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                      pendingList[index].orderedItems![index2].item!,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                  // SizedBox(width: 80,),

                                                  Text(
                                                    "x",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(width: 5,),

                                                  Text(
                                                    pendingList[index].orderedItems![index2].count!.toString()
                                                    ,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(width: 73,),

                                                  Text(
                                                    pendingList[index].orderedItems![index2].amount!.toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Color(0xffF10000),
                                                        fontFamily: 'Urbanist',
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 90),
                                          child: Text(
                                            "Total",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff969696),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),

                                        SizedBox(width: 40,),

                                        Text(
                                          "123",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff0E0E0E),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 15,),


                                  ],
                                ),

                              ),
                            ),
                      )
                      ]
                      );

                }
                ),
                // : Column(
                //   children: [
                //     Padding(
                //       padding:  EdgeInsets.only(left: 10,right: 10,top: 20),
                //       child: InkWell(
                //         onTap: (){
                //           Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetailsPage(orderModel: pendingList[0],)));
                //         },
                //         child: Container(
                //           height: 300,
                //           width: 360,
                //           decoration: BoxDecoration(
                //               color: Color(0xffF3F3F3),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Color.fromRGBO(0, 0, 0, 0.15),
                //                   spreadRadius: 1,
                //                   blurRadius: 3,
                //                   offset: Offset(2, 3), // changes position of shadow
                //                 ),
                //               ],
                //               borderRadius: BorderRadius.circular(20)
                //           ),
                //           child: Column(
                //             children: [
                //               SizedBox(height: 10,),
                //               Row(
                //                 children: [
                //                   SizedBox(width: 20,),
                //                   Text(
                //                     "Order #1265365",
                //                     style: TextStyle(
                //                         fontSize: 12,
                //                         color: Colors.black,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //                   SizedBox(width: 10,),
                //
                //                   Container(
                //                     height: 15,
                //                     width: 30,
                //                     decoration: BoxDecoration(
                //                         color: Color(0xff02B558),
                //                         borderRadius: BorderRadius.circular(5)
                //
                //                     ),
                //                     child: Center(
                //                       child: Text(
                //                         "New",
                //                         style: TextStyle(
                //                             fontSize: 12,
                //                             color: Colors.white,
                //                             fontFamily: 'Urbanist',
                //                             fontWeight: FontWeight.w600),
                //                       ),
                //                     ),
                //                   ),
                //                   SizedBox(width: 80,),
                //
                //                   Text(
                //                     "Today 05:00 PM",
                //                     style: TextStyle(
                //                         fontSize: 12,
                //                         color: Color(0xff969696),
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //                 ],
                //               ),
                //               SizedBox(height: 30,),
                //               Expanded(
                //                 child: ListView.builder(
                //                     itemCount: pendingList[0].orderedItems!.length,
                //                     itemBuilder: (context,index){
                //                       return Padding(
                //                         padding: const EdgeInsets.only(top: 10),
                //                         child: Row(
                //                           children: [
                //                             SizedBox(width: 20,),
                //
                //                             Container(
                //                               width: 150,
                //                               child: Text(
                //                                 pendingList[0].orderedItems![index].item!,
                //                                 style: TextStyle(
                //                                     fontSize: 16,
                //                                     color: Colors.black,
                //                                     fontFamily: 'Urbanist',
                //                                     fontWeight: FontWeight.w600),
                //                               ),
                //                             ),
                //                             // SizedBox(width: 80,),
                //
                //                             Text(
                //                               "x",
                //                               style: TextStyle(
                //                                   fontSize: 16,
                //                                   color: Colors.black,
                //                                   fontFamily: 'Urbanist',
                //                                   fontWeight: FontWeight.w600),
                //                             ),
                //                             SizedBox(width: 5,),
                //
                //                             Text(
                //                               pendingList[0].orderedItems![index].count!.toString()
                //                               ,
                //                               style: TextStyle(
                //                                   fontSize: 16,
                //                                   color: Colors.black,
                //                                   fontFamily: 'Urbanist',
                //                                   fontWeight: FontWeight.w600),
                //                             ),
                //                             SizedBox(width: 73,),
                //
                //                             Text(
                //                               pendingList[0].orderedItems![index].amount!.toString(),
                //                               style: TextStyle(
                //                                   fontSize: 16,
                //                                   color: Color(0xffF10000),
                //                                   fontFamily: 'Urbanist',
                //                                   fontWeight: FontWeight.w600),
                //                             ),
                //                           ],
                //                         ),
                //                       );
                //                     }),
                //               ),
                //
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(right: 90),
                //                     child: Text(
                //                       "Total",
                //                       style: TextStyle(
                //                           fontSize: 12,
                //                           color: Color(0xff969696),
                //                           fontFamily: 'Urbanist',
                //                           fontWeight: FontWeight.w600),
                //                     ),
                //                   ),
                //
                //                   SizedBox(width: 40,),
                //
                //                   Text(
                //                     "123",
                //                     style: TextStyle(
                //                         fontSize: 16,
                //                         color: Color(0xff0E0E0E),
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 15,),
                //
                //
                //             ],
                //           ),
                //
                //         ),
                //       ),
                //
                //       //   Column(
                //       //   children: [
                //       //     SizedBox(height: 10,),
                //       //     Container(
                //       //       height: 150,
                //       //       width: scrWidth,
                //       //       child: Column(
                //       //         children: [
                //       //           SizedBox(height: 5,),
                //       //           Padding(
                //       //             padding:  EdgeInsets.only(right:250 ),
                //       //             child:allOrders[index].status==0
                //       //                 ?Text("Pending")
                //       //                 :allOrders[index].status==1
                //       //                 ?Text("Accepted")
                //       //                 :allOrders[index].status==2
                //       //                 ?Text("Delivered"):
                //       //                 Text("Cancelled"),
                //       //           ),
                //       //           SizedBox(height: 5,),
                //       //           Container(
                //       //             height: 100,
                //       //             color: Colors.grey.withOpacity(0.1),
                //       //             child: Row(
                //       //               children: [
                //       //                 SizedBox(width: 10,),
                //       //                 Container(
                //       //                   height: 95,
                //       //                     width: 85,
                //       //                   decoration: BoxDecoration(
                //       //                     borderRadius: BorderRadius.circular(10),
                //       //                     image: DecorationImage(
                //       //
                //       //                         image: NetworkImage(
                //       //                             allOrders[index].itemImage!),fit: BoxFit.fill)
                //       //                   ),
                //       //                 ),
                //       //                 SizedBox(width: 30,),
                //       //                 Column(
                //       //                   crossAxisAlignment: CrossAxisAlignment.start,
                //       //                   children: [
                //       //                     SizedBox(height: 16,),
                //       //                     Text(allOrders[index].item!),
                //       //                     SizedBox(height: 10,),
                //       //                     Text("1 kg"),
                //       //
                //       //                   ],
                //       //                 )
                //       //               ],
                //       //             ),
                //       //           ),
                //       //           Padding(
                //       //             padding: EdgeInsets.only(left: 230,top: 5),
                //       //             child: Text("Total:${allOrders[index].amount}"),
                //       //           )
                //       //         ],
                //       //       ),
                //       //     ),
                //       //     Padding(
                //       //       padding: const EdgeInsets.only(top: 10),
                //       //       child: Divider(
                //       //         // height: 30,
                //       //         thickness: 12,
                //       //         color: Colors.grey.withOpacity(0.15),
                //       //       ),
                //       //     ),
                //       //
                //       //   ],
                //       // );
                //
                //
                //     )],
                // )
                // Container(
                //   height: scrHeight*6,
                //   child: ListView.builder(
                //     itemCount:pendingList[0].orderedItems!.length,
                //       itemBuilder: (context,index){
                //        // final pending=pendingList[index];
                //     return Padding(
                //       padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                //       child: InkWell(
                //         onTap: (){
                //           Navigator.push(context, MaterialPageRoute(
                //               builder: (context)=>OrderViewPage(orderModel: pendingList[index],)));
                //         },
                //         child: Container(
                //           height: 100,
                //           width: 30,
                //           decoration: BoxDecoration(
                //               color: Colors.green,
                //               borderRadius: BorderRadius.circular(30)
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 20,top: 15),
                //             child: Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text("Customer Name:${pendingList[index].address!.name}"),
                //                 SizedBox(height: 5),
                //                 Text("Phone Number:${pendingList[index].address!.phoneNumber}"),
                //                 SizedBox(height: 5,),
                //                 Text("DateTime:${pendingList[index].time}"),
                //               ],
                //             ),
                //           ),
                //
                //         ),
                //       ),
                //     );
                //   }),
                // ),
                acceptedList.isEmpty?
                Column(
                  children: [
                    SizedBox(height: 150,),
                    SvgPicture.asset("assets/icons/Group 173.svg"),
                    SizedBox(height: 90,),

                    Text("You don't have any order yet",style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ):
                ListView.builder(
                    itemCount: acceptedList.length,
                    itemBuilder: (context,index){
                      return  Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 10,right: 10,top: 20),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptedPage(orderMdl: acceptedList[index],)));
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
                                          offset: Offset(2, 3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Text(
                                            "Order ${acceptedList[index].orderId}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "Today 05:00 PM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff969696),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30,),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: acceptedList[index].orderedItems!.length,
                                            itemBuilder: (context,index2){
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 20,),

                                                    Container(
                                                      width: 150,
                                                      child: Text(
                                                        acceptedList[index].orderedItems![index2].item!,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontFamily: 'Urbanist',
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    // SizedBox(width: 80,),

                                                    Text(
                                                      "x",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 5,),

                                                    Text(
                                                      acceptedList[index].orderedItems![index2].count!.toString()
                                                      ,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 73,),

                                                    Text(
                                                      acceptedList[index].orderedItems![index2].amount!.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(0xffF10000),
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 90),
                                            child: Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff969696),
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),

                                          SizedBox(width: 40,),

                                          Text(
                                            "123",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff0E0E0E),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),


                                    ],
                                  ),

                                ),
                              ),
                            )
                          ]
                      );

                    }
                ),
                deliveredList.isEmpty?
                Column(
                  children: [
                    SizedBox(height: 150,),
                    SvgPicture.asset("assets/icons/Group 173.svg"),
                    SizedBox(height: 90,),

                    Text("You don't have any order yet",style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),)
                  ],
                ):
                ListView.builder(
                    itemCount: deliveredList.length,
                    itemBuilder: (context,index){
                      return  Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(left: 10,right: 10,top: 20),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveredPage(order: deliveredList[index])));
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
                                          offset: Offset(2, 3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          SizedBox(width: 20,),
                                          Text(
                                            "Order ${deliveredList[index].orderId}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "Today 05:00 PM",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff969696),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 30,),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: deliveredList[index].orderedItems!.length,
                                            itemBuilder: (context,index2){
                                              return Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 20,),

                                                    Container(
                                                      width: 150,
                                                      child: Text(
                                                        deliveredList[index].orderedItems![index2].item!,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontFamily: 'Urbanist',
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    // SizedBox(width: 80,),

                                                    Text(
                                                      "x",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 5,),

                                                    Text(
                                                      deliveredList[index].orderedItems![index2].count!.toString()
                                                      ,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(width: 73,),

                                                    Text(
                                                      deliveredList[index].orderedItems![index2].amount!.toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(0xffF10000),
                                                          fontFamily: 'Urbanist',
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 90),
                                            child: Text(
                                              "Total",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff969696),
                                                  fontFamily: 'Urbanist',
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),

                                          SizedBox(width: 40,),

                                          Text(
                                            "123",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff0E0E0E),
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15,),


                                    ],
                                  ),

                                ),
                              ),
                            )
                          ]
                      );

                    }
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
                        // return Padding(
                        //   padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                        //   child: InkWell(
                        //     onTap: (){
                        //       Navigator.push(context, MaterialPageRoute(
                        //           builder: (context)=>CancelledPage(orderModels: cancelledList[index],)));
                        //     },
                        //     child:
                        //     // Container(
                        //     //   height: 100,
                        //     //   width: 30,
                        //     //   decoration: BoxDecoration(
                        //     //       color: Colors.green,
                        //     //       borderRadius: BorderRadius.circular(30)
                        //     //   ),
                        //     //   child: Padding(
                        //     //     padding: const EdgeInsets.only(left: 20,top: 15),
                        //     //     child: Column(
                        //     //       crossAxisAlignment: CrossAxisAlignment.start,
                        //     //       children: [
                        //     //         Text("Customer Name:${cancelledList[index].address!.name}"),
                        //     //         SizedBox(height: 5),
                        //     //         Text("Phone Number:${cancelledList[index].address!.phoneNumber}"),
                        //     //         SizedBox(height: 5,),
                        //     //         Text("DateTime:${cancelledList[index].time}"),
                        //     //       ],
                        //     //     ),
                        //     //   ),
                        //     //
                        //     // ),
                        //   ),
                        // );
                        return Padding(
                          padding:  EdgeInsets.only(left: 15,right: 15,top: 20),
                          child: InkWell(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>CancelledPage()));
                            },
                            child: Container(
                              height: 140,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: Color(0xffF3F3F3),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(2, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      SizedBox(width: 20,),
                                      Text(
                                        "Order #1265365",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 10,),

                                      Container(
                                        height: 15,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Color(0xff02B558),
                                            borderRadius: BorderRadius.circular(5)

                                        ),
                                        child: Center(
                                          child: Text(
                                            "New",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontFamily: 'Urbanist',
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 80,),

                                      Text(
                                        "Today 05:00 PM",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff969696),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 30,),

                                  Row(
                                    children: [
                                      SizedBox(width: 20,),

                                      Container(
                                        width: 150,
                                        child: Text(
                                          "huhuuhuu",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      // SizedBox(width: 80,),

                                      Text(
                                        "x",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 5,),

                                      Text(
                                        "1",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 73,),

                                      Text(
                                        "254",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Color(0xffF10000),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 17,),
                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Total",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff969696),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(width: 30,),
                                      Text(
                                        "356",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),

                                    ],
                                  )

                                ],
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
