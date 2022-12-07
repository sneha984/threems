import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/model/OrderModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';

class DeliveredPage extends StatefulWidget {
  final OrderModel order;
  const DeliveredPage({Key? key, required this.order}) : super(key: key);

  @override
  State<DeliveredPage> createState() => _DeliveredPageState();
}

class _DeliveredPageState extends State<DeliveredPage> {
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
                          "Order ${widget.order.orderId}",
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
                          //Today Date
                          widget.order.time!.day == DateTime.now().day
                              ? widget.order.time!.hour > 12
                                  ? "Today ${widget.order.time!.hour - 12}:${widget.order.time!.minute} PM"
                                  : widget.order.time!.hour == 0
                                      ? "Today 12:${widget.order.time!.minute} AM"
                                      : "Today ${widget.order.time!.hour}:${widget.order.time!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.order.time!.day == DateTime.now().day - 1
                                  ? widget.order.time!.hour > 12
                                      ? "Yesterday ${widget.order.time!.hour - 12}:${widget.order.time!.minute} PM"
                                      : widget.order.time!.hour == 0
                                          ? "Yesterday 12:${widget.order.time!.minute} AM"
                                          : "Yesterday ${widget.order.time!.hour}:${widget.order.time!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.order.time!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.order.time!)} ${widget.order.time!.hour - 12}"
                                          ":${widget.order.time!.minute} PM"
                                      : widget.order.time!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.order.time!)} 12:"
                                              "${widget.order.time!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.order.time!)}"
                                              " ${widget.order.time!.hour}:${widget.order.time!.minute} AM",
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
                          itemCount: widget.order.orderedItems!.length,
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
                                      widget.order.orderedItems![index].item!,
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
                                    widget.order.orderedItems![index].count!
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
                                    "₹${widget.order.orderedItems![index].amount!.toString()}",
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
                                "₹${widget.order.total!.toStringAsFixed(2)}",
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
                                "₹${widget.order.deliveryCharge}",
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
                                "₹${widget.order.deliveryCharge! + widget.order.total!}",
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
                              widget.order.address?.name ?? '',
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
                              widget.order.address?.phoneNumber ?? '',
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
                                'tel://${widget.order.address?.phoneNumber ?? 0}');

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
                            "${widget.order.address?.locationType ?? ''},${widget.order.address?.flatNo ?? ''}",
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
                            "City",
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
                            "${widget.order.address?.locality ?? ''},${widget.order.address?.pincode ?? ''}",
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
                          widget.order.time!.day == DateTime.now().day
                              ? widget.order.time!.hour > 12
                                  ? "Today ${widget.order.time!.hour - 12}:${widget.order.time!.minute} PM"
                                  : widget.order.time!.hour == 0
                                      ? "Today 12:${widget.order.time!.minute} AM"
                                      : "Today ${widget.order.time!.hour}:${widget.order.time!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.order.time!.day == DateTime.now().day - 1
                                  ? widget.order.time!.hour > 12
                                      ? "Yesterday ${widget.order.time!.hour - 12}:${widget.order.time!.minute} PM"
                                      : widget.order.time!.hour == 0
                                          ? "Yesterday 12:${widget.order.time!.minute} AM"
                                          : "Yesterday ${widget.order.time!.hour}:${widget.order.time!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.order.time!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.order.time!)} ${widget.order.time!.hour - 12}"
                                          ":${widget.order.time!.minute} PM"
                                      : widget.order.time!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.order.time!)} 12:"
                                              "${widget.order.time!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.order.time!)}"
                                              " ${widget.order.time!.hour}:${widget.order.time!.minute} AM",
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
                          widget.order.acceptedDate!.day == DateTime.now().day
                              ? widget.order.acceptedDate!.hour > 12
                                  ? "Today ${widget.order.acceptedDate!.hour - 12}:${widget.order.acceptedDate!.minute} PM"
                                  : widget.order.acceptedDate!.hour == 0
                                      ? "Today 12:${widget.order.acceptedDate!.minute} AM"
                                      : "Today ${widget.order.acceptedDate!.hour}:${widget.order.acceptedDate!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.order.acceptedDate!.day ==
                                      DateTime.now().day - 1
                                  ? widget.order.acceptedDate!.hour > 12
                                      ? "Yesterday ${widget.order.acceptedDate!.hour - 12}:${widget.order.acceptedDate!.minute} PM"
                                      : widget.order.acceptedDate!.hour == 0
                                          ? "Yesterday 12:${widget.order.acceptedDate!.minute} AM"
                                          : "Yesterday ${widget.order.acceptedDate!.hour}:${widget.order.acceptedDate!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.order.acceptedDate!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.order.acceptedDate!)} ${widget.order.acceptedDate!.hour - 12}"
                                          ":${widget.order.acceptedDate!.minute} PM"
                                      : widget.order.acceptedDate!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.order.acceptedDate!)} 12:"
                                              "${widget.order.acceptedDate!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.order.acceptedDate!)}"
                                              " ${widget.order.acceptedDate!.hour}:${widget.order.acceptedDate!.minute} AM",
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
                          //Today Date
                          widget.order.deliveryDate!.day == DateTime.now().day
                              ? widget.order.deliveryDate!.hour > 12
                                  ? "Today ${widget.order.deliveryDate!.hour - 12}:${widget.order.deliveryDate!.minute} PM"
                                  : widget.order.deliveryDate!.hour == 0
                                      ? "Today 12:${widget.order.deliveryDate!.minute} AM"
                                      : "Today ${widget.order.deliveryDate!.hour}:${widget.order.deliveryDate!.minute} AM"
                              :

                              //YESTERDAY DATE
                              widget.order.deliveryDate!.day ==
                                      DateTime.now().day - 1
                                  ? widget.order.deliveryDate!.hour > 12
                                      ? "Yesterday ${widget.order.deliveryDate!.hour - 12}:${widget.order.deliveryDate!.minute} PM"
                                      : widget.order.deliveryDate!.hour == 0
                                          ? "Yesterday 12:${widget.order.deliveryDate!.minute} AM"
                                          : "Yesterday ${widget.order.deliveryDate!.hour}:${widget.order.deliveryDate!.minute} AM"
                                  :

                                  //OTHER DATE
                                  widget.order.deliveryDate!.hour > 12
                                      ? "${DateFormat('dd-MMM-yyy').format(widget.order.deliveryDate!)} ${widget.order.deliveryDate!.hour - 12}"
                                          ":${widget.order.deliveryDate!.minute} PM"
                                      : widget.order.deliveryDate!.hour == 0
                                          ? "${DateFormat('dd-MMM-yyy').format(widget.order.deliveryDate!)} 12:"
                                              "${widget.order.deliveryDate!.minute} AM"
                                          : "${DateFormat('dd-MMM-yyy').format(widget.order.deliveryDate!)}"
                                              " ${widget.order.deliveryDate!.hour}:${widget.order.deliveryDate!.minute} AM",
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
            // Row(
            //   children: [
            //     SizedBox(width: 39,),
            //
            //     InkWell(
            //       onTap: (){
            //         FirebaseFirestore.instance.collection('stores').doc(widget.order.storeId).collection('orders').doc(widget.order.orderId).update({
            //           'status':3
            //         });
            //       },
            //       child: Text(
            //         "Cancel Order",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w700,
            //             color: Color(0xffE54D3C),
            //             fontFamily: 'Urbanist'),
            //       ),
            //     ),
            //     SizedBox(width: 70,),
            //     InkWell(
            //       onTap: (){
            //         FirebaseFirestore.instance.collection('stores').
            //         doc(widget.order.storeId).collection('orders').doc(widget.order.orderId).update({
            //           'status':2
            //         }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveredPage(order: widget.order,))));
            //
            //       },
            //       child: Container(
            //         height: 40,
            //         width: 120,
            //         child: Center(child: Text("Delivered ",style: TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w700,
            //             color: Colors.white,
            //             fontFamily: 'Urbanist'),)),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: Color(0xff02B558)
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
