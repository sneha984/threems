import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/screens/splash_screen.dart';
import 'dart:io';

import '../../model/service category.dart';
import '../../utils/themes.dart';
import 'details.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
  List iconDatas = [
    Icon(Icons.carpenter_outlined),
    Icon(Icons.plumbing),
    Icon(Icons.drive_eta_rounded),
    Icon(Icons.electrical_services),
  ];
  List<ServiceCategory>? categories;

  getCategory() {
    FirebaseFirestore.instance
        .collection('serviceCategory')
        .snapshots()
        .listen((event) {
      categories = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        categories!.add(ServiceCategory.fromJson(doc.data()!));
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 40,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,

        title: Text(
          " Utilities",
          style: TextStyle(
              fontSize: scrWidth * 0.046,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 18.0),
        //     child: Icon(Icons.)
        //     // SvgPicture.asset('assets/images/expense tracker.svg',height: 35,width: 35,),
        //   )
        // ],
      ),
      body: categories == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: categories!.length,
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ServiceDetailsPage(
                                            category: categories![index]
                                                .serviceCategory!,
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],
                                color: Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.10,
                                      width: MediaQuery.of(context).size.width *
                                          0.30,
                                      child: Icon(
                                        Icons.handyman,
                                        size: 40,
                                        color: primarycolor,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    categories![index].serviceCategory!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        // children: [
                        //
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddBatch()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/batch.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'BATCH',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddProduct()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/product.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'PRODUCT',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddProductGroup()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/productgroup.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'PRODUCT GROUP',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(context,
                        //   //         MaterialPageRoute(builder: (context) => AddUnit()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/unit.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'UNIT',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddBranch()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/branch.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'BRANCH',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddSupplier()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         SizedBox(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/supplier.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'SUPPLIER',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddCustomer()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/customer.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'CUSTOMER',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => PurchaseHome()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/purchase.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'PURCHASE',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddSales()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/sales.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'SALES',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddSalesMan()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/salesman.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Text(
                        //   //           'SALESMAN',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         )
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(context,
                        //   //         MaterialPageRoute(builder: (context) => Stock()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/packages.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Center(
                        //   //             child: Text(
                        //   //           'STOCK',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         ))
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddReceipt()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/receipt.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Center(
                        //   //             child: Text(
                        //   //           'RECEIPT',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         ))
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // InkWell(
                        //   //   onTap: () {
                        //   //     Navigator.push(
                        //   //         context,
                        //   //         MaterialPageRoute(
                        //   //             builder: (context) => AddPayment()));
                        //   //   },
                        //   //   child: Container(
                        //   //     decoration: BoxDecoration(
                        //   //       borderRadius: BorderRadius.circular(8),
                        //   //       boxShadow: [
                        //   //         BoxShadow(
                        //   //           color: Colors.grey,
                        //   //           blurRadius: 5.0,
                        //   //         ),
                        //   //       ],
                        //   //       color: Colors.white,
                        //   //     ),
                        //   //     child: Column(
                        //   //       mainAxisAlignment: MainAxisAlignment.center,
                        //   //       children: [
                        //   //         Container(
                        //   //             height:
                        //   //                 MediaQuery.of(context).size.height * 0.10,
                        //   //             width: MediaQuery.of(context).size.width * 0.30,
                        //   //             child: Image.asset(
                        //   //               'assets/images/payment-method.png',
                        //   //             )),
                        //   //         SizedBox(
                        //   //           height: 5,
                        //   //         ),
                        //   //         Center(
                        //   //             child: Text(
                        //   //           'PAYMENT',
                        //   //           style: TextStyle(fontWeight: FontWeight.bold),
                        //   //         ))
                        //   //       ],
                        //   //     ),
                        //   //   ),
                        //   // ),
                        //   // Container(),
                        //   // Container(),
                        // ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
