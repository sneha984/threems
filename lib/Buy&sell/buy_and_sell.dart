import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gMap;
import 'package:google_maps_place_picker/google_maps_place_picker.dart' as gMapPlacePicker;
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/Sales/salesPage.dart';
import 'package:threems/Buy&sell/paymentpage.dart';
import 'package:threems/Buy&sell/productaddingpage.dart';
import 'package:threems/Buy&sell/productspage.dart';
import 'package:threems/Buy&sell/shopheadimageslider.dart';
import 'package:threems/Buy&sell/storedetailsfill.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';
import 'package:threems/Buy&sell/storepage.dart';
import 'package:threems/Buy&sell/yourstorecreate.dart';
import 'package:threems/model/Buy&sell.dart';

import 'dart:ui' as ui;
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import '../screens/charity/payment.dart';
import '../screens/home_screen.dart';
import '../utils/dummy.dart';
import 'Orders/Orders.dart';
import 'categorypage.dart';
import 'categorystores.dart';
import 'checkout.dart';
import 'myorderspage.dart';

List<String> cateoryNames = [];
Map<String, dynamic> cateoryNamesMap = {};
List products = [];
List orders = [];

class BuyAndSell extends StatefulWidget {
  final int index;
  const BuyAndSell({
    Key? key,
    required this.index,
  }) : super(key: key);
  static final kInitialPosition = LatLng(10.954697, 76.2208631);

