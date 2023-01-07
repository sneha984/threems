import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gMap;
import 'package:google_maps_place_picker/google_maps_place_picker.dart'
    as gMapPlacePicker;
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
import 'package:threems/Buy&sell/neareststoredetailpage.dart';
import 'package:threems/Buy&sell/paymentpage.dart';
import 'package:threems/Buy&sell/productaddingpage.dart';
import 'package:threems/Buy&sell/productspage.dart';
import 'package:threems/Buy&sell/shopheadimageslider.dart';
import 'package:threems/Buy&sell/storedetailsfill.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';
import 'package:threems/Buy&sell/storeeditpage.dart';
import 'package:threems/Buy&sell/storepage.dart';
import 'package:threems/Buy&sell/yourstorecreate.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/model/Buy&sell.dart';

import 'dart:ui' as ui;
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import '../model/OrderModel.dart';
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
  String serviceLocation = '';

  // late PickResult selectedPlace;

  String currentAddress = 'Select Your Location';
  Position? currentposition;
  int activeindex = 0;
  List<Map<String, dynamic>> location = [];
  Map<String, dynamic> categorys = {};
  int status = 0;
  List<Widget> grids = [];
  List<DocumentSnapshot> documents = [];
  set() {
    setState(() {});
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
  getAllOrders(){
    print(currentuserid);
    FirebaseFirestore
        .instance
        .collectionGroup('orders')
        .where('userId',isEqualTo: currentuserid)
        .snapshots().listen((event) {
      print(event.docs.length);
      print('-------------------------------------------------');
      allOrders=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        allOrders.add(OrderModel.fromJson(doc.data()!));
      }
      if(mounted){
        setState(() {
          print('hereeeeeeeee');
          print(allOrders.length);
        });
      }
    });
  }

