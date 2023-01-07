import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Buy&sell/reportBottomsheet/bottomsheetReport.dart';
import 'package:threems/Buy&sell/storepage.dart';

import '../Authentication/root.dart';
import '../model/Buy&sell.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'buy_and_sell.dart';

class NearestStoreDetailPage extends StatefulWidget {
  final StoreDetailsModel storeDetailsModel;
  final String category;
  final List cate;
  const NearestStoreDetailPage({Key? key, required this.storeDetailsModel, required this.category, required this.cate}) : super(key: key);

  @override
  State<NearestStoreDetailPage> createState() => _NearestStoreDetailPageState();
}

class _NearestStoreDetailPageState extends State<NearestStoreDetailPage> {
  int isClicked=0;

  Stream<List<ProductModel>> getProductByCategory(String category) => FirebaseFirestore.instance
      .collection('stores')
      .doc(widget.storeDetailsModel.storeId)
      .collection('products')
      .where('storedCategorys', isEqualTo: category)
      .where('delete',isEqualTo: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => ProductModel.fromJson(doc.data()))
      .toList());


  bool _customTileExpanded = false;


  getProducts() {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDetailsModel.storeId)
        .snapshots()
        .listen((event) {

      shopAvailable=event['online'];
      if(mounted){
        setState(() {

        });
      }
    });
    if (widget.category == '') {
      FirebaseFirestore.instance
          .collection('stores')
          .doc(widget.storeDetailsModel.storeId)
          .collection('products')
          .where('delete', isEqualTo: false)
          .snapshots()
          .listen((event) {
        productsList = [];
        for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
          productsList.add(ProductModel.fromJson(doc.data()!));
        }
        if (mounted) {
          setState(() {});
        }

      });
    } else if (widget.category != '') {
      FirebaseFirestore.instance
          .collection('stores')
          .doc(widget.storeDetailsModel.storeId)
          .collection('products')
          .where('storedCategorys', isEqualTo: widget.storeDetailsModel.storeCategory)
          .where('delete',isEqualTo: false)
      // .where('available', isEqualTo: true)
          .snapshots()
          .listen((event) {
        productsList = [];
        for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
          productsList.add(ProductModel.fromJson(doc.data()!));
        }
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  List bags = [];
  getbag() {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDetailsModel.storeId)
        .collection('products')
        .where('storedCategorys', isEqualTo: widget.storeDetailsModel.storeCategory)
        .where('delete',isEqualTo: false)
        .snapshots()
        .listen((event) {
          bags=[];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        bags.add(doc.data());

        // bags[doc.get('productId')] = doc.data();
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );

  bool isVisible = false;
  int qty = 1;
  int? currentQty;
  bool _loadingButton = false;
  bool pressed = false;
  bool shopAvailable = false;

  // int count=1;
  // int counter=1;
  //
  // List _selectedIndexs=[];
  // void _decrement(){
  //   setState(() {
  //     if(count!=0){
  //       count--;
  //     }
  //
  //   });
  // }
  // void _increment(){
  //   setState(() {
  //     count++;
  //   });
  // }
  @override
  void initState() {
    getProducts();
    getbag();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics:  BouncingScrollPhysics(),
        child: Column(
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: scrWidth * 0.06,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: scrHeight * 0.086,
                        // left: scrWidth * 0.05,
                        // bottom: scrHeight * 0.06,
                        right: scrWidth * 0.02),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width: scrWidth * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: scrHeight * 0.087,
                  ),
                  child: Container(
                    width: scrWidth*0.34,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.storeDetailsModel.storeName!,
                          style: TextStyle(
                              fontSize: scrWidth * 0.048,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                        // SizedBox(
                        //   height: scrHeight * 0.01,
                        // ),
                        // Text(
                        // productsList[0].storedCategorys!,
                        //   style: TextStyle(
                        //       fontSize: scrWidth * 0.03,
                        //       color: Color(0xff818181),
                        //       fontFamily: 'Urbanist',
                        //       fontWeight: FontWeight.w500),
                        // ),
                        SizedBox(
                          height: scrHeight * 0.002,
                        ),

                        Text(
                          widget.storeDetailsModel.storeAddress!,
                          style: TextStyle(
                              fontSize: scrWidth * 0.03,
                              color: const Color(0xff818181),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: scrHeight * 0.002,
                        ),
                        Text(
                          shopAvailable?'Available':'Closed',
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              color: shopAvailable?primarycolor: Colors.red,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500),
                        ),

                        // Container(
                        //   width:scrWidth*0.5,
                        //   height: scrHeight*0.031,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(scrWidth*0.02),
                        //     color: primarycolor
                        //   ),
                        //   child: Center(
                        //     child: Text("Visit Store in Map",style: TextStyle(
                        //       fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: scrWidth*0.027,color: Colors.white
                        //     ),),
                        //   ),
                        //
                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: scrWidth * 0.17,
                ),
                Column(
                  children: [
                    SizedBox(height: scrHeight*0.04,),
                    Padding(
                      padding:  EdgeInsets.only(left: scrWidth*0.1,),
                      child: PopupMenuButton<MenuItem>(
                        constraints: BoxConstraints(
                            maxWidth: 100,
                            minWidth: 100,
                            maxHeight: 50,
                            minHeight: 50),
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
                                  _modalBottomSheetMenu();

                                  // Navigator.push(context, MaterialPageRoute
                                  //   (builder: (context)=>ProductEditPage(storeId: widget.storeId,
                                  //   productModel: getAllProducts[index],update: true,)));
                                },
                                child: Container(
                                  height: 50,width: 100,
                                  child: Center(
                                    child: Padding(
                                      padding:  EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        "Report",
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
                          ),

                        ],
                      ),
                    ),
                    Container(
                      height: scrHeight * 0.11,
                      width: scrWidth * 0.26,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              widget.storeDetailsModel.storeImage ?? ''),
                          fit: BoxFit.fill,colorFilter:  shopAvailable?
                        ColorFilter.mode(Colors.transparent, BlendMode.saturation):
                        ColorFilter.mode(Colors.grey, BlendMode.saturation),),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(scrWidth * 0.04),
                      ),
                      // child: ClipRRect(
                      //   borderRadius: BorderRadius.circular(scrWidth * 0.09),
                      //   child: CachedNetworkImage(
                      //     fit: BoxFit.cover,
                      //     imageUrl: widget.storeDetailsModel.storeImage ?? '',
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: scrHeight * 0.015, left: scrWidth * 0.02),
              child: Container(
                height: scrHeight * 0.02,
                width: scrWidth * 0.92,
                decoration: BoxDecoration(
                    color: const Color(0xffE9EEF3),
                    borderRadius: BorderRadius.circular(scrWidth * 0.02)),
              ),
            ),
            SizedBox(
              height: scrHeight * 0.02,
            ),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: scrWidth * 0.07,
                    ),
                    SvgPicture.asset("assets/icons/staricon.svg"),
                    SizedBox(
                      width: scrWidth * 0.03,
                    ),
                    Text(
                      "Featured Product",
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: scrWidth * 0.04,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                SizedBox(width: 120,),
                // IconButton(onPressed: (){
                //
                // }, icon: Icon(Icons.filter))
              ],
            ),
            // Container(
            //   height: 400,
            //   child: ListView.builder(
            //     itemCount: widget.storeDetailsModel.storeCategory!.length,
            //       itemBuilder: (context,index){
            //     return Container(
            //       color: Colors.red,
            //       height: 200,width: 40,
            //       child: Column(
            //         children: [
            //           Text(widget.storeDetailsModel.storeCategory![index]),
            //           Container(
            //             color: Colors.blue,
            //             height: 300,
            //             child: ListView.builder(
            //               itemCount: bags.length,
            //                 itemBuilder: (context,index){
            //                 return Container(
            //                   height: 200,
            //                   color: Colors.green,
            //                   child: Column(
            //                     children: [
            //                       Text(bags[index].productName!),
            //                       Text(bags[index].price!.toString())
            //                     ],
            //                   ),
            //                 );
            //
            //             }),
            //           )
            //         ],
            //       ),
            //     );
            //   }),
            // ),

            ///////////////////////////////=========1st Model==============//////////////////////////////
            // Container(
            //   // color: Colors.blue,
            //   height: 600,
            //   child: GridView.builder(
            //     physics: const BouncingScrollPhysics(),
            //     padding: EdgeInsets.all(10),
            //     shrinkWrap: true,
            //     itemCount: productsList.length,
            //     itemBuilder: (context, index) {
            //       final products = productsList[index];
            //
            //       // final _isSelected=_selectedIndexs.contains(index);
            //       return ShopSingleProduct(
            //           product: products,
            //           storeId: widget.storeDetailsModel.storeId!,
            //           deliveryCharge: widget.storeDetailsModel.deliveryCharge!,
            //           storeavailable:shopAvailable
            //       );
            //     },
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,
            //       childAspectRatio: 0.6,
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 20,
            //     ),
            //   ),
            // ),
            ///////////////////////////////=========1st Model==============//////////////////////////////


