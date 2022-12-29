import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Buy&sell/Orders/deliveredpage.dart';
import 'package:threems/model/OrderModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';

class AcceptedPage extends StatefulWidget {
  final OrderModel orderMdl;
  const AcceptedPage({Key? key, required this.orderMdl}) : super(key: key);

  @override
  State<AcceptedPage> createState() => _AcceptedPageState();
}

class _AcceptedPageState extends State<AcceptedPage> {
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
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.02,
                left: scrWidth * 0.05,
                // bottom: scrHeight * 0.02,
                right: scrWidth * 0.04),
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
                          widget.orderMdl.time!.day == DateTime.now().day
                              ? widget.orderMdl.time!.hour > 12
                              ? "Today ${widget.orderMdl.time!.hour - 12}:${widget.orderMdl.time!.minute} PM"
                              : widget.orderMdl.time!.hour == 0
                              ? "Today 12:${widget.orderMdl.time!.minute} AM"
                              : "Today ${widget.orderMdl.time!.hour}:${widget.orderMdl.time!.minute} AM"
                              :

                          //YESTERDAY DATE
                          widget.orderMdl.time!.day ==
                              DateTime.now().day - 1
                              ? widget.orderMdl.time!.hour > 12
                              ? "Yesterday ${widget.orderMdl.time!.hour - 12}:${widget.orderMdl.time!.minute} PM"
                              : widget.orderMdl.time!.hour == 0
                              ? "Yesterday 12:${widget.orderMdl.time!.minute} AM"
                              : "Yesterday ${widget.orderMdl.time!.hour}:${widget.orderMdl.time!.minute} AM"
                              :

                          //OTHER DATE
                          widget.orderMdl.time!.hour > 12
                              ? "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.time!)} ${widget.orderMdl.time!.hour - 12}"
                              ":${widget.orderMdl.time!.minute} PM"
                              : widget.orderMdl.time!.hour == 0
                              ? "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.time!)} 12:"
                              "${widget.orderMdl.time!.minute} AM"
                              : "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.time!)}"
                              " ${widget.orderMdl.time!.hour}:${widget.orderMdl.time!.minute} AM",
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
                          //Today Date
                          widget.orderMdl.acceptedDate!.day ==
                              DateTime.now().day
                              ? widget.orderMdl.acceptedDate!.hour > 12
                              ? "Today ${widget.orderMdl.acceptedDate!.hour - 12}:${widget.orderMdl.acceptedDate!.minute} PM"
                              : widget.orderMdl.acceptedDate!.hour == 0
                              ? "Today 12:${widget.orderMdl.acceptedDate!.minute} AM"
                              : "Today ${widget.orderMdl.acceptedDate!.hour}:${widget.orderMdl.acceptedDate!.minute} AM"
                              :

                          //YESTERDAY DATE
                          widget.orderMdl.acceptedDate!.day ==
                              DateTime.now().day - 1
                              ? widget.orderMdl.acceptedDate!.hour > 12
                              ? "Yesterday ${widget.orderMdl.acceptedDate!.hour - 12}:${widget.orderMdl.acceptedDate!.minute} PM"
                              : widget.orderMdl.acceptedDate!.hour == 0
                              ? "Yesterday 12:${widget.orderMdl.acceptedDate!.minute} AM"
                              : "Yesterday ${widget.orderMdl.acceptedDate!.hour}:${widget.orderMdl.acceptedDate!.minute} AM"
                              :

                          //OTHER DATE
                          widget.orderMdl.acceptedDate!.hour > 12
                              ? "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.acceptedDate!)} ${widget.orderMdl.acceptedDate!.hour - 12}"
                              ":${widget.orderMdl.acceptedDate!.minute} PM"
                              : widget.orderMdl.acceptedDate!.hour == 0
                              ? "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.acceptedDate!)} 12:"
                              "${widget.orderMdl.acceptedDate!.minute} AM"
                              : "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.acceptedDate!)}"
                              " ${widget.orderMdl.acceptedDate!.hour}:${widget.orderMdl.acceptedDate!.minute} AM",
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
                          'Pending',
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
                        Container(
                          width: 190,
                          child: Text(
                            "Order ${widget.orderMdl.orderId}",
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                                color: Colors.black,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          widget.orderMdl.time!.day == DateTime.now().day
                              ? widget.orderMdl.time!.hour > 12
                                  ? "Today ${widget.orderMdl.time!.hour - 12}:${widget.orderMdl.time!.minute} PM"
                                  : widget.orderMdl.time!.hour == 0
                                      ? "Today 12:${widget.orderMdl.time!.minute} AM"
                                      : "Today ${widget.orderMdl.time!.hour}:${widget.orderMdl.time!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.orderMdl.time!.day ==
                                      DateTime.now().day - 1
                                  ? widget.orderMdl.time!.hour > 12
                                      ? "Yesterday ${widget.orderMdl.time!.hour - 12}:${widget.orderMdl.time!.minute} PM"
                                      : widget.orderMdl.time!.hour == 0
                                          ? "Yesterday 12:${widget.orderMdl.time!.minute} AM"
                                          : "Yesterday ${widget.orderMdl.time!.hour}:${widget.orderMdl.time!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.orderMdl.time!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.time!)} ${widget.orderMdl.time!.hour - 12}:${widget.orderMdl.time!.minute} PM"
                                      : widget.orderMdl.time!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.time!)} 12:${widget.orderMdl.time!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.orderMdl.time!)}"
                                              " ${widget.orderMdl.time!.hour}:${widget.orderMdl.time!.minute} AM",
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
                          itemCount: widget.orderMdl.orderedItems!.length,
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
                                      widget
                                          .orderMdl.orderedItems![index].item!,
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
                                    widget.orderMdl.orderedItems![index].count!
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
                                    " ₹${widget.orderMdl.orderedItems![index].amount!.toString()}",
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
                                "₹${widget.orderMdl.total!.toStringAsFixed(2)}",
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
                                "₹${widget.orderMdl.deliveryCharge!.toStringAsFixed(2)}",
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
                                "₹${widget.orderMdl.total! + widget.orderMdl.deliveryCharge!}",
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
                              widget.orderMdl.address?.name ?? '',
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
                              widget.orderMdl.address?.phoneNumber ?? '',
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
                                'tel://${widget.orderMdl.address?.phoneNumber ?? 0}');

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
                            "${widget.orderMdl.address?.locationType ?? ''},${widget.orderMdl.address?.flatNo ?? ''}",
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
                            "${widget.orderMdl.address?.locality ?? ''},${widget.orderMdl.address?.pincode ?? ''}",
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
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        content: const Text("Do You Want to Cancel this order?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              FirebaseFirestore.instance
                                  .collection('stores')
                                  .doc(widget.orderMdl.storeId)
                                  .collection('orders')
                                  .doc(widget.orderMdl.orderId)
                                  .update({'status': 3});
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Yes",
                              style: TextStyle(color: primarycolor),
                            ),
                          ),
                        ],
                      ),
                    );
                    // FirebaseFirestore.instance
                    //     .collection('stores')
                    //     .doc(widget.orderMdl.storeId)
                    //     .collection('orders')
                    //     .doc(widget.orderMdl.orderId)
                    //     .update({'status': 3});
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
                        .doc(widget.orderMdl.storeId)
                        .collection('orders')
                        .doc(widget.orderMdl.orderId)
                        .update({
                      'status': 2,
                      'deliveryDate': DateTime.now()
                    }).then((value) {
                      FirebaseFirestore.instance
                          .collection('stores')
                          .doc(widget.orderMdl.storeId)
                          .update({
                        'totalSales':
                            FieldValue.increment(widget.orderMdl.total!),
                      });
                    }).then((value) => Navigator.pop(context));
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    child: Center(
                        child: Text(
                      "Delivered ",
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
    //   Scaffold(
    //   backgroundColor: Colors.grey.shade100,
    //   appBar: AppBar(
    //     toolbarHeight: 84,
    //     shadowColor: Colors.grey,
    //     centerTitle: false,
    //     elevation: 0.1,
    //     backgroundColor: Colors.white,
    //     leading: GestureDetector(
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //       child: Padding(
    //         padding: EdgeInsets.only(
    //             top: scrHeight * 0.03,
    //             left: scrWidth * 0.05,
    //             bottom: scrHeight * 0.01,
    //             right: scrWidth * 0.05),
    //         child: SvgPicture.asset(
    //           "assets/icons/arrow.svg",
    //         ),
    //       ),
    //     ),
    //     title: Padding(
    //       padding: EdgeInsets.only(top: scrHeight * 0.02),
    //       child: Text(
    //         "Orders",
    //         style: TextStyle(
    //             fontSize: scrWidth * 0.047,
    //             color: Colors.black,
    //             fontFamily: 'Urbanist',
    //             fontWeight: FontWeight.w700),
    //       ),
    //     ),
    //
    //   ),
    //   body:Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
    //         child: InkWell(
    //           onTap: (){
    //           },
    //           child: Container(
    //             height: 100,
    //             width: 360,
    //             decoration: BoxDecoration(
    //                 color: Colors.green,
    //                 borderRadius: BorderRadius.circular(30)
    //             ),
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 20,top: 15),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text("Customer Name:${widget.orderMdl.address?.name??''}"),
    //                   SizedBox(height: 5,),
    //                   Text("Delivery Location: Flat No ${widget.orderMdl.address?.flatNo??''},"
    //                       "${widget.orderMdl.address?.locality??''},"
    //                       "${widget.orderMdl.address?.pincode??''},"
    //                       "${widget.orderMdl.address?.locationType??''}}"),
    //                   SizedBox(height: 5,),
    //                   Text("Phone Number:${widget.orderMdl.address?.phoneNumber??''}"),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //       SizedBox(height: 20,),
    //       Container(
    //         height: 70,
    //         width: 325,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(20),
    //           color: Colors.grey,
    //         ),
    //         child: Row(
    //           children: [
    //             SizedBox(width: 10,),
    //             Container(
    //               height: 50,
    //               width: 50,
    //               decoration: BoxDecoration(
    //                   // image: DecorationImage(image: NetworkImage(widget.orderMdl.itemImage!),fit: BoxFit.fill)
    //               ),
    //             ),
    //             SizedBox(width: 20,),
    //
    //             // Text(widget.orderMdl.item!),
    //             SizedBox(width: 50,),
    //
    //             // Text(widget.orderMdl.count!.toString()),
    //             SizedBox(width: 35,),
    //
    //             // Text(widget.orderMdl.amount!.toString()),
    //           ],
    //         ),
    //       ),
    //       SizedBox(
    //         height: 300,
    //       ),
    //       Text("Total Price:"),
    //
    //       ElevatedButton(
    //           onPressed: (){
    //             FirebaseFirestore
    //                 .instance
    //                 .collection('stores')
    //                 .doc(widget.orderMdl.storeId)
    //                 .collection('orders').doc(widget.orderMdl.orderId).update({
    //               'status':2
    //             });
    //           } ,
    //           child:Text("Mark as Delivered"))
    //     ],
    //   ),
    // )
    ;
  }
}
