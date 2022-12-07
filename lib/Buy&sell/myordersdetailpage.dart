import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/model/OrderModel.dart';

import '../screens/splash_screen.dart';

class MyOrdersDetailsPage extends StatefulWidget {
  final OrderModel orderModel;
  const MyOrdersDetailsPage({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<MyOrdersDetailsPage> createState() => _MyOrdersDetailsPageState();
}

class _MyOrdersDetailsPageState extends State<MyOrdersDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // backgroundColor: Colors.grey.shade100,
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
                top: scrHeight*0.03,
                left: scrWidth* 0.05,
                bottom: scrHeight* 0.01,
                right: scrWidth * 0.05
            ),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Order Details",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Container(
                height: 310,
                width: 340,
                decoration: BoxDecoration(
                    color: Colors.white,
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
                          "Order ${widget.orderModel.orderId}",
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
                    SizedBox(height: 10,),
                    Container(
                      height: 50,
                      child: ListView.builder(
                          itemCount: widget.orderModel.orderedItems!.length,
                          itemBuilder: (context,index){
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(width: 20,),

                                  Container(
                                    width: 150,
                                    child: Text(
                                      widget.orderModel.orderedItems![index].item!,
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
                                    widget.orderModel.orderedItems![index].count!.toString()
                                    ,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(width: 73,),

                                  Text(
                                    widget.orderModel.orderedItems![index].amount!.toString(),
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

                    // Row(
                    //   children: [
                    //     SizedBox(width: 20,),
                    //
                    //     Container(
                    //       width: 150,
                    //       child: Text(
                    //         "erihfuehru",
                    //         style: TextStyle(
                    //             fontSize: 16,
                    //             color: Colors.black,
                    //             fontFamily: 'Urbanist',
                    //             fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //     // SizedBox(width: 80,),
                    //
                    //     Text(
                    //       "x",
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.black,
                    //           fontFamily: 'Urbanist',
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //     SizedBox(width: 5,),
                    //
                    //     Text(
                    //       "1",
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           color: Colors.black,
                    //           fontFamily: 'Urbanist',
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //     SizedBox(width: 92,),
                    //
                    //     Text(
                    //       "435",
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           color: Color(0xffF10000),
                    //           fontFamily: 'Urbanist',
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20,),
                    Divider(
                      thickness: 14,
                      color: Color(0xffF3F3F3),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 21, right: 21),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Item total",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff0E0E0E),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "₹345",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff0E0E0E),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Charge",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "₹64",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 11, right: 11, top: 3, bottom: 3),
                            child: DottedLine(
                              dashColor: Colors.grey,
                              lineThickness: 0.8,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text(
                                    "Grand Total",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff0E0E0E),
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Inclusive of all taxes",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Color(0xff818181),
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "₹12",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0E0E0E),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),

                          Padding(
                            padding:
                            EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
                            child: DottedLine(
                              dashColor: Colors.grey,
                              lineThickness: 0.8,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Delivery time",
                          //       style: TextStyle(
                          //           fontSize: 12,
                          //           color: Color(0xff0E0E0E),
                          //           fontFamily: 'Urbanist',
                          //           fontWeight: FontWeight.w600),
                          //     ),
                          //     SizedBox(
                          //       width: 30,
                          //     ),
                          //     Text(
                          //       "5 hour",
                          //       style: TextStyle(
                          //           fontSize: 14,
                          //           color: Color(0xff0E0E0E),
                          //           fontFamily: 'Urbanist',
                          //           fontWeight: FontWeight.w600),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PaymentMode",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff0E0E0E),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              Text(
                                "Cash On Delivery",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffE54D3C),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 180,top: 14),
              child: Text(
                "Current Status",
                style: TextStyle(
                    fontSize:16,
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 8,),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Container(
                height:156,
                width: 340,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff02B558)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 25,),
                    Column(
                      children: [
                        SizedBox(
                          height: scrHeight * 0.03,
                        ),
                        DottedBorder(
                          borderType: BorderType.Circle,
                          radius: Radius.circular(scrWidth * 0.1),
                          dashPattern: [5, 5],
                          color: Colors.white,
                          strokeWidth: 1.5,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(scrWidth * 0.07),
                                  child: Container(
                                      height: 27,
                                      width: 27,
                                      ))),
                        ),
                        SizedBox(
                          height: scrHeight * 0.008,
                        ),
                        Container(
                          width: scrWidth * 0.15,
                          child: Text(
                            "Order Pending",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Urbanist'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 18,),
                    Column(
                      children: [
                        SizedBox(
                          height: scrHeight * 0.03,
                        ),
                        DottedBorder(
                          borderType: BorderType.Circle,
                          radius: Radius.circular(scrWidth * 0.1),
                          dashPattern: [5, 5],
                          color: Colors.white,
                          strokeWidth: 1.5,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(scrWidth * 0.07),
                                  child: Container(
                                    height: 27,
                                    width: 27,
                                  ))),
                        ),
                        SizedBox(
                          height: scrHeight * 0.008,
                        ),
                        Container(
                          width: scrWidth * 0.15,
                          child: Text(
                            "Order Shipped",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Urbanist'),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 18,),
                    Column(
                      children: [
                        SizedBox(
                          height: scrHeight * 0.03,
                        ),
                        DottedBorder(
                          borderType: BorderType.Circle,
                          radius: Radius.circular(scrWidth * 0.1),
                          dashPattern: [5, 5],
                          color: Colors.white,
                          strokeWidth: 1.5,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.all(scrWidth * 0.07),
                                  child: Container(
                                    height: 27,
                                    width: 27,
                                  ))),
                        ),
                        SizedBox(
                          height: scrHeight * 0.008,
                        ),
                        Container(
                          width: scrWidth * 0.15,
                          child: Text(
                            "Order Delivered",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Urbanist'),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
            ,SizedBox(height: 20,),
            InkWell(
              onTap: (){
                FirebaseFirestore.instance.collection('stores').doc(widget.orderModel.storeId).collection('orders').doc(widget.orderModel.orderId).update({
                  'status':3
                });
              },
              child: Text(
                "Cancel Order",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xffE54D3C),
                    fontFamily: 'Urbanist'),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