//             Container(
//               height: 300,
//               child: ListView.builder(
//                 itemCount: itemsCategory.length,
//                 itemBuilder: (context, i) {
//                   return ExpansionTile(
//                     onExpansionChanged: (bool expanded) {
//                       setState(() => _customTileExpanded = expanded);
//                     },
//                     trailing: Icon(_customTileExpanded
//                         ?Icons.arrow_drop_up
//                         : Icons.arrow_drop_down,color: Colors.black,),
//                     title: Text(itemsCategory[i].categoryname,
//                       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,fontFamily: 'Urbanist',color: Colors.black),),
//                     children: <Widget>[
//                       Container(
//                           height: 400,
//                           child:GridView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount:itemsCategory[i].categoryitems.length,
//                             gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
//                                 childAspectRatio: 3 / 5,
//                                 crossAxisSpacing: 2,
//                                 mainAxisSpacing: 20,
//                                 crossAxisCount: 3
//                             ), itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding:  EdgeInsets.only(right: 10,top: 10),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InkWell(
//                                     onTap: (){
//                                       // Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckOutPage()));
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10),
//                                       child: Container(
//                                         padding: EdgeInsets.only(left: 10,right: 10),
//                                         height: 90,
//                                         width: 95,
//                                         decoration: BoxDecoration(
//                                             image: DecorationImage(
//                                                 image: NetworkImage(itemsCategory[i].categoryitems[index]['image'])),
//                                             color: Colors.white,
//                                             borderRadius: BorderRadius
//                                                 .circular(15),
//                                             border: Border.all(
//                                                 color: Color(0xffECECEC),
//                                                 width: 1)
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 20),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment
//                                           .start,
//                                       children: [
//                                         SizedBox(height: 5,),
//                                         Text(
//                                           itemsCategory[i].categoryitems[index]['name'], textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontFamily: 'Urbanist',
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xff0E0E0E)),),
//                                         SizedBox(height: 3,),
//
//                                         Text(
//                                           itemsCategory[i].categoryitems[index]['unit'], textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontFamily: 'Urbanist',
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xff818181)),),
//                                         SizedBox(height: 3,),
//
//                                         Text(
//                                           itemsCategory[i].categoryitems[index]['price'].toString(), textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontFamily: 'Urbanist',
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w700,
//                                               color: Color(0xffF10000)),),
//                                         SizedBox(height: 3,),
//                                       ],
//                                     ),
//                                   ),
// //=========================//
//                          itemsCategory[i].categoryitems[index]['ShouldVisible']?
//                         Padding(padding: EdgeInsets.only(left: 7),
//                           child: InkWell(
//                             onTap: (){
//                               final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
//                               print("index" +findIndex.toString());
//                               if(findIndex>=0) {
//                                 setState(() {
//                                   cartlist[findIndex]['quantity'] =itemsCategory[i].categoryitems[index]['counter'] ;
//                                 });
//                               }else {
//                                 cartlist.add({
//                                   'img': itemsCategory[i].categoryitems[index]['image'],
//                                   'name': itemsCategory[i].categoryitems[index]['name'],
//                                   'price': itemsCategory[i].categoryitems[index]['price'],
//                                   'quantity':itemsCategory[i].categoryitems[index]['counter'],
//                                 });
//                               }
//                               print(cartlist);
//                               final snackBar = SnackBar(
//                                 backgroundColor: Colors.white,
//                                 content: const Text(' item added to cart',
//                                   style: TextStyle(color: Colors.black),),
//                                 action: SnackBarAction(
//
//                                   textColor: Colors.blue,
//                                   label: 'Go To Cart',
//                                   onPressed: () {
//                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//
//
//
//                                     // Some code to undo the change.
//                                   },
//                                 ),
//                               );
//                               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//
//
//                             },
//                             child: Container(
//                               width: 99,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: Color(0xff02B558)
//                                 // color: Colors.red
//                               ),
//                               child: Row(
//                                 children: [
//                                   InkWell(
//                                     onTap: (){
//                                       setState(() {
//                                         if(itemsCategory[i].categoryitems[index]['counter'] <2)
//                                         {
//                                           itemsCategory[i].categoryitems[index]['ShouldVisible']= ! itemsCategory[i].categoryitems[index]['ShouldVisible'];
//                                         }else{
//                                           itemsCategory[i].categoryitems[index]['counter']--;
//                                         }
//
//                                       });
//                                       final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
//                                       print("index" +findIndex.toString());
//                                       if(findIndex>=0) {
//                                         setState(() {
//                                           cartlist[findIndex]['quantity'] =itemsCategory[i].categoryitems[index]['counter'] ;
//                                         });
//                                       }else {
//                                         cartlist.add({
//                                           'img': itemsCategory[i].categoryitems[index]['image'],
//                                           'name': itemsCategory[i].categoryitems[index]['name'],
//                                           'price': itemsCategory[i].categoryitems[index]['price'],
//                                           'quantity':itemsCategory[i].categoryitems[index]['counter'],
//                                         });
//                                       }
//                                       print(cartlist);
//                                       final snackBar = SnackBar(
//                                         backgroundColor: Colors.white,
//                                         content: const Text(' item added to cart',
//                                           style: TextStyle(color: Colors.black),),
//                                         action: SnackBarAction(
//
//                                           textColor: Colors.blue,
//                                           label: 'Go To Cart',
//                                           onPressed: () {
//                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//
//
//
//                                             // Some code to undo the change.
//                                           },
//                                         ),
//                                       );
//                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                     },
//                                     child: Container(
//                                       height: 30,
//                                       width: 32,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xff02B558),
//                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
//                                               bottomLeft:Radius.circular(8) )),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(bottom: 8),
//                                         child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,),
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 30,
//                                     width: 30,
//                                     decoration: BoxDecoration(
//                                       color: Color(0xff9FFFCD),
//                                     ),
//                                     child: Center(child: Text('${ itemsCategory[i].categoryitems[index]['counter']}')),
//                                   ),
//                                   InkWell(
//                                     onTap: (){
//                                       setState(() {
//                                         itemsCategory[i].categoryitems[index]['counter']++;
//                                       });
//                                       final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
//                                       print("index" +findIndex.toString());
//                                       if(findIndex>=0) {
//                                         setState(() {
//                                           cartlist[findIndex]['quantity'] =itemsCategory[i].categoryitems[index]['counter'] ;
//                                         });
//                                       }else {
//                                         cartlist.add({
//                                           'img': itemsCategory[i].categoryitems[index]['image'],
//                                           'name': itemsCategory[i].categoryitems[index]['name'],
//                                           'price': itemsCategory[i].categoryitems[index]['price'],
//                                           'quantity':itemsCategory[i].categoryitems[index]['counter'],
//                                         });
//                                       }
//                                       print(cartlist);
//                                       final snackBar = SnackBar(
//                                         backgroundColor: Colors.white,
//                                         content: const Text(' item added to cart',
//                                           style: TextStyle(color: Colors.black),),
//                                         action: SnackBarAction(
//
//                                           textColor: Colors.blue,
//                                           label: 'Go To Cart',
//                                           onPressed: () {
//                                             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//
//
//
//                                             // Some code to undo the change.
//                                           },
//                                         ),
//                                       );
//                                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                     },
//                                     child: Container(
//                                       height: 26,
//                                       width: 30,
//                                       decoration: BoxDecoration(
//                                           color: Color(0xff02B558),
//                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
//                                               bottomLeft:Radius.circular(8) )
//
//                                       ),
//                                       child: Padding(
//                                         padding: EdgeInsets.only(left: 5),
//                                         child: Icon(Icons.add,size: 15,color: Colors.white,),
//                                       ),
//                                     ),
//                                   ),
//
//                                 ],
//                               ),
//
//                             ),
//                           ),
//                         ):
//                         Padding(
//                           padding:  EdgeInsets.only(left: 7),
//                           child:  InkWell(
//                             onTap: (){
//                               setState(() {
//                                 itemsCategory[i].categoryitems[index]['ShouldVisible']=! itemsCategory[i].categoryitems[index]['ShouldVisible'];
//                               });
//                               final findIndex=cartlist.indexWhere((element) => element['name'] ==itemsCategory[i].categoryitems[index]['name']);
//                               print("index" +findIndex.toString());
//                               if(findIndex>=0) {
//                                 setState(() {
//                                   cartlist[findIndex]['quantity'] = itemsCategory[i].categoryitems[index]['counter'];
//                                 });
//                               }else {
//                                 cartlist.add({
//                                   'img': itemsCategory[i].categoryitems[index]['image'],
//                                   'name': itemsCategory[i].categoryitems[index]['name'],
//                                   'price': itemsCategory[i].categoryitems[index]['price'],
//                                   'unit':itemsCategory[i].categoryitems[index]['unit'],
//                                   'quantity':itemsCategory[i].categoryitems[index]['counter'],
//                                 });
//                               }
//                               print(cartlist);
//                               final snackBar = SnackBar(
//                                 backgroundColor: Colors.white,
//                                 content: const Text(' item added to cart',
//                                   style: TextStyle(color: Colors.black),),
//                                 action: SnackBarAction(
//
//                                   textColor: Colors.blue,
//                                   label: 'Go To Cart',
//                                   onPressed: () {
//                                     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
//                                     // Some code to undo the change.
//                                   },
//                                 ),
//                               );
//                               ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                             },
//                             child: Container(
//                               width: 99,
//                               height: 30,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: Color(0xff02B558)
//                                 // color: Colors.red
//                               ),
//                               child: Center(
//                                 child: Text("Add",style: TextStyle(
//                                     fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
//                                 ),),
//                               ),
//                             ),
//                           ),
//
//                         ),
// //=========================//
//
// // Padding(
// //   padding: EdgeInsets.only(left: 7),
// //   child: InkWell(
// //     onTap: (){
// //       // setState((){
// //       // if(_isSelected){
// //       // _selectedIndexs.remove(index);
// //       //
// //       // }else{
// //       // _selectedIndexs.add(index);
// //       //
// //       // }
// //       // });
// //
// //       final findIndex=cartList.indexWhere((element) => element['name']==eachstore[index].productname);
// //       print("index" +findIndex.toString());
// //       if(findIndex>=0){
// //         setState(() {
// //           cartList[findIndex]['quantity'] =eachstore[index].counter;
// //         });
// //       }else{
// //         cartList.add({
// //           'name':eachstore[index].productname,
// //           'image':eachstore[index].productimage,
// //           'unit':eachstore[index].productunit,
// //           'price':eachstore[index].productprice,
// //           'quantity':eachstore[index].counter,
// //         });
// //       }
// //       print(eachstore[index].counter);
// //       print(cartList);
// //       final snackBar = SnackBar(
// //         backgroundColor: Colors.green,
// //         content:  Text('${eachstore[index].counter} ${eachstore[index].productname} added to cart',
// //           style: TextStyle(color: Colors.white),),
// //         action: SnackBarAction(
// //           textColor: Colors.white,
// //           label: 'Go To Cart',
// //           onPressed: () {
// //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
// //             // Some code to undo the change.
// //           },
// //         ),
// //       );
// //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //
// //     },
// //     child:Container(
// //       width: 126,
// //       height: 30,
// //       decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(8),
// //           color: Color(0xff02B558)
// //         // color: Colors.red
// //       ),
// //       child:eachstore[index].ShouldVisible?
// //       Row(
// //         children: [
// //           Container(
// //             height: 30,
// //             width: 45,
// //             decoration: BoxDecoration(
// //                 color: Color(0xff02B558),
// //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
// //                     bottomLeft:Radius.circular(8) )
// //
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.only(bottom: 8),
// //               child: InkWell(
// //                   onTap:(){
// //                     setState(() {
// //                       if(eachstore[index].counter <2)
// //                       {
// //                         eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
// //                       }else{
// //                         eachstore[index].counter--;
// //                       }
// //
// //                     });
// //                   },
// //                   child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,)),
// //             ),
// //           ),
// //           Container(
// //             height: 30,
// //             width: 36,
// //             decoration: BoxDecoration(
// //               color: Color(0xff9FFFCD),
// //             ),
// //             child: Center(child: InkWell(
// //               onTap: (){
// //
// //               },
// //                 child: Text(eachstore[index].counter.toString()))),
// //           ),
// //           Container(
// //             height: 26,
// //             width: 30,
// //             decoration: BoxDecoration(
// //                 color: Color(0xff02B558),
// //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
// //                     bottomLeft:Radius.circular(8) )
// //
// //             ),
// //             child: InkWell(
// //                 onTap:(){
// //                   setState(() {
// //                     eachstore[index].counter++;
// //                   });
// //                 },
// //                 child: Padding(
// //                   padding: EdgeInsets.only(left: 5),
// //                   child: Icon(Icons.add,size: 15,color: Colors.white,),
// //                 )),
// //           ),
// //         ],
// //       )
// //       : InkWell(
// //         onTap: (){
// //           setState(() {
// //             eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
// //           });
// //         },
// //         child: Container(
// //           width: 126,
// //           height: 30,
// //           decoration: BoxDecoration(
// //               borderRadius: BorderRadius.circular(8),
// //               color: Color(0xff02B558)
// //             // color: Colors.red
// //           ),
// //           child: Center(
// //             child: Text("Add",style: TextStyle(
// //             fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
// //             ),),
// //           ),
// //         ),
// //       )
// //     ),
// //   ),
// //   ),
//                                 ],
//                               ),
//                             );
//
//                           },)
//
//                         // Row(
//                         //   children: [
//                         //     Text(vehicles[i].contents[0]['image']),
//                         //     Text(vehicles[i].contents[0]['price'].toString()),
//                         //
//                         //
//                         //   ],
//                         // ),
//                       )
//                     ],
//                   );
//                 },
//               ),
//             ),
            Container(

              child: ListView.builder(
                itemCount: widget.storeDetailsModel.storeCategory!.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title:  Text(widget.storeDetailsModel.storeCategory![index]),
                    // subtitle: const Text('Custom expansion arrow icon'),
                    trailing: Icon(
                      _customTileExpanded
                          ? Icons.arrow_drop_down_circle
                          : Icons.arrow_drop_down,
                    ),
                    children:  <Widget>[
                      Container(
                        child: StreamBuilder<List<ProductModel>>(
                          stream:getProductByCategory(widget.storeDetailsModel.storeCategory![index]),
                          builder: (context, snapshot) {

                            if(!snapshot.hasData||snapshot.hasError){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            return GridView.builder(
                              itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                 physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20,),
                                itemBuilder: (BuildContext context, int index){
                                  var data=snapshot.data![index];
                                 return  Padding(
                                   padding:  EdgeInsets.only(top: 20,left: 20),
                                   child: ShopSingleProduct(
                                       product: data,
                                       storeId: widget.storeDetailsModel.storeId!,
                                       deliveryCharge: widget.storeDetailsModel.deliveryCharge!,
                                       storeavailable:shopAvailable
                                   ),
                                 );
                                }
                                );
                          }
                        ),
                      ),
                    ],
                    onExpansionChanged: (bool expanded) {
                      setState(() => _customTileExpanded = expanded);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        // ),
        builder: (BuildContext context) {
          // return your layout

          return  BottomSheetReport(storeDetailsModel: widget.storeDetailsModel, category: '', cate: widget.cate,);
        }
    );
  }

}
