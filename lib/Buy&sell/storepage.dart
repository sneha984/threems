import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Buy&sell/reportBottomsheet/BottonSheet.dart';
import 'package:threems/utils/themes.dart';

import '../Authentication/root.dart';
import '../model/Buy&sell.dart';
import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
import 'checkout.dart';
import 'imagezoom.dart';

List cartlist = [];
List<ProductModel> productsList = [];

class StorePage extends StatefulWidget {
  final StoreDetailsModel storeDetailsModel;
  final String category;

  const StorePage(
      {Key? key, required this.storeDetailsModel, required this.category,})
      : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

// class Items{
//   final String categoryname;
//   List<Map<String,dynamic>> categoryitems;
//   Items(
//       this.categoryname, this.categoryitems,
//       );
// }
class _StorePageState extends State<StorePage> {
  final FocusNode reasonFocusNode=FocusNode();
  final TextEditingController reasonController = TextEditingController();
  List reasons=[];
  String settingsid='settings';
  bool isSelect=false;

  getReasons() async {
   DocumentSnapshot doc=await FirebaseFirestore.instance.collection('settings').doc(settingsid).get();
   reasons=doc['reportReasons'];

   if(mounted){
     setState(() {

     });
   }
  }



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
          .where('storedCategorys', isEqualTo: widget.category)
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

  Map<String, dynamic> bags = {};
  getbag() {
    FirebaseFirestore.instance
        .collection('stores')
        .doc(widget.storeDetailsModel.storeId)
        .collection('products')
        .where('storedCategorys', isEqualTo: widget.category)
    .where('delete',isEqualTo: false)
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        bags[doc.get('productId')] = doc.data();
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
    getReasons();

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
        physics: const BouncingScrollPhysics(),
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
                        SizedBox(
                          height: scrHeight * 0.01,
                        ),
                        Text(
                          widget.category!,
                          style: TextStyle(
                              fontSize: scrWidth * 0.03,
                              color: Color(0xff818181),
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500),
                        ),
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
                      padding:  EdgeInsets.only(left: scrWidth*0.1),
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
                                    child:Padding(
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

                    Padding(
                      padding: EdgeInsets.only(
                          // left: 70,
                          ),
                      child: Container(
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
                // child: Padding(
                //   padding: const EdgeInsets.only(bottom: 5),
                //   child: TextFormField(
                //     decoration:  InputDecoration(
                //         prefixIcon: Padding(
                //           padding: EdgeInsets.only(
                //               top: scrHeight*0.015,
                //               left: scrWidth*0.04,
                //               bottom: scrHeight*0.01,
                //               right: scrWidth*0.05),
                //           child:SvgPicture.asset("assets/icons/Vector (4).svg",),
                //         ),
                //         border: InputBorder.none,
                //         hintText: "Search Products",
                //         hintStyle: TextStyle(
                //           fontFamily: 'Urbanist',fontWeight: FontWeight.w500,
                //           fontSize: scrWidth*0.03,
                //           color: const Color(0xff8391A1),
                //         )
                //     ),
                //     cursorColor: Colors.black,
                //     cursorHeight: 20,
                //     cursorWidth: 0.5,
                //
                //   ),
                // ),
              ),
            ),
            SizedBox(
              height: scrHeight * 0.02,
            ),
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

            SizedBox(
              height: scrHeight * 0.02,
            ),
            Container(
              // color: Colors.blue,
              height: 600,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: productsList.length,
                itemBuilder: (context, index) {
                  final products = productsList[index];

                  // final _isSelected=_selectedIndexs.contains(index);
                  return ShopSingleProduct(
                    product: products,
                    storeId: widget.storeDetailsModel.storeId!,
                    deliveryCharge: widget.storeDetailsModel.deliveryCharge!,
                    storeavailable:shopAvailable
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
              ),
            ),
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

          return  BottomSheetPage(storeDetailsModel: widget.storeDetailsModel, category: widget.category,);
        }
    );
  }
}

class ShopSingleProduct extends StatefulWidget {
  final ProductModel product;
  final String storeId;
  final double deliveryCharge;
  final bool storeavailable;
  const ShopSingleProduct(
      {Key? key,
      required this.product,
      required this.storeId,
      required this.deliveryCharge,
        required this.storeavailable})
      : super(key: key);

  @override
  State<ShopSingleProduct> createState() => _ShopSingleProductState();
}

class _ShopSingleProductState extends State<ShopSingleProduct> {
  bool confirmed = false;