  @override
  State<BuyAndSell> createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell> with TickerProviderStateMixin {
  TextEditingController? latitude;
  TextEditingController? longitude;
  gMapPlacePicker.PickResult? result;
  String serviceLocation='';

  // late PickResult selectedPlace;

  String currentAddress = 'Select Your Location';
  Position? currentposition;
  int activeindex = 0;
  List<Map<String, dynamic>> location = [];
  Map<String, dynamic> categorys = {};
  int status = 0;
  List<Widget> grids = [];
  List<DocumentSnapshot> documents = [];
  set(){
    setState(() {

    });
  }
  // geoLocation(String id) async {
  //   GeoFirestore geoFirestore =
  //       GeoFirestore(FirebaseFirestore.instance.collection('stores'));
  //   await geoFirestore.setLocation(id, GeoPoint(lat!, long!));
  //   final queryLocation = GeoPoint(lat!, long!);
  //   // creates a new query around [37.7832, -122.4056] with a radius of 0.6 kilometers
  //   documents = await geoFirestore.getAtLocation(queryLocation, 1);
  //   documents.forEach((doc) {
  //     print("111111111111111111111111111111111111111111111111111111");
  //     print(doc.data());
  //     print(documents);
  //     print("111111111111111111111111111111111111111111111111111111");
  //     print("111111111111111111111111111111111111111111111111111111");
  //   });
  //   if (mounted) {
  //     setState(() {
  //       print("hiii sneha");
  //       print(documents.length);
  //     });
  //   }
  // }

  getSpecificCategory() {
    FirebaseFirestore.instance
        .collection('storeCategory')
        .snapshots()
        .listen((event) {
      cateoryNames = [];
      cateoryNamesMap = {};
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        categorys[doc.get('categoryName')] = doc.data();
        cateoryNames.add(doc.get('categoryName'));
        cateoryNamesMap[doc.get('categoryName')] = doc.id;
        print(doc.get('categoryName'));
        print(
            "----------------------------------------------------------------------------------------");
        //print(categorys[doc['categoryName']]);
        // print(doc.get('categoryImage'));
        grids.add(InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryStores(
                          categoryname: doc.get('categoryName'),
                        )));
          },
          child: Container(
            height: scrWidth * 0.3,
            child: Column(
              children: [
                DottedBorder(
                  borderType: BorderType.Circle,
                  radius: Radius.circular(scrWidth * 0.06),
                  dashPattern: [3, 3],
                  color: Colors.grey,
                  strokeWidth: 0.5,
                  child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(scrWidth * 0.04),
                          child: Container(
                              height: 27,
                              width: 27,
                              child: SvgPicture.network(
                                  doc.get('categoryImage'))))),
                ),
                SizedBox(
                  height: scrHeight * 0.004,
                ),
                Container(
                  width: scrWidth * 0.15,
                  child: Text(
                    doc.get('categoryName'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: scrWidth * 0.025,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Urbanist'),
                  ),
                )
              ],
            ),
          ),
        ));
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  List<StoreDetailsModel> store = [];

  getShop() {
    FirebaseFirestore.instance
        .collection('stores')
        .where('userId', isEqualTo: currentuserid)
        .snapshots()
        .listen((event) {
      store = [];
      var data = event.docs;
      for (DocumentSnapshot<Map<String, dynamic>> item in data) {
        store.add(StoreDetailsModel.fromJson(item.data()!));
      }
      if (data.length > 0) {
        status = 1;
      }
      print('sneha ${store.length}');
      print(currentuserid);
      FirebaseFirestore.instance
          .collection('stores')
          .doc(data[0]['storeId'])
          .collection('products')
          .snapshots()
          .listen((event2) {
        products = [];

        var data2 = event2.docs;

        for (dynamic item in data2) {
          products.add(item);
        }
        if (products.length > 0) {
          status = 2;
          Future.delayed(Duration(seconds: 3)).whenComplete(() {
            print('23456789');
            status = 3;
            setState(() {});
          });
        }
        if (mounted) {
          setState(() {});
        }
      });

      FirebaseFirestore.instance
          .collection('stores')
          .doc(data[0]['storeId'])
          .collection('orders')
          .snapshots()
          .listen((event) {
        orders = [];
        for (var doc in event.docs) {
          orders.add(doc.data());
        }
        if (mounted) {
          setState(() {});
        }
      });
      if (mounted) {
        setState(() {});
      }
    });
  }
  final geo = Geoflutterfire();
  late GeoFirePoint center;
  List<StoreDetailsModel> nearestStores=[];
  getNearestShop() {

    center = geo.point(latitude: lat!, longitude: long!);
    var collectionReference = FirebaseFirestore.instance
        .collection('stores');
    double? radius = 5;
    String field = 'position';
    geo.collection(collectionRef: collectionReference  )
        .within(center: center, radius: radius, field: field,strictMode: true).listen((event) {
       nearestStores = [];
      for (var doc in event) {
        nearestStores.add(StoreDetailsModel.fromJson(doc.data()!));
      }



      if (mounted) {
        setState(() {});
      }
    });
  }

  late TabController _tabController;
  bool loading = false;
  bool isShopNotCreated = false;
  @override
  void initState() {
    getSpecificCategory();
    getShop();
    getNearestShop();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.index ?? 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: scrHeight * 0.1,
        shadowColor: Colors.grey,
        leadingWidth: 50,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: Container(
          height: 30,
          width: 30,
          child: Padding(
            padding: EdgeInsets.only(
              top: scrHeight * 0.03,
              left: scrWidth * 0.07,
              bottom: scrHeight * 0.01,
            ),
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PlacePicker(
                //       apiKey: 'AIzaSyCUZFUZ1yMpkzh6QUnKj54Q2N4L2iT4tBY',   // Put YOUR OWN KEY here.
                //       onPlacePicked: (result) {
                //         print(result.address);
                //         Navigator.of(context).pop();
                //       },
                //       initialPosition: HomePage.kInitialPosition,
                //       useCurrentLocation: true,
                //     ),
                //   ),
                // );
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => PaymentPageInBuy()));
              },
              child: SvgPicture.asset(
                "assets/icons/locationicon.svg",
              ),
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            currenPlace.toString(),
            style: TextStyle(
                fontSize: scrWidth * 0.046,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CheckOutPage(

                          )));
            },
            child: Badge(
                position: BadgePosition.topEnd(
                  top: scrHeight * 0.03,
                  end: scrHeight * 0.015,
                ),
                animationDuration: Duration(milliseconds: 300),
                animationType: BadgeAnimationType.fade,
                badgeColor: Colors.black,
                badgeContent: Text(
                  '${cartlist.length}',
                  style:
                      TextStyle(color: Colors.white, fontSize: scrWidth * 0.02),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: scrWidth * 0.06, top: scrHeight * 0.015),
                  child: SvgPicture.asset("assets/images/cart.svg"),
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyOrdersPage(


                  )));
            },
            child: Badge(
                position: BadgePosition.topEnd(
                  top: scrHeight * 0.03,
                  end: scrHeight * 0.015,
                ),
                animationDuration: Duration(milliseconds: 300),
                animationType: BadgeAnimationType.fade,
                badgeColor: Colors.black,
                badgeContent: Text(
                  '${allOrders.length}',
                  style:
                      TextStyle(color: Colors.white, fontSize: scrWidth * 0.02),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      right: scrWidth * 0.06, top: scrHeight * 0.015),
                  child: SvgPicture.asset("assets/icons/myorder.svg"),
                )),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: scrHeight * 0.015,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: scrWidth * 0.05, right: scrWidth * 0.05),
            child: Container(
              height: scrHeight * 0.05,
              decoration: BoxDecoration(
                color: primarycolor,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,

                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: Color(0xff02B558),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Text(
                    "SHOP NOW",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: scrWidth * 0.04,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "MY STORE",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: scrWidth * 0.04,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: scrWidth * 0.045,
                          right: scrWidth * 0.045,
                          top: scrWidth * 0.025),
                      height: scrHeight * .18,
                      width: scrWidth * 1,
                      child: ImageSlide(),
                    ),
                    SizedBox(
                      height: scrHeight * 0.02,
                    ),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: scrWidth*0.025),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       SizedBox(width: scrWidth * 0.03,),
                    //       SvgPicture.asset("assets/icons/staricon.svg"),
                    //       SizedBox(width: scrWidth * 0.03,),
                    //       Text("Sponsered Product", style: TextStyle(
                    //           fontFamily: 'Urbanist',
                    //           fontSize: scrWidth * 0.04,
                    //           fontWeight: FontWeight.w600
                    //       ),)
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: scrHeight*0.014,),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.03),
                    //   child: Container(
                    //     height: scrHeight*0.16,
                    //     child: ListView.builder(
                    //         physics: BouncingScrollPhysics(),
                    //         scrollDirection: Axis.horizontal,
                    //         shrinkWrap: true,
                    //         itemCount: sproduct.length,
                    //         itemBuilder: (context, index) {
                    //           return Padding(
                    //             padding:  EdgeInsets.only(right: scrWidth*0.016),
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 InkWell(
                    //                   child: Padding(
                    //                     padding:  EdgeInsets.only(
                    //                         left: scrWidth*0.03),
                    //                     child: Container(
                    //                       height: scrHeight*0.09,
                    //                       width: scrWidth*0.22,
                    //                       decoration: BoxDecoration(
                    //                         image: DecorationImage(image: NetworkImage(sproduct[index].productimage)),
                    //                           color: Colors.white,
                    //                           borderRadius: BorderRadius
                    //                               .circular(scrWidth*0.04),
                    //                           border: Border.all(
                    //                               color: Color(0xffECECEC),
                    //                               width: 1)
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Padding(
                    //                   padding:  EdgeInsets.only(left:scrWidth*0.08),
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment
                    //                         .start,
                    //                     children: [
                    //                       SizedBox(height: scrHeight*0.009,),
                    //                       Text(
                    //                         sproduct[index].productname, textAlign: TextAlign.center,
                    //                         style: TextStyle(
                    //                             fontFamily: 'Urbanist',
                    //                             fontSize: scrWidth*0.031,
                    //                             fontWeight: FontWeight.w600,
                    //                             color: Color(0xff0E0E0E)),),
                    //                       SizedBox(height: scrHeight*0.001,),
                    //
                    //                       Text(
                    //                         sproduct[index].storename, textAlign: TextAlign.center,
                    //                         style: TextStyle(
                    //                             fontFamily: 'Urbanist',
                    //                             fontSize: scrWidth*0.025,
                    //                             fontWeight: FontWeight.w600,
                    //                             color: Color(0xff818181)),),
                    //                       SizedBox(height: scrHeight*0.0016,),
                    //
                    //                       Text(
                    //                         currencyConvert.format(sproduct[index].price).toString(), textAlign: TextAlign.center,
                    //                         style: TextStyle(
                    //                             fontFamily: 'Urbanist',
                    //                             fontSize: scrWidth*0.03,
                    //                             fontWeight: FontWeight.w700,
                    //                             color: Color(0xffF10000)),),
                    //
                    //                     ],
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           );
                    //         }
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: scrHeight * 0.01,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: scrWidth * 0.07,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: scrHeight * 0.01),
                          child:
                              SvgPicture.asset("assets/images/nearstore.svg"),
                        ),
                        SizedBox(
                          width: scrWidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Nearest Stores",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${nearestStores.length} Stores available",
                              style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: scrWidth * 0.025,
                                  color: Color(0xff818181),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )

                      ],
                    ),
                    SizedBox(
                      height: scrHeight * 0.015,
                    ),



                    // SizedBox(
                    //   height: 50,
                    // ),
                    //
                    // Text("No Stores"),
                    // SizedBox(
                    //   height: 50,
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: scrWidth * 0.037, right: scrWidth * 0.037),
                      child: Container(
                        height: scrHeight * 0.15,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: nearestStores.length,
                            itemBuilder: (context, index) {
                              print('--------------------------');
                              print(nearestStores.length);
                              StoreDetailsModel store=nearestStores[index];
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StorePage(storeDetailsModel: nearestStores[index], category: '')));
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: scrWidth * 0.017),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: scrWidth * 0.03),
                                          child: Container(
                                            height: scrHeight * 0.09,
                                            width: scrWidth * 0.22,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      store.storeImage!),
                                                  fit: BoxFit.fill),
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(
                                                  scrWidth * 0.03),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: scrWidth * 0.04),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: scrHeight * 0.002,
                                            ),
                                            Text(
                                              store.storeName!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: scrWidth * 0.032,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff0E0E0E)),
                                            ),
                                            SizedBox(
                                              height: scrHeight * 0.0015,
                                            ),
                                            Text(
                                              store.storeAddress!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: scrWidth * 0.025,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xff818181)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YourStoreCreatePage()));
                      },
                      child: Container(
                        height: scrHeight * 0.045,
                        width: scrHeight * 0.35,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius:
                                BorderRadius.circular(scrWidth * 0.02)),
                        child: Center(
                          child: Text(
                            "View all nearest stores",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700,
                                fontSize: scrWidth * 0.04),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: scrHeight * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: scrWidth * 0.08,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: scrHeight * 0.005),
                          child:
                              SvgPicture.asset("assets/images/nearstore.svg"),
                        ),
                        SizedBox(
                          width: scrWidth * 0.03,
                        ),
                        Text(
                          "Categories",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: scrWidth * 0.04,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: scrHeight * 0.03,
                    ),
                    // Padding(
                    //   padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.03),
                    //   child: Container(
                    //     height: scrHeight*0.5,
                    //     child: GridView.builder(
                    //       shrinkWrap: true,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       itemCount:category.length,
                    //       gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    //           childAspectRatio: 3 / 3.5,
                    //           crossAxisSpacing: 2,
                    //           mainAxisSpacing: 20,
                    //           crossAxisCount: 4
                    //       ),
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return InkWell(
                    //           onTap: (){
                    //             // Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryStores()));
                    //           },
                    //           child: Container(
                    //             height: scrWidth*0.03,
                    //             child: Column(
                    //               children: [
                    //                 DottedBorder(
                    //                   borderType: BorderType.Circle,
                    //                   radius: Radius.circular(scrWidth*0.06),
                    //                   dashPattern: [3, 3],
                    //                   color: Colors.grey,
                    //                   strokeWidth: 0.5,
                    //                   child: Center(child: Padding(
                    //                     padding: EdgeInsets.all(scrWidth*0.045),
                    //                     child: SvgPicture.asset(category[index].categoryimage,height:scrHeight*0.03,width: scrWidth*0.04,),
                    //                   )),
                    //                 ),
                    //                 SizedBox(height: scrHeight*0.004,),
                    //                 Container(
                    //                   width: scrWidth*0.15,
                    //                   child: Text(category[index].categoryname,textAlign: TextAlign.center,
                    //                   style: TextStyle(
                    //                     fontSize: scrWidth*0.025,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Urbanist'
                    //                   ),),
                    //                 )
                    //
                    //               ],
                    //             ) ,
                    //           ),
                    //         );
                    //
                    //
                    //       },
                    //     ),
                    //   ),
                    // ),
                    grids.isEmpty
                        ? CircularProgressIndicator()
                        : Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: GridView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 3 / 4,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 25,
                                    crossAxisCount: 4,
                                  ),
                                  children: grids),
                            ),
                          ),

                    SizedBox(height: 100,),

                    // ElevatedButton(onPressed: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                    // }, child: Text("uhsdhw")),
                    // SizedBox(height: 100,),
                  ],
                ),
              ),
              status == 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: scrHeight * 0.03,
                        ),
                        DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(23),
                            dashPattern: [3, 2],
                            child: SvgPicture.asset("assets/icons/shop.svg")),
                        SizedBox(
                          height: scrHeight * 0.01,
                        ),
                        Text(
                          "Build your own online store \nhassle free!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: scrWidth * 0.03,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff615C5C)),
                        ),
                        SizedBox(
                          height: scrHeight * 0.02,
                        ),
                        DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(11),
                            padding: EdgeInsets.all(21),
                            dashPattern: [3, 2],
                            child: SvgPicture.asset("assets/icons/lens.svg")),
                        SizedBox(
                          height: scrHeight * 0.01,
                        ),
                        Text(
                          "Manage orders and track your \nbusiness on the go!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: scrWidth * 0.03,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff615C5C)),
                        ),
                        SizedBox(
                          height: scrHeight * 0.02,
                        ),
                        DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(11),
                            padding: EdgeInsets.all(21),
                            dashPattern: [3, 2],
                            child: SvgPicture.asset(
                                "assets/icons/featuresicon.svg")),
                        SizedBox(
                          height: scrHeight * 0.01,
                        ),
                        Text(
                          "Get all the features to grow \nyour online business",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff615C5C)),
                        ),
                        SizedBox(
                          height: scrHeight * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreDetails()));
                          },
                          child: Container(
                            height: scrHeight * 0.05,
                            width: scrWidth * 0.6,
                            decoration: BoxDecoration(
                                color: primarycolor,
                                borderRadius: BorderRadius.circular(21.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: scrWidth * 0.045,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Create Store",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: scrWidth * 0.045,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: scrHeight * 0.03,
                        ),
                      ],
                    )
                  : (status == 1)
                      ? Column(
                          children: [
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),
                            Container(
                              width: scrWidth * 0.8,
                              height: scrHeight * 0.12,
                              padding: EdgeInsets.symmetric(
                                horizontal: scrWidth * 0.015,
                                vertical: scrHeight * 0.002,
                              ),
                              decoration: BoxDecoration(
                                color: textFormFieldFillColor,
                                // color: Colors.red,
                                borderRadius: BorderRadius.circular(21),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: scrHeight * 0.01,
                                  ),
                                  Text(
                                    "50%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: scrWidth * 0.07,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.004,
                                  ),
                                  LinearPercentIndicator(
                                    //leaner progress bar
                                    animation: true,
                                    animationDuration: 1000,
                                    lineHeight: scrHeight * 0.02,
                                    width: scrWidth * 0.77,
                                    percent: 0.5,
                                    alignment: MainAxisAlignment.start,
                                    barRadius: Radius.circular(scrWidth * 0.2),
                                    progressColor: primarycolor,
                                    backgroundColor: Color(0xffD9D9D9),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.01,
                                  ),
                                  Text(
                                    "Store setup is completed",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: scrWidth * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: scrHeight * 0.42,
                                width: scrWidth * 0.8,
                                decoration: BoxDecoration(
                                    color: Color(0xffF3F3F3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: scrWidth * 0.05),
                                  child: AnotherStepper(
                                    titleTextStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Urbanist',
                                      color: Color(0xff232323),
                                    ),
                                    subtitleTextStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Urbanist',
                                      color: Color(0xff8B8B8B),
                                    ),
                                    dotWidget: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          color: Color(0xff30CF7C),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          // border:activeindex==0? Border.all(color: primarycolor,width: 2):Border.all(color: Colors.transparent)
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 5, right: 5),
                                          child: SvgPicture.asset(
                                              "assets/icons/tickmark.svg"),
                                        )),
                                    stepperList: [
                                      StepperData(
                                        title: "Create online store",
                                        subtitle:
                                            "Congratulations on opening your new \nonline store!",
                                      ),
                                      StepperData(
                                        title: "Add Product",
                                        subtitle:
                                            "Create your first product by adding the \nproduct name and images.",
                                      ),
                                      StepperData(
                                        title: "Payment",
                                        subtitle:
                                            "Confirm Your Payment section",
                                      ),
                                    ],
                                    horizontalStepperHeight: 200,
                                    stepperDirection: Axis.vertical,
                                    inActiveBarColor: Colors.grey,
                                    activeIndex: activeindex,
                                    barThickness: 2,
                                    activeBarColor: primarycolor,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                print(filteredShops.length);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StoreDetailsFill2(
                                              data: store[0],
                                            )));
                              },
                              child: Container(
                                height: scrHeight * 0.055,
                                width: scrWidth * 0.55,
                                decoration: BoxDecoration(
                                    color: primarycolor,
                                    borderRadius: BorderRadius.circular(21.5)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: scrWidth * 0.045,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Add Product",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          fontSize: scrWidth * 0.04,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : (status == 2)
                          ? Column(
                              children: [
                                SizedBox(
                                  height: scrHeight * 0.02,
                                ),
                                Container(
                                  width: scrWidth * 0.8,
                                  height: scrHeight * 0.15,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: scrWidth * 0.015,
                                    vertical: scrHeight * 0.002,
                                  ),
                                  decoration: BoxDecoration(
                                    color: textFormFieldFillColor,
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: scrHeight * 0.02,
                                      ),
                                      Text(
                                        "100%",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.07,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.009,
                                      ),
                                      LinearPercentIndicator(
                                        //leaner progress bar
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: scrHeight * 0.021,
                                        width: scrWidth * 0.77,
                                        percent: 1,
                                        alignment: MainAxisAlignment.start,
                                        barRadius:
                                            Radius.circular(scrWidth * 0.2),
                                        progressColor: primarycolor,
                                        backgroundColor: Color(0xffD9D9D9),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.02,
                                      ),
                                      Text(
                                        "Store setup is completed",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.04,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: scrHeight * 0.02,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    height: scrHeight * 0.32,
                                    width: scrWidth * 0.8,
                                    decoration: BoxDecoration(
                                        color: Color(0xffF3F3F3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: scrWidth * 0.05),
                                      child: AnotherStepper(
                                        titleTextStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Urbanist',
                                          color: Color(0xff232323),
                                        ),
                                        subtitleTextStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Urbanist',
                                          color: Color(0xff8B8B8B),
                                        ),
                                        dotWidget: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              color: Color(0xff30CF7C),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              // border: Border.all(color: primarycolor,width: 2)
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: SvgPicture.asset(
                                                  "assets/icons/tickmark.svg"),
                                            )),
                                        stepperList: [
                                          StepperData(
                                            title: "Create online store",
                                            subtitle:
                                                "Congratulations on opening your new \nonline store!",
                                          ),
                                          StepperData(
                                            title: "Add Product",
                                            subtitle:
                                                "Create your first product by adding the \nproduct name and images.",
                                          ),
                                          StepperData(
                                            title: "Payment",
                                            subtitle:
                                                "Confirm Your Payment section ",
                                          ),
                                        ],
                                        horizontalStepperHeight: 200,
                                        stepperDirection: Axis.vertical,
                                        inActiveBarColor: Colors.grey,
                                        activeIndex: 1,
                                        barThickness: 2,
                                        activeBarColor: primarycolor,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: scrHeight * 0.02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetailsFill2()));
                                  },
                                  child: Container(
                                    height: scrHeight * 0.055,
                                    width: scrWidth * 0.55,
                                    decoration: BoxDecoration(
                                        color: primarycolor,
                                        borderRadius:
                                            BorderRadius.circular(21.5)),
                                    child: Center(
                                      child: Text(
                                        "View Store",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Urbanist',
                                            fontSize: scrWidth * 0.04,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                              : Column(
                                  children: [
                                    SizedBox(
                                      height: scrHeight * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Overview",
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.04,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          width: scrWidth * 0.37,
                                        ),
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.03,
                                              color: Color(0xff6F6E6E),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: scrHeight * 0.013,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: scrWidth * 0.035,
                                          right: scrWidth * 0.035),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Orders(
                                                            storeId: store[0]
                                                                .storeId!,
                                                          )));
                                            },
                                            child: Container(
                                              height: scrHeight * 0.11,
                                              width: scrWidth * 0.4,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff02B558),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          scrWidth * 0.06)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: scrWidth * 0.05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: scrHeight * 0.02,
                                                    ),
                                                    Text(
                                                      "Orders",
                                                      style: TextStyle(
                                                          fontSize:
                                                              scrWidth * 0.04,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: scrHeight * 0.018,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          orders.length
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  scrWidth *
                                                                      0.07,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              scrWidth * 0.18,
                                                        ),
                                                        SvgPicture.asset(
                                                            "assets/circlearrow.svg"),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SalesPage()));
                                            },
                                            child: Container(
                                                height: scrHeight * 0.11,
                                                width: scrWidth * 0.4,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff02B558),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            scrWidth * 0.06)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: scrWidth * 0.05),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            scrHeight * 0.02,
                                                      ),
                                                      Text(
                                                        "Sale",
                                                        style: TextStyle(
                                                            fontSize:
                                                                scrWidth * 0.04,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            scrHeight * 0.018,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 30,
                                                            child: Text(
                                                              "₹0",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      scrWidth *
                                                                          0.07,
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                scrWidth * 0.14,
                                                          ),
                                                          SvgPicture.asset(
                                                              "assets/circlearrow.svg"),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: scrWidth * 0.46,
                                          top: scrHeight * 0.026),
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: scrHeight * 0.11,
                                          width: scrWidth * 0.4,
                                          decoration: BoxDecoration(
                                              color: Color(0xff02B558),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.06)),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: scrWidth * 0.05),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: scrHeight * 0.02,
                                                ),
                                                Text(
                                                  "Store Views",
                                                  style: TextStyle(
                                                      fontSize: scrWidth * 0.04,
                                                      color: Colors.white,
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: scrHeight * 0.018,
                                                ),
                                                Text(
                                                  "0",
                                                  style: TextStyle(
                                                      fontSize: scrWidth * 0.07,
                                                      color: Colors.white,
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: scrWidth * 0.65,
                                          top: scrHeight * 0.02,
                                          bottom: scrHeight * 0.02),
                                      child: Text(
                                        "Products",
                                        style: TextStyle(
                                            fontSize: scrWidth * 0.04,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: scrWidth * 0.08,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductsPage(
                                                          storeId:
                                                              store[0].storeId!,
                                                        )));
                                          },
                                          child: Container(
                                            height: scrHeight * 0.1,
                                            width: scrWidth * 0.4,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF3F3F3),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        scrWidth * 0.06)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: scrWidth * 0.05),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: scrHeight * 0.02,
                                                  ),
                                                  Text(
                                                    "Products",
                                                    style: TextStyle(
                                                        fontSize:
                                                            scrWidth * 0.035,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: scrHeight * 0.01,
                                                  ),
                                                  Text(
                                                    products.length.toString(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            scrWidth * 0.06,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //             builder: (context) =>
                                        //                 CategoryPage(
                                        //                   storeId:
                                        //                       store[0].storeId!,
                                        //                 )));
                                        //   },
                                        //   child: Container(
                                        //     height: scrHeight * 0.1,
                                        //     width: scrWidth * 0.4,
                                        //     decoration: BoxDecoration(
                                        //         color: Color(0xffF3F3F3),
                                        //         borderRadius:
                                        //             BorderRadius.circular(
                                        //                 scrWidth * 0.06)),
                                        //     child: Padding(
                                        //       padding: EdgeInsets.only(
                                        //           left: scrWidth * 0.05),
                                        //       child: Column(
                                        //         crossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.start,
                                        //         children: [
                                        //           SizedBox(
                                        //             height: scrHeight * 0.02,
                                        //           ),
                                        //           Text(
                                        //             "Categories",
                                        //             style: TextStyle(
                                        //                 fontSize:
                                        //                     scrWidth * 0.035,
                                        //                 fontFamily: 'Urbanist',
                                        //                 fontWeight:
                                        //                     FontWeight.w600),
                                        //           ),
                                        //           SizedBox(
                                        //             height: scrHeight * 0.01,
                                        //           ),
                                        //           Text(
                                        //             store[0]!
                                        //                 .storeCategory!
                                        //                 .length
                                        //                 .toString(),
                                        //             style: TextStyle(
                                        //                 fontSize:
                                        //                     scrWidth * 0.06,
                                        //                 fontFamily: 'Urbanist',
                                        //                 fontWeight:
                                        //                     FontWeight.w600),
                                        //           ),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                )
                               // Column(
                               //    children: [
                               //      SizedBox(
                               //        height: scrHeight * 0.02,
                               //      ),
                               //      Container(
                               //        width: scrWidth * 0.8,
                               //        height: scrHeight * 0.15,
                               //        padding: EdgeInsets.symmetric(
                               //          horizontal: scrWidth * 0.015,
                               //          vertical: scrHeight * 0.002,
                               //        ),
                               //        decoration: BoxDecoration(
                               //          color: textFormFieldFillColor,
                               //          // color: Colors.red,
                               //          borderRadius: BorderRadius.circular(21),
                               //        ),
                               //        child: Column(
                               //          children: [
                               //            SizedBox(
                               //              height: scrHeight * 0.02,
                               //            ),
                               //            Text(
                               //              "75%",
                               //              textAlign: TextAlign.center,
                               //              style: TextStyle(
                               //                  fontFamily: 'Urbanist',
                               //                  fontSize: scrWidth * 0.07,
                               //                  fontWeight: FontWeight.w600,
                               //                  color: Colors.black),
                               //            ),
                               //            SizedBox(
                               //              height: scrHeight * 0.009,
                               //            ),
                               //            LinearPercentIndicator(
                               //              //leaner progress bar
                               //              animation: true,
                               //              animationDuration: 1000,
                               //              lineHeight: scrHeight * 0.021,
                               //              width: scrWidth * 0.77,
                               //              percent: 0.7,
                               //              alignment: MainAxisAlignment.start,
                               //              barRadius:
                               //                  Radius.circular(scrWidth * 0.2),
                               //              progressColor: primarycolor,
                               //              backgroundColor: Color(0xffD9D9D9),
                               //            ),
                               //            SizedBox(
                               //              height: scrHeight * 0.02,
                               //            ),
                               //            Text(
                               //              "Store setup is completed",
                               //              textAlign: TextAlign.center,
                               //              style: TextStyle(
                               //                  fontFamily: 'Urbanist',
                               //                  fontSize: scrWidth * 0.04,
                               //                  fontWeight: FontWeight.w600,
                               //                  color: Colors.black),
                               //            ),
                               //          ],
                               //        ),
                               //      ),
                               //      SizedBox(
                               //        height: scrHeight * 0.02,
                               //      ),
                               //      Padding(
                               //        padding:
                               //            EdgeInsets.only(left: 10, right: 10),
                               //        child: Container(
                               //          height: scrHeight * 0.32,
                               //          width: scrWidth * 0.8,
                               //          decoration: BoxDecoration(
                               //              color: Color(0xffF3F3F3),
                               //              borderRadius:
                               //                  BorderRadius.circular(20)),
                               //          child: Padding(
                               //            padding: EdgeInsets.only(
                               //                left: scrWidth * 0.05),
                               //            child: AnotherStepper(
                               //              titleTextStyle: TextStyle(
                               //                fontSize: 16,
                               //                fontWeight: FontWeight.w600,
                               //                fontFamily: 'Urbanist',
                               //                color: Color(0xff232323),
                               //              ),
                               //              subtitleTextStyle: TextStyle(
                               //                fontSize: 12,
                               //                fontWeight: FontWeight.w600,
                               //                fontFamily: 'Urbanist',
                               //                color: Color(0xff8B8B8B),
                               //              ),
                               //              dotWidget: Container(
                               //                  height: 35,
                               //                  width: 35,
                               //                  decoration: BoxDecoration(
                               //                    color: Color(0xff30CF7C),
                               //                    borderRadius:
                               //                        BorderRadius.circular(30),
                               //                    // border: Border.all(color: primarycolor,width: 2)
                               //                  ),
                               //                  child: Padding(
                               //                    padding: EdgeInsets.only(
                               //                        left: 5, right: 5),
                               //                    child: SvgPicture.asset(
                               //                        "assets/icons/tickmark.svg"),
                               //                  )),
                               //              stepperList: [
                               //                StepperData(
                               //                  title: "Create online store",
                               //                  subtitle:
                               //                      "Congratulations on opening your new \nonline store!",
                               //                ),
                               //                StepperData(
                               //                  title: "Add Product",
                               //                  subtitle:
                               //                      "Create your first product by adding the \nproduct name and images.",
                               //                ),
                               //                StepperData(
                               //                  title: "Payment",
                               //                  subtitle:
                               //                      "Confirm Your Payment Section",
                               //                ),
                               //              ],
                               //              horizontalStepperHeight: 200,
                               //              stepperDirection: Axis.vertical,
                               //              inActiveBarColor: Colors.grey,
                               //              activeIndex: 1,
                               //              barThickness: 2,
                               //              activeBarColor: primarycolor,
                               //            ),
                               //          ),
                               //        ),
                               //      ),
                               //      SizedBox(
                               //        height: scrHeight * 0.02,
                               //      ),
                               //      // GestureDetector(
                               //      //   onTap: () {
                               //      //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetailsFill2()));
                               //      //   },
                               //      //   child: Container(
                               //      //     height: scrHeight * 0.055,
                               //      //     width: scrWidth * 0.55,
                               //      //     decoration: BoxDecoration(
                               //      //         color: primarycolor,
                               //      //         borderRadius:
                               //      //         BorderRadius.circular(21.5)),
                               //      //     child: Center(
                               //      //       child: Text(
                               //      //         "View Store",
                               //      //         textAlign: TextAlign.center,
                               //      //         style: TextStyle(
                               //      //             fontFamily: 'Urbanist',
                               //      //             fontSize: scrWidth * 0.04,
                               //      //             fontWeight: FontWeight.w700,
                               //      //             color: Colors.white),
                               //      //       ),
                               //      //     ),
                               //      //   ),
                               //      // ),
                               //    ],
                               //  ),

              //after store created
            ]),
          )
        ],
      ),
    );
  }
}

class HomePage {}
