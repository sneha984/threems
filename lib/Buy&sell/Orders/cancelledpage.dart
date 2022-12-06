import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/model/OrderModel.dart';

import '../../screens/splash_screen.dart';

class CancelledPage extends StatefulWidget {
  // final OrderModel orderModels;
  const CancelledPage({Key? key,}) : super(key: key);

  @override
  State<CancelledPage> createState() => _CancelledPageState();
}

class _CancelledPageState extends State<CancelledPage> {
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
            "Orders",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),

      ),
      body:Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
            child: Container(
              height: 330,
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
                          "erihfuehru",
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
                      SizedBox(width: 92,),

                      Text(
                        "435",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF10000),
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery time",
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
                              "5 hour",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff0E0E0E),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
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

          // SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(right: 190,top: 10),
            child: Text(
              "Custom Details",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'Urbanist'),
            ),
          ),
        ],
      ),
      // Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
      //       child: InkWell(
      //         onTap: (){
      //         },
      //         child: Container(
      //           height: 100,
      //           width: 360,
      //           decoration: BoxDecoration(
      //               color: Colors.green,
      //               borderRadius: BorderRadius.circular(30)
      //           ),
      //           child: Padding(
      //             padding: const EdgeInsets.only(left: 20,top: 15),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Text("Customer Name:${widget.orderModels.address?.name??''}"),
      //                 SizedBox(height: 5,),
      //                 Text("Delivery Location: Flat No ${widget.orderModels.address?.flatNo??''},"
      //                     "${widget.orderModels.address?.locality??''},"
      //                     "${widget.orderModels.address?.pincode??''},"
      //                     "${widget.orderModels.address?.locationType??''}}"),
      //                 SizedBox(height: 5,),
      //                 Text("Phone Number:${widget.orderModels.address?.phoneNumber??''}"),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 20,),
      //     Container(
      //       height: 70,
      //       width: 325,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(20),
      //         color: Colors.grey,
      //       ),
      //       child: Row(
      //         children: [
      //           SizedBox(width: 10,),
      //           Container(
      //             height: 50,
      //             width: 50,
      //             decoration: BoxDecoration(
      //                 image: DecorationImage(image: NetworkImage(widget.orderModels.itemImage!),fit: BoxFit.fill)
      //             ),
      //           ),
      //           SizedBox(width: 20,),
      //
      //           Text(widget.orderModels.item!),
      //           SizedBox(width: 50,),
      //
      //           Text(widget.orderModels.count!.toString()),
      //           SizedBox(width: 35,),
      //
      //           Text(widget.orderModels.amount!.toString()),
      //         ],
      //       ),
      //     ),
      //     SizedBox(
      //       height: 300,
      //     ),
      //     Text("Total Price:"),
      //
      //     ElevatedButton(
      //         onPressed: (){
      //           FirebaseFirestore
      //               .instance
      //               .collection('stores')
      //               .doc(widget.orderModels.storeId)
      //               .collection('orders').doc(widget.orderModels.orderId).update({
      //             'status':3
      //           });
      //         } ,
      //         child:Text("cancelled"))
      //   ],
      // ),
    );
  }
}
