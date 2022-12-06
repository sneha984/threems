// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:threems/model/OrderModel.dart';
//
// import '../../screens/splash_screen.dart';
//
// class AcceptedPage extends StatefulWidget {
//   final OrderModel orderMdl;
//   const AcceptedPage({Key? key, required this.orderMdl}) : super(key: key);
//
//   @override
//   State<AcceptedPage> createState() => _AcceptedPageState();
// }
//
// class _AcceptedPageState extends State<AcceptedPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       appBar: AppBar(
//         toolbarHeight: 84,
//         shadowColor: Colors.grey,
//         centerTitle: false,
//         elevation: 0.1,
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: EdgeInsets.only(
//                 top: scrHeight * 0.03,
//                 left: scrWidth * 0.05,
//                 bottom: scrHeight * 0.01,
//                 right: scrWidth * 0.05),
//             child: SvgPicture.asset(
//               "assets/icons/arrow.svg",
//             ),
//           ),
//         ),
//         title: Padding(
//           padding: EdgeInsets.only(top: scrHeight * 0.02),
//           child: Text(
//             "Orders",
//             style: TextStyle(
//                 fontSize: scrWidth * 0.047,
//                 color: Colors.black,
//                 fontFamily: 'Urbanist',
//                 fontWeight: FontWeight.w700),
//           ),
//         ),
//
//       ),
//       body:Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
//             child: InkWell(
//               onTap: (){
//               },
//               child: Container(
//                 height: 100,
//                 width: 360,
//                 decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(30)
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20,top: 15),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Customer Name:${widget.orderMdl.address?.name??''}"),
//                       SizedBox(height: 5,),
//                       Text("Delivery Location: Flat No ${widget.orderMdl.address?.flatNo??''},"
//                           "${widget.orderMdl.address?.locality??''},"
//                           "${widget.orderMdl.address?.pincode??''},"
//                           "${widget.orderMdl.address?.locationType??''}}"),
//                       SizedBox(height: 5,),
//                       Text("Phone Number:${widget.orderMdl.address?.phoneNumber??''}"),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20,),
//           Container(
//             height: 70,
//             width: 325,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: Colors.grey,
//             ),
//             child: Row(
//               children: [
//                 SizedBox(width: 10,),
//                 Container(
//                   height: 50,
//                   width: 50,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(image: NetworkImage(widget.orderMdl.itemImage!),fit: BoxFit.fill)
//                   ),
//                 ),
//                 SizedBox(width: 20,),
//
//                 Text(widget.orderMdl.item!),
//                 SizedBox(width: 50,),
//
//                 Text(widget.orderMdl.count!.toString()),
//                 SizedBox(width: 35,),
//
//                 Text(widget.orderMdl.amount!.toString()),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 300,
//           ),
//           Text("Total Price:"),
//
//           ElevatedButton(
//               onPressed: (){
//                 FirebaseFirestore
//                     .instance
//                     .collection('stores')
//                     .doc(widget.orderMdl.storeId)
//                     .collection('orders').doc(widget.orderMdl.orderId).update({
//                   'status':2
//                 });
//               } ,
//               child:Text("Mark as Delivered"))
//         ],
//       ),
//     );
//   }
// }
