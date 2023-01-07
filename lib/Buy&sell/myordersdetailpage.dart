import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/model/OrderModel.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class MyOrdersDetailsPage extends StatefulWidget {
  final OrderModel orderModel;
  const MyOrdersDetailsPage({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<MyOrdersDetailsPage> createState() => _MyOrdersDetailsPageState();
}

class _MyOrdersDetailsPageState extends State<MyOrdersDetailsPage> {
  final TextEditingController _reasonController = TextEditingController();
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
        leading:InkWell(
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
                            widget.orderModel.time!.day ==
                                DateTime.now().day
                                ? widget.orderModel.time!.hour >
                                12
                                ? "Today ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                : widget.orderModel
                                .time!
                                .hour ==
                                0
                                ? "Today 12:${widget.orderModel.time!.minute} AM"
                                : "Today ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM"
                                :

                            //YESTERDAY DATE
                            widget.orderModel.time!.day ==
                                DateTime.now().day - 1
                                ?widget.orderModel
                                .time!
                                .hour >
                                12
                                ? "Yesterday ${widget.orderModel.time!.hour - 12}:${widget.orderModel.time!.minute} PM"
                                : widget.orderModel
                                .time!
                                .hour ==
                                0
                                ? "Yesterday 12:${widget.orderModel.time!.minute} AM"
                                : "Yesterday ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM"
                                :

                            //OTHER DATE
                            widget.orderModel
                                .time!
                                .hour >
                                12
                                ? "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)} ${widget.orderModel.time!.hour - 12}:"
                                "${widget.orderModel.time!.minute} PM"
                                :widget.orderModel
                                .time!
                                .hour ==
                                0
                                ? "${DateFormat('dd-MMM-yyy').format(widget.orderModel.time!)} 12:${widget.orderModel.time!.minute} AM"
                                : "${DateFormat('dd-MMM-yyy')
                                .format(widget.orderModel.time!)}"
                                " ${widget.orderModel.time!.hour}:${widget.orderModel.time!.minute} AM",
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
                                   " ₹${
                                      widget.orderModel.orderedItems![index]
                                          .amount!
                                          .toString()
                                    }",
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
                                "₹${widget.orderModel.total}",
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
                                "₹${widget.orderModel.deliveryCharge!+widget.orderModel.total!}",
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
                              widget.orderModel.paymentMethod==0?'Cash On Delivery':'UPI Payment',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

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
                                    child:widget.orderModel.status==0?
                                    SvgPicture.asset("assets/icons/pending.svg"):
                                    SvgPicture.asset("assets/icons/accepted.svg"),
                                      ),
                              )
                          ),
                        ),
                        SizedBox(
                          height: scrHeight * 0.008,
                        ),
                        Container(
                          width: scrWidth * 0.15,
                          child: Text(
                            widget.orderModel.status==0?
                            "Order Pending":
                            "Order Accepted",
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
                    // SizedBox(width: 18,),
                    // Column(
                    //   children: [
                    //     SizedBox(
                    //       height: scrHeight * 0.03,
                    //     ),
                    //     DottedBorder(
                    //       borderType: BorderType.Circle,
                    //       radius: Radius.circular(scrWidth * 0.1),
                    //       dashPattern: [5, 5],
                    //       color: Colors.white,
                    //       strokeWidth: 1.5,
                    //       child: Center(
                    //           child: Padding(
                    //               padding: EdgeInsets.all(scrWidth * 0.07),
                    //               child: Container(
                    //                 height: 27,
                    //                 width: 27,
                    //                 child: SvgPicture.asset("assets/icons/shipped.svg",
                    //                     color: widget.orderModel.status!>1?Colors.white:
                    //                         Colors.white38
                    //                 ),
                    //               ))),
                    //     ),
                    //     SizedBox(
                    //       height: scrHeight * 0.008,
                    //     ),
                    //     Container(
                    //       width: scrWidth * 0.15,
                    //       child: Text(
                    //         "Order Accepted",
                    //         textAlign: TextAlign.center,
                    //         style: TextStyle(
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.white,
                    //             fontFamily: 'Urbanist'),
                    //       ),
                    //     )
                    //   ],
                    // ),
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
                                    child: SvgPicture.asset("assets/icons/delivered.svg",
                                      color: widget.orderModel.status==2?Colors.white:Colors.white70,
                                    ),
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
            widget.orderModel.status!>0?
                SizedBox():
            InkWell(
              onTap: (){
                 pay();
                // Navigator.pop(context);
                print("hloooo");
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
  void pay() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          // payableAmountNode.addListener(() {
          //   setState(() {});
          // });
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            title: Text("Enter Reason"),
            titleTextStyle: TextStyle(
                fontSize:17,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600,
                color: Colors.black),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: scrWidth,
                  height: textFormFieldHeight45,
                  padding: EdgeInsets.symmetric(
                    horizontal: scrWidth * 0.015,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: textFormFieldFillColor,
                    borderRadius: BorderRadius.circular(scrWidth * 0.03),
                  ),
                  child: TextFormField(
                    // focusNode: ,
                    controller: _reasonController,
                    cursorHeight: scrWidth * 0.055,
                    cursorWidth: 1,
                    cursorColor: Colors.black,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: FontSize15,
                      fontFamily: 'Urbanist',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Enter Reason',
                      labelStyle: TextStyle(
                        // color: productCategoryName.hasFocus
                        //     ? primarycolor
                        //     : textFormUnFocusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize15,
                        fontFamily: 'Urbanist',
                      ),
                      fillColor: textFormFieldFillColor,
                      filled: true,
                      contentPadding: EdgeInsets.only(
                          top: 5,
                          bottom: scrWidth * 0.033,
                          left: scrWidth * 0.033),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primarycolor,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: scrWidth * 0.03,
                ),

                InkWell(
                  onTap: () {
                    FirebaseFirestore
                        .instance
                        .collection('stores')
                        .doc(widget.orderModel.storeId)
                        .collection('orders')
                        .doc(widget.orderModel.orderId)
                        .update({
                      'status':3,
                      'reason':_reasonController.text??'',
                    });

                    Navigator.of(context)..pop();
                    // _showToast(context);
                  },
                  child: Container(
                    width: scrWidth,
                    height: textFormFieldHeight45,
                    decoration: BoxDecoration(
                        color: primarycolor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: GestureDetector(

                        child: Text(
                          "Cancel Order",
                          style: TextStyle(
                              fontSize: FontSize16,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