List cate=[];
  getSpecificCategory() {
    FirebaseFirestore.instance
        .collection('storeCategory')
        .snapshots()
        .listen((event) {
      cateoryNames = [];
      cateoryNamesMap = {};
      cate=[];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        categorys[doc.get('categoryId')] = doc.data();
        cate.add(doc.get('categoryId'));
        cateoryNames.add(doc.get('categoryName'));
        cateoryNamesMap[doc.get('categoryName')] = doc.id;
        print(doc.get('categoryName'));
        print(
            "----------------------------------------------------------------------------------------");
        //print(categorys[doc['categoryName']]);
        // print(doc.get('categoryImage'));
        grids.add(InkWell(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CategoryStores(
                          categoryname: doc.get('categoryName'),
                      categoryImage: doc.get('categoryImage'),

                      
                        )));

            setState(() {});
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
                                  doc.get('categoryImage')
                              )
                          )
                      )),
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
        // .where('block',isEqualTo: false)
        // .where('rejected',isEqualTo: false)
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
          .doc(data![0]['storeId'])
          .collection('products')
          .where('delete',isEqualTo: false)
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
            if(mounted){
              setState(() {

              });
            }
            // setState(() {});
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
    });
  }

  final geo = Geoflutterfire();
  late GeoFirePoint center;
  List<StoreDetailsModel> nearestStores = [];
  getNearestShop() {
    center = geo.point(latitude: lat ?? 10.98, longitude: long ?? 76.23);
    var collectionReference = FirebaseFirestore
        .instance
        .collection('stores');
    double? radius = 5;
    String field = 'position';
    geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field, strictMode: true)
        .listen((event) {
      nearestStores = [];
      for (var doc in event) {
        if(doc['userId'].toString()!=currentuserid
            &&doc['storeVerification']==true
            &&doc['block']==false
            &&doc['rejected']==false){
        nearestStores.add(StoreDetailsModel.fromJson(doc.data()!));
      }
      }

      if (mounted) {
        setState(() {
          print(nearestStores);
          print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
        });
      }
    });
  }

  late TabController _tabController;
  bool loading = false;
  bool isShopNotCreated = false;
  @override
  void initState() {
    getAllOrders();
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
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
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
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckOutPage()));

                setState(() {});
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
                    style: TextStyle(
                        color: Colors.white, fontSize: scrWidth * 0.02),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: scrWidth * 0.06, top: scrHeight * 0.015),
                    child: SvgPicture.asset("assets/images/cart.svg"),
                  )),
            ),
            InkWell(
              onTap: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrdersPage()));

                setState(() {});
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
                    style: TextStyle(
                        color: Colors.white, fontSize: scrWidth * 0.02),
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
              padding: EdgeInsets.only(
                  left: scrWidth * 0.05, right: scrWidth * 0.05),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: scrWidth * 0.045,
                            right: scrWidth * 0.045,
                            top: scrWidth * 0.025),
                        height: scrHeight * .18,
                        width: scrWidth * 1,
                        child: ImageSlide(type: 'buy and sell',),
                      ),
                      SizedBox(
                        height: scrHeight * 0.02,
                      ),

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
                                    fontSize: scrWidth * 0.027,
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


                     nearestStores.isEmpty
                         ?Container(
                         height: scrHeight*0.1,
                         child: Center(
                           child: Text("No Stores Found"),))
                         : Padding(
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
                                StoreDetailsModel store = nearestStores[index];
                                return InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NearestStoreDetailPage(
                                                storeDetailsModel:
                                                    nearestStores[index],
                                                category:'', cate:cateoryNames,)));

                                    setState(() {});
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

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
                                                  image:CachedNetworkImageProvider(store?.storeImage??''),
                                                  // NetworkImage(
                                                  //     store?.storeImage??''),
                                                  colorFilter:store.online!?
                                                  ColorFilter.mode(Colors.transparent, BlendMode.saturation):
                                                  ColorFilter.mode(Colors.grey, BlendMode.saturation),
                                                  fit: BoxFit.fill),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      scrWidth * 0.03),
                                            ),
                                            // child: ClipRRect(
                                            //   borderRadius: BorderRadius.circular(scrWidth * 0.02),
                                            //   child: CachedNetworkImage(
                                            //     fit: BoxFit.cover,
                                            //     imageUrl:store?.storeImage??'',
                                            //   ),
                                            // ),
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
                                            Padding(
                                              padding:  EdgeInsets.only(right: 10),
                                              child: Container(
                                                width: scrWidth*0.2,
                                                child: Text(
                                                  store.storeAddress!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,
                                                      fontFamily: 'Urbanist',
                                                      fontSize: scrWidth * 0.025,
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xff818181)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
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

                      SizedBox(
                        height: 100,
                      ),

                      // ElevatedButton(onPressed: (){
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                      // }, child: Text("uhsdhw")),
                      // SizedBox(height: 100,),
                    ],
                  ),
                ),
                (status == 0)
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
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoreDetails()));

                              setState(() {});
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
                            )
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
                             store[0].rejected==true? Padding(
                               padding: EdgeInsets.only(left: 10, right: 10),
                               child: Container(
                                 height: scrHeight * 0.3,
                                 width: scrWidth * 0.8,
                                 decoration: BoxDecoration(
                                     color: Color(0xffF3F3F3),
                                     borderRadius: BorderRadius.circular(20)),
                                 child: Padding(
                                   padding:
                                   EdgeInsets.only(left: scrWidth * 0.02),
                                   child: Column(
                                       children: [
                                         SizedBox(height: 40,),
                                         Text("Strore Rejected",style: TextStyle(fontSize: 23,fontFamily: 'Urbanist',fontWeight: FontWeight.w600),),
                                         SizedBox(height: 30,),


                                         Text(store[0].rejectedReason??"",style: TextStyle(),)
                                       ],
                                   )
                                 ),
                               ),
                             ):Padding(
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
                              store[0].storeVerification==true
                                  ? GestureDetector(
                                onTap: () async {
                                  print(filteredShops.length);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              StoreDetailsFill2(
                                                data: store[0],
                                              )));

                                  setState(() {});
                                },
                                child: Container(
                                  height: scrHeight * 0.055,
                                  width: scrWidth * 0.55,
                                  decoration: BoxDecoration(
                                      color: primarycolor,
                                      borderRadius:
                                          BorderRadius.circular(21.5)),
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
                                  :InkWell(
                                onTap: (){
                                  showSnackbar(context, "Please Wait for The store Verification");
                                },
                                    child: Container(
                                height: scrHeight * 0.05,
                                width: scrWidth * 0.6,
                                decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 128, 54, 0.33),
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
                                            fontSize: scrWidth * 0.045,
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
                                    height: scrHeight * 0.005,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      height: scrHeight * 0.4,
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
                                          activeIndex: 2,
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
                            :(store[0].storeVerification==true&&store[0].rejected==false&&store[0].block==false)
                    ? Padding(
                              padding:  EdgeInsets.only(left: scrWidth*0.06,right: scrWidth*0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      height: scrHeight * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(store[0].storeName!,style: TextStyle(
                                            fontSize: scrWidth * 0.045,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w600),),
                                        Row(
                                          children: [
                                            IconButton(onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>StoreEditPage(storemodel: store[0],
                                                    update: true,)));
                                            }, icon: Icon(Icons.edit)),
                                            Text(
                                              store[0].online! ? "(online)" : "(offline)",
                                              style: GoogleFonts.urbanist(
                                                  fontSize: scrWidth * 0.028,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Transform.scale(
                                              scale: 0.7,
                                              child: CupertinoSwitch(
                                                thumbColor:store[0].online!
                                                    ? Color(0xff02B558)
                                                    : Color(0xffE54D3C),
                                                activeColor: Color(0xffD9D9D9),
                                                trackColor: Color(0xffD9D9D9),
                                                value: store[0].online!,
                                                onChanged: (value) {
                                                  // print(widget.storeId);

                                                  FirebaseFirestore
                                                      .instance
                                                      .collection('stores')
                                                      .doc(store[0].storeId)
                                                      .update(
                                                      {
                                                        'online':!store[0].online!,
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

                                    SizedBox(height: 20,),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Overview",
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.04,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Orders(
                                                          storeId:
                                                              store[0].storeId!,
                                                        )));

                                            setState(() {});
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
                                                        fontSize: scrWidth * 0.04,
                                                        color: Colors.white,
                                                        fontFamily: 'Urbanist',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    height: scrHeight * 0.018,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        orders.length.toString(),
                                                        style: TextStyle(
                                                            fontSize:
                                                                scrWidth * 0.07,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontWeight:
                                                                FontWeight.w700),
                                                      ),
                                                      SizedBox(
                                                        width: scrWidth * 0.18,
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
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             SalesPage()));
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
                                                      "Sale",
                                                      style: TextStyle(
                                                          fontSize:
                                                              scrWidth * 0.04,
                                                          color: Colors.white,
                                                          fontFamily: 'Urbanist',
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: scrHeight * 0.018,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            store[0].totalSales ==
                                                                    null
                                                                ? "₹${0.toStringAsFixed(2)}"
                                                                : "₹${store[0].totalSales!.toStringAsFixed(2)}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    scrWidth *
                                                                        0.05,
                                                                color:
                                                                    Colors.white,
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                        // SizedBox(
                                                        //   width: scrWidth * 0.14,
                                                        // ),
                                                        // SvgPicture.asset(
                                                        //     "assets/circlearrow.svg"),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20,),
                                    // Padding(
                                    //   padding: EdgeInsets.only(
                                    //       right: scrWidth * 0.46,
                                    //       top: scrHeight * 0.026),
                                    //   child: InkWell(
                                    //     onTap: () {},
                                    //     child: Container(
                                    //       height: scrHeight * 0.11,
                                    //       width: scrWidth * 0.4,
                                    //       decoration: BoxDecoration(
                                    //           color: Color(0xff02B558),
                                    //           borderRadius: BorderRadius.circular(
                                    //               scrWidth * 0.06)),
                                    //       child: Padding(
                                    //         padding: EdgeInsets.only(
                                    //             left: scrWidth * 0.05),
                                    //         child: Column(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.start,
                                    //           children: [
                                    //             SizedBox(
                                    //               height: scrHeight * 0.02,
                                    //             ),
                                    //             Text(
                                    //               "Store Views",
                                    //               style: TextStyle(
                                    //                   fontSize: scrWidth * 0.04,
                                    //                   color: Colors.white,
                                    //                   fontFamily: 'Urbanist',
                                    //                   fontWeight: FontWeight.w600),
                                    //             ),
                                    //             SizedBox(
                                    //               height: scrHeight * 0.018,
                                    //             ),
                                    //             Text(
                                    //               "0",
                                    //               style: TextStyle(
                                    //                   fontSize: scrWidth * 0.07,
                                    //                   color: Colors.white,
                                    //                   fontFamily: 'Urbanist',
                                    //                   fontWeight: FontWeight.w700),
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Text(
                                      "Products",
                                      style: TextStyle(
                                          fontSize: scrWidth * 0.04,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 20,),
                                    Row(
                                      children: [

                                        InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductsPage(
                                                          storeId:
                                                              store[0].storeId!, storemodel: store[0],
                                                        )));

                                            setState(() {});
                                          },
                                          child: Container(
                                            height: scrHeight * 0.1,
                                            width: scrWidth * 0.4,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF3F3F3),
                                                borderRadius: BorderRadius.circular(
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
                                                        fontSize: scrWidth * 0.035,
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
                                                        fontSize: scrWidth * 0.06,
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
                                ),
                            )
                    :store[0].rejected==true
                    ?Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.06,right: scrWidth*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: scrHeight * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(store[0].storeName!,style: TextStyle(
                              fontSize: scrWidth * 0.045,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),),
                          Row(
                            children: [
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>StoreEditPage(storemodel: store[0],
                                      update: true,)));
                              }, icon: Icon(Icons.edit)),
                              Text(
                                store[0].online! ? "(online)" : "(offline)",
                                style: GoogleFonts.urbanist(
                                    fontSize: scrWidth * 0.028,
                                    fontWeight: FontWeight.w600),
                              ),
                              Transform.scale(
                                scale: 0.7,
                                child: CupertinoSwitch(
                                  thumbColor:store[0].online!
                                      ? Color(0xff02B558)
                                      : Color(0xffE54D3C),
                                  activeColor: Color(0xffD9D9D9),
                                  trackColor: Color(0xffD9D9D9),
                                  value: store[0].online!,
                                  onChanged: (value) {
                                    // print(widget.storeId);

                                    FirebaseFirestore
                                        .instance
                                        .collection('stores')
                                        .doc(store[0].storeId)
                                        .update(
                                        {
                                          'online':!store[0].online!,
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
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: scrHeight * 0.3,
                          width: scrWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Color(0xffF3F3F3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                              padding:
                              EdgeInsets.only(left: scrWidth * 0.02),
                              child: Column(
                                children: [
                                  SizedBox(height: 40,),
                                  Text("Strore Rejected",style: TextStyle(fontSize: 23,fontFamily: 'Urbanist',fontWeight: FontWeight.w600),),
                                  SizedBox(height: 30,),

                                  Text(store[0].rejectedReason??"",)
                                ],
                              )
                          ),
                        ),
                      )


                        ],
                      ),
                )
                    :store[0].block==true
                    ?Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.06,right: scrWidth*0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: scrHeight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: scrHeight * 0.3,
                          width: scrWidth * 0.8,
                          decoration: BoxDecoration(
                              color: Color(0xffF3F3F3),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                              padding:
                              EdgeInsets.only(left: scrWidth * 0.02),
                              child: Column(
                                children: [
                                  SizedBox(height: 40,),
                                  Text("Strore Blocked",style: TextStyle(fontSize: 23,fontFamily: 'Urbanist',fontWeight: FontWeight.w600),),
                                  SizedBox(height: 30,),


                                  Text(store[0].blockedReason??"",style: TextStyle(),)
                                ],
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    :InkWell(
                  onTap: (){
                    showSnackbar(context, "Please Wait for The store Verification ");
                  },
                      child: Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.06,right: scrWidth*0.06),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: scrHeight * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(store[0].storeName!,style: TextStyle(
                                fontSize: scrWidth * 0.045,
                                color: Colors.grey,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),),
                            Row(
                              children: [
                                IconButton(onPressed: (){
                                  // Navigator.push(context, MaterialPageRoute(
                                  //     builder: (context)=>StoreEditPage(storemodel: store[0],
                                  //       update: true,)));
                                }, icon: Icon(Icons.edit,color: Colors.grey,)),
                                Text(
                                  store[0].online! ? "(online)" : "(offline)",
                                  style: GoogleFonts.urbanist(
                                    color: Colors.grey,
                                      fontSize: scrWidth * 0.028,
                                      fontWeight: FontWeight.w600),
                                ),
                                Transform.scale(
                                  scale: 0.7,
                                  child: CupertinoSwitch(
                                    thumbColor: Colors.grey,
                                    activeColor:Colors.grey ,
                                    trackColor: Colors.grey,

                                     value: store[0].online!,
                                    onChanged: (value) {
                                      // print(widget.storeId);
                                      //
                                      // FirebaseFirestore
                                      //     .instance
                                      //     .collection('stores')
                                      //     .doc(store[0].storeId)
                                      //     .update(
                                      //     {
                                      //       'online':!store[0].online!,
                                      //     }
                                      // );
                                      // setState(() {
                                      //
                                      // });
                                    },
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Overview",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  fontFamily: 'Urbanist',
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),

                            Text(
                              "Today",
                              style: TextStyle(
                                  fontSize: scrWidth * 0.03,
                                  color: Colors.grey,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                        SizedBox(
                          height: scrHeight * 0.013,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: ()  {
                                // await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             Orders(
                                //               storeId:
                                //               store[0].storeId!,
                                //             )));
                                //
                                // setState(() {});
                              },
                              child: Container(
                                height: scrHeight * 0.11,
                                width: scrWidth * 0.4,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 128, 54, 0.33),
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
                                            fontSize: scrWidth * 0.04,
                                            color: Colors.white,
                                            fontFamily: 'Urbanist',
                                            fontWeight:
                                            FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: scrHeight * 0.018,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            orders.length.toString(),
                                            style: TextStyle(
                                                fontSize:
                                                scrWidth * 0.07,
                                                color: Colors.white,
                                                fontFamily:
                                                'Urbanist',
                                                fontWeight:
                                                FontWeight.w700),
                                          ),
                                          SizedBox(
                                            width: scrWidth * 0.18,
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
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             SalesPage()));
                              },
                              child: Container(
                                  height: scrHeight * 0.11,
                                  width: scrWidth * 0.4,
                                  decoration: BoxDecoration(
                                      color:Color.fromRGBO(0, 128, 54, 0.33),
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
                                          "Sale",
                                          style: TextStyle(
                                              fontSize:
                                              scrWidth * 0.04,
                                              color: Colors.white,
                                              fontFamily: 'Urbanist',
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: scrHeight * 0.018,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                store[0].totalSales ==
                                                    null
                                                    ? "₹${0.toStringAsFixed(2)}"
                                                    : "₹${store[0].totalSales!.toStringAsFixed(2)}",
                                                style: TextStyle(
                                                    fontSize:
                                                    scrWidth *
                                                        0.05,
                                                    color:
                                                    Colors.white,
                                                    fontFamily:
                                                    'Urbanist',
                                                    fontWeight:
                                                    FontWeight
                                                        .w700),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: scrWidth * 0.14,
                                            // ),
                                            // SvgPicture.asset(
                                            //     "assets/circlearrow.svg"),
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       right: scrWidth * 0.46,
                        //       top: scrHeight * 0.026),
                        //   child: InkWell(
                        //     onTap: () {},
                        //     child: Container(
                        //       height: scrHeight * 0.11,
                        //       width: scrWidth * 0.4,
                        //       decoration: BoxDecoration(
                        //           color: Color(0xff02B558),
                        //           borderRadius: BorderRadius.circular(
                        //               scrWidth * 0.06)),
                        //       child: Padding(
                        //         padding: EdgeInsets.only(
                        //             left: scrWidth * 0.05),
                        //         child: Column(
                        //           crossAxisAlignment:
                        //               CrossAxisAlignment.start,
                        //           children: [
                        //             SizedBox(
                        //               height: scrHeight * 0.02,
                        //             ),
                        //             Text(
                        //               "Store Views",
                        //               style: TextStyle(
                        //                   fontSize: scrWidth * 0.04,
                        //                   color: Colors.white,
                        //                   fontFamily: 'Urbanist',
                        //                   fontWeight: FontWeight.w600),
                        //             ),
                        //             SizedBox(
                        //               height: scrHeight * 0.018,
                        //             ),
                        //             Text(
                        //               "0",
                        //               style: TextStyle(
                        //                   fontSize: scrWidth * 0.07,
                        //                   color: Colors.white,
                        //                   fontFamily: 'Urbanist',
                        //                   fontWeight: FontWeight.w700),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Text(
                          "Products",
                          style: TextStyle(
                              fontSize: scrWidth * 0.04,
                              fontFamily: 'Urbanist',
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [

                            InkWell(
                              onTap: ()  {
                                // await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ProductsPage(
                                //               storeId:
                                //               store[0].storeId!,
                                //             )));
                                //
                                // setState(() {});
                              },
                              child: Container(
                                height: scrHeight * 0.1,
                                width: scrWidth * 0.4,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(0, 128, 54, 0.33),
                                    borderRadius: BorderRadius.circular(
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
                                          color: Colors.white,
                                            fontSize: scrWidth * 0.035,
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
                                            fontSize: scrWidth * 0.06,
                                            fontFamily: 'Urbanist',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
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
                  ),
                ),
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
      ),
    );
  }
}

class HomePage {}