  // ProductModel products=ProductModel();
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  bool isCarted = false;
  getProduct() {
    for (int i = 0; i < cartlist.length; i++) {
      if (cartlist[i]['productId'] == widget.product.productId &&
          cartlist[i]['storeId'] == widget.product.storeId) {
        isCarted = true;
      }
    }
    setState(() {});
  }

  int qty = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // products=widget.product;
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>
                     ImageZoomPage(
                   image: widget.product.images!.isEmpty
                       ?'https://img.freepik.com/free-vector/shop-with-sign-we-are-open_52683-38687.jpg?w=2000'
                       :widget.product.images![0],
                   pro:widget.product ,
                   storeId: widget.product.storeId!,
                   deliveryCharge: widget.deliveryCharge!,
                   on: widget.storeavailable!,
                   // productname: widget.product.productName!,
                   // productprice: widget.product.price!.toString(),
                   // productquantity: widget.product.quantity!.toString(),
                   // producunit: widget.product.unit!,
                   // productDetails: widget.product.details!,
                   // productId: widget.product.productId!,
                   // storeId: widget.product.storeId!,

                 )));
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: widget.product.images!.length==0?
                        CachedNetworkImageProvider('https://img.freepik.com/free-vector/shop-with-sign-we-are-open_52683-38687.jpg?w=2000'):CachedNetworkImageProvider(widget.product.images![0]),
                        fit: BoxFit.cover,colorFilter: widget.product.available!&&widget.storeavailable!?
                    ColorFilter.mode(Colors.transparent, BlendMode.saturation):
                    ColorFilter.mode(Colors.grey, BlendMode.saturation),),

                    borderRadius: BorderRadius.circular(scrWidth * 0.04),
                    border:Border.all(color: const Color(0xffECECEC), width: 1)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(right: 5, left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.product.productName!,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: 'Urbanist',
                            fontSize: scrWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff0E0E0E)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: scrHeight * 0.003,
                  ),
                  Text(
                    "${widget.product.quantity!} ${widget.product.unit!}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: scrWidth * 0.036,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff818181)),
                  ),
                  SizedBox(
                    height: scrHeight * 0.003,
                  ),
                  Text(
                    currencyConvert.format(widget.product.price!).toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: scrWidth * 0.04,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xffF10000)),
                  ),
                  SizedBox(
                    height: scrHeight * 0.004,
                  ),
                ],
              ),
            ),
          ),
          /////////////////////////////////////////////////
          // isCarted
          //     ? InkWell(
          //         onTap: () {},
          //         child: Container(
          //           height: scrHeight * 0.033,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(8),
          //               color: const Color(0xff02B558)
          //               // color: Colors.red
          //               ),
          //           child: Row(
          //             children: [
          //               // Expanded(
          //               //   child: InkWell(
          //               //     onTap: () {
          //               //       if (qty != 1) {
          //               //         --qty;
          //               //         setState(() {});
          //               //       } else {
          //               //         isCarted = false;
          //               //         final snackBar = SnackBar(
          //               //           backgroundColor: Colors.white,
          //               //           content: const Text(
          //               //             ' item removed from cart',
          //               //             style: TextStyle(color: Colors.black),
          //               //           ),
          //               //         );
          //               //         ScaffoldMessenger.of(context)
          //               //             .showSnackBar(snackBar);
          //               //         setState(() {});
          //               //       }
          //               //       // setState(() {
          //               //       //   if(eachstore[index].counter <2)
          //               //       //   {
          //               //       //     eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
          //               //       //   }else{
          //               //       //     eachstore[index].counter--;
          //               //       //   }
          //               //       //
          //               //       // });
          //               //       decrementCount(widget.product.productId!,
          //               //           widget.storeId, qty);
          //               //
          //               //       print(cartlist);
          //               //     },
          //               //     child: Container(
          //               //       decoration: BoxDecoration(
          //               //           color: Color(0xff02B558),
          //               //           borderRadius: BorderRadius.only(
          //               //               topLeft: Radius.circular(8),
          //               //               bottomLeft: Radius.circular(8))),
          //               //       child: Padding(
          //               //         padding: EdgeInsets.only(bottom: 8),
          //               //         child: Icon(
          //               //           Icons.minimize_outlined,
          //               //           size: 15,
          //               //           color: Colors.white,
          //               //         ),
          //               //       ),
          //               //     ),
          //               //   ),
          //               // ),
          //               // Expanded(
          //               //   child: Container(
          //               //     decoration: BoxDecoration(
          //               //       color: Color(0xff9FFFCD),
          //               //     ),
          //               //     child: Center(
          //               //         child: Text(qty.toString()
          //               //             // '${eachstore[index].counter}'
          //               //             )),
          //               //   ),
          //               // ),
          //               Expanded(
          //                 child: InkWell(
          //                   onTap: () {
          //                     // print(products.productId);
          //                     // print(products.productName);
          //
          //
          //
          //
                              // qty++;
          //                     // incrementCount(widget.product.productId!,
          //                     //     widget.storeId, qty);
          //                     // print(cartlist);
          //
          //
          //
          //                     // final snackBar = SnackBar(
          //                     //   backgroundColor: Colors.white,
          //                     //   content: const Text(' item added to cart',
          //                     //     style: TextStyle(color: Colors.black),),
          //                     //   action: SnackBarAction(
          //                     //
          //                     //     textColor: Colors.blue,
          //                     //     label: 'Go To Cart',
          //                     //     onPressed: () {
          //                     //       Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
          //                     //       // Some code to undo the change.
          //                     //     },
          //                     //   ),
          //                     // );
          //                     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //
          //                      setState(() {});
          //                     Navigator.pushReplacement(
          //                         context, MaterialPageRoute(builder: (context) => CheckOutPage()));
          //
          //                   },
          //                   child: Container(
          //                     decoration: BoxDecoration(
          //                         // color: Colors.red,
          //                         color: Color(0xff02B558),
          //                         borderRadius: BorderRadius.only(
          //                             topRight: Radius.circular(8),
          //                             bottomRight: Radius.circular(8),topLeft: Radius.circular(8),
          //                             bottomLeft: Radius.circular(8))),
          //                     child:Center(
          //                       child: Text(
          //                         "Go To Cart",
          //                         style: TextStyle(
          //                             fontFamily: 'Urbanist',
          //                             fontWeight: FontWeight.w600,
          //                             fontSize: 12,
          //                             color: Colors.white),
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     : InkWell(
          //         onTap: () async {
          //           if (cartlist.isEmpty) {
          //             addToCart(widget.product, widget.storeId);
          //             isCarted = true;
          //           } else if (cartlist[0]['storeId'] ==
          //               widget.product.storeId) {
          //             addToCart(widget.product, widget.storeId);
          //             isCarted = true;
          //           } else {
          //             bool? pressed = await cartAlert();
          //
          //             if (pressed == true) {
          //               cartlist = [];
          //               addToCart(widget.product, widget.storeId);
          //               isCarted = true;
          //             }
          //           }
          //
          //           setState(() {});
          //         },
          //         child: Container(
          //           width: scrWidth * 0.31,
          //           height: scrHeight * 0.033,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(8),
          //               color: Color(0xff02B558)
          //               // color: Colors.red
          //               ),
          //           child: Center(
          //             child: Text(
          //               "Add",
          //               style: TextStyle(
          //                   fontFamily: 'Urbanist',
          //                   fontWeight: FontWeight.w600,
          //                   fontSize: 12,
          //                   color: Colors.white),
          //             ),
          //           ),
          //         ),
          //       ),
          /////////////////////////////////////////////////

          // Padding(
          //   padding: EdgeInsets.only(left: 7),
          //   child: InkWell(
          //     onTap: (){
          //       // setState((){
          //       // if(_isSelected){
          //       // _selectedIndexs.remove(index);
          //       //
          //       // }else{
          //       // _selectedIndexs.add(index);
          //       //
          //       // }
          //       // });
          //
          //       final findIndex=cartList.indexWhere((element) => element['name']==eachstore[index].productname);
          //       print("index" +findIndex.toString());
          //       if(findIndex>=0){
          //         setState(() {
          //           cartList[findIndex]['quantity'] =eachstore[index].counter;
          //         });
          //       }else{
          //         cartList.add({
          //           'name':eachstore[index].productname,
          //           'image':eachstore[index].productimage,
          //           'unit':eachstore[index].productunit,
          //           'price':eachstore[index].productprice,
          //           'quantity':eachstore[index].counter,
          //         });
          //       }
          //       print(eachstore[index].counter);
          //       print(cartList);
          //       final snackBar = SnackBar(
          //         backgroundColor: Colors.green,
          //         content:  Text('${eachstore[index].counter} ${eachstore[index].productname} added to cart',
          //           style: TextStyle(color: Colors.white),),
          //         action: SnackBarAction(
          //           textColor: Colors.white,
          //           label: 'Go To Cart',
          //           onPressed: () {
          //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CheckOutPage()));
          //             // Some code to undo the change.
          //           },
          //         ),
          //       );
          //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //
          //     },
          //     child:Container(
          //       width: 126,
          //       height: 30,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(8),
          //           color: Color(0xff02B558)
          //         // color: Colors.red
          //       ),
          //       child:eachstore[index].ShouldVisible?
          //       Row(
          //         children: [
          //           Container(
          //             height: 30,
          //             width: 45,
          //             decoration: BoxDecoration(
          //                 color: Color(0xff02B558),
          //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
          //                     bottomLeft:Radius.circular(8) )
          //
          //             ),
          //             child: Padding(
          //               padding: const EdgeInsets.only(bottom: 8),
          //               child: InkWell(
          //                   onTap:(){
          //                     setState(() {
          //                       if(eachstore[index].counter <2)
          //                       {
          //                         eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
          //                       }else{
          //                         eachstore[index].counter--;
          //                       }
          //
          //                     });
          //                   },
          //                   child: Icon(Icons.minimize_outlined,size: 15,color: Colors.white,)),
          //             ),
          //           ),
          //           Container(
          //             height: 30,
          //             width: 36,
          //             decoration: BoxDecoration(
          //               color: Color(0xff9FFFCD),
          //             ),
          //             child: Center(child: InkWell(
          //               onTap: (){
          //
          //               },
          //                 child: Text(eachstore[index].counter.toString()))),
          //           ),
          //           Container(
          //             height: 26,
          //             width: 30,
          //             decoration: BoxDecoration(
          //                 color: Color(0xff02B558),
          //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
          //                     bottomLeft:Radius.circular(8) )
          //
          //             ),
          //             child: InkWell(
          //                 onTap:(){
          //                   setState(() {
          //                     eachstore[index].counter++;
          //                   });
          //                 },
          //                 child: Padding(
          //                   padding: EdgeInsets.only(left: 5),
          //                   child: Icon(Icons.add,size: 15,color: Colors.white,),
          //                 )),
          //           ),
          //         ],
          //       )
          //       : InkWell(
          //         onTap: (){
          //           setState(() {
          //             eachstore[index].ShouldVisible = !eachstore[index].ShouldVisible;
          //           });
          //         },
          //         child: Container(
          //           width: 126,
          //           height: 30,
          //           decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(8),
          //               color: Color(0xff02B558)
          //             // color: Colors.red
          //           ),
          //           child: Center(
          //             child: Text("Add",style: TextStyle(
          //             fontFamily: 'Urbanist',fontWeight: FontWeight.w600,fontSize: 12,color: Colors.white
          //             ),),
          //           ),
          //         ),
          //       )
          //     ),
          //   ),
          //   ),
        ],
      ),
    );

  }

  addToCart(ProductModel products, String storeId) {
    cartlist.add({
      'img': products.images![0],
      'name': products.productName,
      'price': products.price,
      'unit': products.unit,
      'deliveryCharge': widget.deliveryCharge,
      'storeId': storeId,
      'productId': products.productId,
      'quantity': products.quantity,
      'count': 1,
    });

    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: const Text(
        ' item added to cart',
        style: TextStyle(color: Colors.black),
      ),
      action: SnackBarAction(
        textColor: Colors.blue,
        label: 'Go To Cart',
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CheckOutPage()));
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool?> cartAlert() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, setstate) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text('Confirm'),
              titleTextStyle: TextStyle(
                  fontSize: FontSize10 * 3,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  color: Color(0xff827C7C)),
              content: Container(
                width: scrWidth * 0.99,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Your cart contains products in another store , \n Do you wish to remove and add this product.'),
                    SizedBox(
                      height: scrWidth * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context, false),
                          child: Container(
                            width: scrWidth * 0.2,
                            height: textFormFieldHeight45,
                            decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: GestureDetector(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: FontSize16,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pop(context, true),
                          child: Container(
                            width: scrWidth * 0.3,
                            height: textFormFieldHeight45,
                            decoration: BoxDecoration(
                                color: primarycolor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: GestureDetector(
                                child: Text(
                                  "Add",
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
                  ],
                ),
              ),
            );
          },
        ),
      );

}

incrementCount(String productId, String storeId, int count) {
  for (int i = 0; i < cartlist.length; i++) {
    if (cartlist[i]['productId'] == productId &&
        cartlist[i]['storeId'] == storeId) {
      cartlist[i]['count'] = count;
    }
  }
}

decrementCount(String productId, String storeId, int count) {
  for (int i = 0; i < cartlist.length; i++) {
    if (cartlist[i]['productId'] == productId &&
        cartlist[i]['storeId'] == storeId) {
      if (cartlist[i]['count'] > 1) {
        cartlist[i]['count'] = count;
      } else {
        cartlist.removeAt(i);
      }
    }
  }
}
