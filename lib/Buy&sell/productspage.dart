import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/buy_and_sell.dart';
import 'package:threems/Buy&sell/productaddingpage.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';
import 'package:threems/model/Buy&sell.dart';
import 'package:threems/products/producteditpage.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class ProductsPage extends StatefulWidget {
  final String storeId;
  const ProductsPage({Key? key, required this.storeId,}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductModel? prodct;
  List getAllProducts=[];
  getProductsAll(){
    FirebaseFirestore
        .instance
        .collection('stores')
        .doc(widget.storeId)
        .collection('products')
        .snapshots()
        .listen((event) {
          getAllProducts=[];
          for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
            getAllProducts.add(doc.data()!);
          }
          if(mounted){
            setState(() {

            });
          }

    });

  }

  @override
  void initState() {
    getProductsAll();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
       appBar: AppBar(
      toolbarHeight: 0,
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
      // AppBar(
      //   toolbarHeight: 84,
      //   shadowColor: Colors.grey,
      //   centerTitle: false,
      //   elevation: 0.1,
      //   backgroundColor: Colors.white,
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(
      //           top: scrHeight * 0.03,
      //           left: scrWidth * 0.05,
      //           bottom: scrHeight * 0.01,
      //           right: scrWidth * 0.05),
      //       child: SvgPicture.asset(
      //         "assets/icons/arrow.svg",
      //       ),
      //     ),
      //   ),
      //   title: Padding(
      //     padding: EdgeInsets.only(top: scrHeight * 0.02),
      //     child: Text(
      //       "Products",
      //       style: TextStyle(
      //           fontSize: scrWidth * 0.047,
      //           color: Colors.black,
      //           fontFamily: 'Urbanist',
      //           fontWeight: FontWeight.w700),
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(
      //           right: scrWidth * 0.04,
      //           top: scrHeight * 0.045,
      //           bottom: scrHeight * 0.025),
      //       child: InkWell(
      //         onTap: () {
      //            Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => ProductAddingPage(storeId: widget.storeId)));
      //         },
      //         child: Container(
      //           height: scrHeight * 0.07,
      //           width: scrWidth * 0.25,
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(scrWidth * 0.04),
      //             color: primarycolor,
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               const Icon(
      //                 Icons.add,
      //                 size: 12,
      //                 color: Colors.white,
      //               ),
      //               Text(
      //                 "Product",
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: CreateChitFont,
      //                     fontFamily: 'Urbanist',
      //                     fontWeight: FontWeight.w700),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xff008036),
              width: scrWidth,
              height: scrHeight * 0.07,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.055),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                            child: Container(
                                width:20,height:20,child: SvgPicture.asset('assets/icons/back.svg',color: Colors.white,))),
                        SizedBox(
                          width: scrWidth * 0.039,
                        ),
                        Text(
                          "Your Products",
                          style: GoogleFonts.urbanist(
                              fontWeight: FontWeight.w500,
                              fontSize: scrWidth * 0.045,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProductAddingPage(update: false,
                          storeId: widget.storeId,
                          productModel: prodct,)));

                      },
                      child: Container(
                        width: scrWidth * 0.28,
                        height: scrWidth * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(scrWidth * 0.045),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "+ Add new",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w500,
                                fontSize: scrWidth * 0.045,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 700,
              child: ListView.builder(
                itemCount:getAllProducts.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 15),
                      child: Container(
                        width:400,
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 10),
                              child: Container(
                                height: scrWidth * 0.2,
                                width: scrWidth * 0.2,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.pink.withOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(scrWidth * 0.025),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: CachedNetworkImage(imageUrl: getAllProducts[index]['images'][0]??'')),
                                ),
                            ),

                            SizedBox(
                              width: scrWidth * 0.05,
                            ),
                            Container(
                              width:200,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 14,),

                                          Text(
                                            getAllProducts[index]['productName'],
                                            style: GoogleFonts.urbanist(
                                                fontSize: scrWidth * 0.039, fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5,),

                                          Text(
                                            "${getAllProducts[index]['quantity']} ${products[index]['unit']}",
                                            style: GoogleFonts.urbanist(
                                                fontSize: scrWidth * 0.03,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xff818181)),
                                          )
                                        ],
                                      ),

                                      // Container(
                                      //   padding: const EdgeInsets.all(6),
                                      //   width: size24,
                                      //   height: size24,
                                      //   child: SvgPicture.asset('assets/svg/more_ver.svg'),
                                      // ),
                                    SizedBox(width: 16,),
                                      PopupMenuButton<MenuItem>(
                                        constraints: BoxConstraints(
                                            maxWidth: 100,
                                            minWidth: 100,
                                            maxHeight: 200,
                                            minHeight: 100),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                        position: PopupMenuPosition.under,
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            height: 30,
                                            child: Center(
                                              child: InkWell(
                                                onTap: (){
                                                  // print(prodct!.productName);
                                                  Navigator.pop(context);
                                                  Navigator.push(context, MaterialPageRoute
                                                    (builder: (context)=>ProductEditPage(storeId: widget.storeId,
                                                    productModel: getAllProducts[index],update: true,)));
                                                },
                                                child: Container(
                                                  height: 50,width: 100,
                                                  child: Center(
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: scrWidth * 0.035,
                                                        fontFamily: "Urbanist",
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            height: 30,
                                            child: InkWell(
                                              onTap: (){
                                                Navigator.pop(context);
                                                FirebaseFirestore
                                                    .instance
                                                    .collection('stores')
                                                    .doc(widget.storeId)
                                                    .collection('products')
                                                    .doc(getAllProducts[index]['productId'])
                                                    .delete().whenComplete(() => Navigator.pop(context));
                                              },
                                              child: Container(
                                                height: 50,width: 100,
                                                child: Center(
                                                  child: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: scrWidth * 0.035,
                                                      fontFamily: "Urbanist",
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "₹${getAllProducts[index]['price']}",
                                        style: GoogleFonts.urbanist(
                                            fontSize: scrWidth * 0.03,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.red),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            getAllProducts[index]!['available'] ? "(in stock)" : "(out of stock)",
                                            style: GoogleFonts.urbanist(
                                                fontSize: scrWidth * 0.025, fontWeight: FontWeight.w600),
                                          ),
                                          Transform.scale(
                                            scale: 0.7,
                                            child: CupertinoSwitch(
                                              thumbColor: getAllProducts[index]['available']
                                                  ? Color(0xff02B558)
                                                  : Color(0xffE54D3C),
                                              activeColor: Color(0xffD9D9D9),
                                              trackColor: Color(0xffD9D9D9),
                                              value: getAllProducts[index]['available'],
                                              onChanged: (value) {
                                                print(widget.storeId);

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('stores')
                                                            .doc(widget.storeId)
                                                            .collection('products')
                                                            .doc(getAllProducts[index]['productId'])
                                                            .update(
                                                          {
                                                          'available':!getAllProducts[index]['available']
                                                          }
                                                        );
                                                        setState(() {

                                                        });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),


          ],
        ),
      ),

    );
  }
}
