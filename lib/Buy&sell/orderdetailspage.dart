import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/model/OrderModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'Orders/acceptedpage.dart';
import 'myorderspage.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel orderModel;
  const OrderDetailsPage({Key? key, required this.orderModel})
      : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
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
                top: scrHeight * 0.03,
                left: scrWidth * 0.05,
                bottom: scrHeight * 0.01,
                right: scrWidth * 0.05),
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
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                          "Order ${widget.orderModel.orderId}",
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
                          widget.orderModel.time!.day == DateTime.now().day
                              ? widget.orderModel.time!.hour > 12
                                  ? "Today ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                  : widget.orderModel.time!.hour == 0
                                      ? "Today 12:${widget.orderModel.time!.minute} AM"
                                      : "Today ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.orderModel.time!.day ==
                                      DateTime.now().day - 1
                                  ? widget.orderModel.time!.hour > 12
                                      ? "Yesterday ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                      : widget.orderModel.time!.hour == 0
                                          ? "Yesterday 12:${widget.orderModel.time!.minute} AM"
                                          : "Yesterday ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.orderModel.time!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)} ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                      : widget.orderModel.time!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)} 12:${widget.orderModel.time!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)}"
                                              " ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff969696),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: ListView.builder(
                          itemCount: widget.orderModel.orderedItems!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                  ),

                                  Container(
                                    width: 150,
                                    child: Text(
                                      widget.orderModel.orderedItems![index]
                                          .item!,
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
                                  SizedBox(
                                    width: 5,
                                  ),

                                  Text(
                                    widget
                                        .orderModel.orderedItems![index].count!
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 73,
                                  ),

                                  Text(
                                    widget
                                        .orderModel.orderedItems![index].amount!
                                        .toString(),
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
                    SizedBox(
                      height: 20,
                    ),
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
                                "₹${widget.orderModel.total!.toStringAsFixed(2)}",
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
                                "₹${widget.orderModel.deliveryCharge}",
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
                            padding: EdgeInsets.only(
                                left: 11, right: 11, top: 3, bottom: 3),
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
                                  SizedBox(
                                    height: 5,
                                  ),
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
                                "₹${widget.orderModel.deliveryCharge! + widget.orderModel.total!}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff0E0E0E),
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: 17, right: 17, top: 10, bottom: 10),
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
              padding: const EdgeInsets.only(right: 180, top: 14),
              child: Text(
                "Current Details",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              // height: 220,
              width: 325,
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
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.orderModel.address?.name ?? '',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff0E0E0E),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.orderModel.address?.phoneNumber ?? '',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xff818181),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Uri call = Uri.parse(
                                'tel://${widget.orderModel.address?.phoneNumber ?? 0}');

                            launchUrl(call);
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Color(0xffD9D9D9),
                            child: Container(
                              height: 20,
                              width: 30,
                              child: SvgPicture.asset(
                                  "assets/icons/Vector (11).svg"),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 210, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xffE54D3C),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${widget.orderModel.address?.locationType ?? ''},${widget.orderModel.address?.flatNo ?? ''}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff0E0E0E),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'City',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xffE54D3C),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${widget.orderModel.address?.locality ?? ''},${widget.orderModel.address?.pincode ?? ''}",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff0E0E0E),
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 180, top: 14),
              child: Text(
                "Order Status",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 120,
              width: 325,
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
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //ORDERED DATE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Ordered Date",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffE54D3C),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          //Today Date
                          widget.orderModel.time!.day == DateTime.now().day
                              ? widget.orderModel.time!.hour > 12
                                  ? "Today ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                  : widget.orderModel.time!.hour == 0
                                      ? "Today 12:${widget.orderModel.time!.minute} AM"
                                      : "Today ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.orderModel.time!.day ==
                                      DateTime.now().day - 1
                                  ? widget.orderModel.time!.hour > 12
                                      ? "Yesterday ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                      : widget.orderModel.time!.hour == 0
                                          ? "Yesterday 12:${widget.orderModel.time!.minute} AM"
                                          : "Yesterday ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.orderModel.time!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)} ${widget.orderModel.time!.hour - 12}"
                                          ":${widget.orderModel.time!.minute} PM"
                                      : widget.orderModel.time!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)} 12:"
                                              "${widget.orderModel.time!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)}"
                                              " ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM",
                          style: TextStyle(
                              fontSize: 16,
                              color: primarycolor,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    //ACCEPTED DATE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Accepted Date",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffE54D3C),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                              fontSize: 16,
                              color: primarycolor,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    //DELIVERED DATE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Delivered Date",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xffE54D3C),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Pending",
                          style: TextStyle(
                              fontSize: 16,
                              color: primarycolor,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    SizedBox()
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            //   child: Container(
            //     height:156,
            //     width: 340,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: Color(0xff02B558)
            //     ),
            //     child: Row(
            //       children: [
            //         SizedBox(width: 25,),
            //         Column(
            //           children: [
            //             SizedBox(
            //               height: scrHeight * 0.03,
            //             ),
            //             DottedBorder(
            //               borderType: BorderType.Circle,
            //               radius: Radius.circular(scrWidth * 0.1),
            //               dashPattern: [5, 5],
            //               color: Colors.white,
            //               strokeWidth: 1.5,
            //               child: Center(
            //                   child: Padding(
            //                       padding: EdgeInsets.all(scrWidth * 0.07),
            //                       child: Container(
            //                           height: 27,
            //                           width: 27,
            //                           ))),
            //             ),
            //             SizedBox(
            //               height: scrHeight * 0.008,
            //             ),
            //             Container(
            //               width: scrWidth * 0.15,
            //               child: Text(
            //                 "Order Pending",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.white,
            //                     fontFamily: 'Urbanist'),
            //               ),
            //             )
            //           ],
            //         ),
            //         SizedBox(width: 18,),
            //         Column(
            //           children: [
            //             SizedBox(
            //               height: scrHeight * 0.03,
            //             ),
            //             DottedBorder(
            //               borderType: BorderType.Circle,
            //               radius: Radius.circular(scrWidth * 0.1),
            //               dashPattern: [5, 5],
            //               color: Colors.white,
            //               strokeWidth: 1.5,
            //               child: Center(
            //                   child: Padding(
            //                       padding: EdgeInsets.all(scrWidth * 0.07),
            //                       child: Container(
            //                         height: 27,
            //                         width: 27,
            //                       ))),
            //             ),
            //             SizedBox(
            //               height: scrHeight * 0.008,
            //             ),
            //             Container(
            //               width: scrWidth * 0.15,
            //               child: Text(
            //                 "Order Shipped",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.white,
            //                     fontFamily: 'Urbanist'),
            //               ),
            //             )
            //           ],
            //         ),
            //         SizedBox(width: 18,),
            //         Column(
            //           children: [
            //             SizedBox(
            //               height: scrHeight * 0.03,
            //             ),
            //             DottedBorder(
            //               borderType: BorderType.Circle,
            //               radius: Radius.circular(scrWidth * 0.1),
            //               dashPattern: [5, 5],
            //               color: Colors.white,
            //               strokeWidth: 1.5,
            //               child: Center(
            //                   child: Padding(
            //                       padding: EdgeInsets.all(scrWidth * 0.07),
            //                       child: Container(
            //                         height: 27,
            //                         width: 27,
            //                       ))),
            //             ),
            //             SizedBox(
            //               height: scrHeight * 0.008,
            //             ),
            //             Container(
            //               width: scrWidth * 0.15,
            //               child: Text(
            //                 "Order Delivered",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                     fontSize: 12,
            //                     fontWeight: FontWeight.w600,
            //                     color: Colors.white,
            //                     fontFamily: 'Urbanist'),
            //               ),
            //             )
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 39,
                ),
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('stores')
                        .doc(widget.orderModel.storeId)
                        .collection('orders')
                        .doc(widget.orderModel.orderId)
                        .update({'status': 3});
                  },
                  child: Text(
                    "Reject Order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffE54D3C),
                        fontFamily: 'Urbanist'),
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                InkWell(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('stores')
                        .doc(widget.orderModel.storeId)
                        .collection('orders')
                        .doc(widget.orderModel.orderId)
                        .update({
                      'status': 1,
                      'acceptedDate': DateTime.now()
                    }).then((value) => Navigator.pop(context));
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    child: Center(
                        child: Text(
                      "Accept Order",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Urbanist'),
                    )),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff02B558)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
