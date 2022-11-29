import 'dart:convert';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_firestore_flutter/geo_firestore_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/shopheadimageslider.dart';
import 'package:threems/Buy&sell/storedetailsfill.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';
import 'package:threems/Buy&sell/storepage.dart';
import 'package:threems/Buy&sell/yourstorecreate.dart';

import 'dart:ui' as ui;
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';
import '../screens/home_screen.dart';
import '../utils/dummy.dart';
import 'Orders/Orders.dart';
import 'categorystores.dart';
import 'checkout.dart';

List<String> cateoryNames=[];
// getBag() {
//   FirebaseFirestore.instance
//       .collection('users')
//       .doc(currentuserid).update({
//     'cart':cartlist
//
//   });
// }

class BuyAndSell extends StatefulWidget {
  final int index;
  const BuyAndSell({Key? key, required this.index}) : super(key: key);

  @override
  State<BuyAndSell> createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell>with TickerProviderStateMixin {
  String currentAddress = 'Select Your Location';
  Position? currentposition;
  int activeindex=0;
  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     Fluttertoast.showToast(msg: 'Please enable Your Location Service');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       Fluttertoast.showToast(msg: 'Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     Fluttertoast.showToast(
  //         msg:
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //
  //   try {
  //     List<Placemark> placemarks =
  //     await placemarkFromCoordinates(position.latitude, position.longitude);
  //
  //     Placemark place = placemarks[0];
  //
  //     setState(() {
  //       currentposition = position;
  //       currentAddress = "${place.locality}";
  //       //" ${place.postalCode},"
  //       //" ${place.country}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  //   throw '';
  //
  // }
  List<Map<String,dynamic>> location=[];
  // getLocations(){
  //   FirebaseFirestore.instance.collection('stores').snapshots().listen((event) {
  //     location=[];
  //     for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs ){
  //       location.add(doc.data()!);
  //     }
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //   });
  // }
  // getArea(Map<String,dynamic> selectedAddress) async {
  //   selectedArea = "";
  //   selectedAreaId = "";
  //   if(selectedAddress.keys.length>0) {
  //     double lat = selectedAddress['lat'];
  //     double lng = selectedAddress['long'];
  //     double distance = 0;
  //     double prevDistance = 0;
  //     for (Map<String, dynamic> area in location) {
  //       var result = await http.get(Uri.parse(
  //           "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$lat,"
  //               "$lng&destinations=${area['lat']},"
  //               "${area['long']}&key=AIzaSyCUZFUZ1yMpkzh6QUnKj54Q2N4L2iT4tBY"));
  //       Map<String, dynamic> map = jsonDecode(result.body);
  //
  //       if (map['rows'].length > 0) {
  //         if (map['rows'][0]["elements"].length > 0) {
  //           mapDeliveryData = map['rows'][0]["elements"][0];
  //           distance = double.tryParse(
  //               mapDeliveryData['distance']['value'].toString());
  //         }
  //       }
  //       if (distance < prevDistance || prevDistance==0) {
  //
  //         if(area['arearadius']>(distance/1000)) {
  //           prevDistance = distance;
  //           selectedArea = area['name'];
  //           selectedAreaId = area['areaId'];
  //           adminApproval = area['adminApproval']??false;
  //         }
  //       }
  //     }
  //   }
  // }
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String,dynamic> categorys={};
  // List<String> cateoryNames=[];
  int status=0;
  List<Widget> grids=[];
  getSpecificCategory(){
    FirebaseFirestore
        .instance
        .collection('storeCategory')
        .snapshots()
        .listen((event) {
      cateoryNames=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        categorys[doc.get('categoryName')]=doc.data();
        cateoryNames.add(doc.get('categoryName'));
        print("----------------------------------------------------------------------------------------");
        print(categorys[doc['categoryName']]);
        print(doc.get('categoryImage'));
        grids.add(
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryStores(categoryname:doc.get('categoryName'),
                )));
              },
              child: Container(
                height: scrWidth*0.3,
                child: Column(
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      radius: Radius.circular(scrWidth*0.06),
                      dashPattern: [3, 3],
                      color: Colors.grey,
                      strokeWidth: 0.5,
                      child: Center(child: Padding(
                        padding: EdgeInsets.all(scrWidth*0.04),
                        child:Container(
                          height: 27,
                            width: 27,
                            child: SvgPicture.network(doc.get('categoryImage')))
                        // Image.network(doc.get('categoryImage'))
                        // SvgPicture.network(
                        // doc.get('categoryImage'),height:scrHeight*0.03,width: scrWidth*0.04,),
                      )),
                    ),
                    SizedBox(height: scrHeight*0.004,),
                    Container(
                      width: scrWidth*0.15,
                      child: Text(doc.get('categoryName'),textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: scrWidth*0.025,fontWeight: FontWeight.w600,color: Colors.black,fontFamily: 'Urbanist'
                        ),),
                    )

                  ],
                ) ,
              ),
            )

        );

        // cateoryNames.add(categorys[doc.get('categoryName').toString()]);
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  List shops=[];
  List products=[];
  getShop(){
    FirebaseFirestore
        .instance
        .collection('stores')
        .where('userId',isEqualTo: currentuserid)
        .snapshots()
        .listen((event) {
      shops=[];
      var data=event.docs;
      for(dynamic item in data){
        shops.add(item);
      }
      if(data.length>0){
        status=1;
      }
      print('sneha ${shops.length}');
      print(currentuserid);
      FirebaseFirestore.instance.collection('stores').doc(data[0]['storeId']).collection('products').snapshots().listen((event2) {
        products=[];

        var data2=event2.docs;

        for(dynamic item in data2){
          products.add(item);
        }
        if(products.length>0){
          status=2;
          Future.delayed(Duration(seconds: 3)).whenComplete((){
            print('23456789');
            status=3;
            setState(() {

            });
          });
        }
        if(mounted){
          setState(() {});
        }
      });
      if(mounted){
        setState(() {

        });
      }


    });
  }

 bool isstorenotcreated=true;
 bool isstorecreatedcmplt=false;
  List<Sproducts> sproduct=[
    Sproducts(price: 234,
        productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        storename: "Bavya Store", productname: "Surf Ecxl"),
    Sproducts(price: 234,
        productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        storename: "Bavya Store", productname: "Surf Ecxl"),
    Sproducts(price: 234,
        productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        storename: "Bavya Store", productname: "Surf Ecxl"),
    Sproducts(price: 234,
        productimage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3YhxUEFTHw7Q7YAzXp7AG7-oqE6AI5x8O8Q&usqp=CAU",
        storename: "Bavya Store", productname: "Surf Ecxl"),
  ];
  List<NearStore> nstore=[
    NearStore(image: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery"),
    NearStore(image: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery"),
    NearStore(image: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery"),
    NearStore(image: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery"),
  ];
  List<Category> category=[
    Category(categoryimage: "assets/icons/grocery.svg",
        categoryname:"Grocery Stores"),
    Category(categoryimage: "assets/icons/fashion.svg",
        categoryname:"Fashion Apparels"),
    Category(categoryimage: "assets/icons/mobile.svg",
        categoryname:"Mobiles & Electronics"),
    Category(categoryimage: "assets/icons/fruits.svg",
        categoryname:"Fruits & Vegetables"),
    Category(categoryimage: "assets/icons/medicines.svg",
        categoryname:"Pharmacy & Medicines"),
    Category(categoryimage: "assets/icons/meat.svg",
        categoryname:"Chicken & Meat"),
    Category(categoryimage: "assets/icons/tools.svg",
        categoryname:"Hardwares & Tools"),
    Category(categoryimage: "assets/icons/bakery.svg",
        categoryname:"Bakery & Cake Shops"),
    Category(categoryimage: "assets/icons/homedeco.svg",
        categoryname:"Home Decoration"),
    Category(categoryimage: "assets/icons/books.svg",
        categoryname:"Books & Stationery"),
    Category(categoryimage: "assets/icons/golds.svg",
        categoryname:"Jewellery & Golds"),
    Category(categoryimage: "assets/icons/moto.svg",
        categoryname:"Moto Accessories"),
  ];
  late TabController _tabController;
  bool loading =false;
  bool isShopNotCreated = false;
  @override
  void initState() {
    // getLocations();
    getSpecificCategory();
    getShop();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.index??0);
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
        toolbarHeight: scrHeight*0.1,
        shadowColor: Colors.grey,
        leadingWidth: 50,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: Container(
          height: 30,
          width: 30,
          child: Padding(
            padding: EdgeInsets.only(top: scrHeight * 0.03,
                left: scrWidth * 0.07,
                bottom: scrHeight * 0.01,
                ),
            child: SvgPicture.asset("assets/icons/locationicon.svg",),
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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckOutPage()));
            },
            child: Badge(
              position: BadgePosition.topEnd(top: scrHeight*0.03, end: scrHeight*0.015,),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.fade,
              badgeColor: Colors.black,
              badgeContent: Text('${cartlist.length}',
                style: TextStyle(color: Colors.white,fontSize: scrWidth*0.02),
              ),
              child: Padding(
                  padding: EdgeInsets.only(right: scrWidth*0.06,top: scrHeight*0.015),
                  child: SvgPicture.asset("assets/images/cart.svg"),
                )
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: scrHeight * 0.015,),
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
                  Text("SHOP NOW", style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: scrWidth*0.04,
                      fontWeight: FontWeight.w700
                  ),),
                  Text("MY STORE", style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize:scrWidth*0.04 ,
                      fontWeight: FontWeight.w700
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: [
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
                          SizedBox(height: scrHeight * 0.02,),
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
                          SizedBox(height: scrHeight*0.01,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: scrWidth * 0.07,),
                              Padding(
                                padding: EdgeInsets.only(top: scrHeight*0.01),
                                child: SvgPicture.asset("assets/images/nearstore.svg"),
                              ),
                              SizedBox(width: scrWidth * 0.03,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Your Nearest Stores", style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: scrWidth * 0.04,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Text("0 Stores available", style: TextStyle(
                                      fontFamily: 'Urbanist',
                                      fontSize: scrWidth*0.025,
                                      color: Color(0xff818181),
                                      fontWeight: FontWeight.w600
                                  ),),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: scrHeight*0.015,),
                          SizedBox(height:50,),

                          Text("No Stores"),
                          SizedBox(height: 50,),
                          // Padding(
                          //   padding:  EdgeInsets.only(left: scrWidth*0.037,right: scrWidth*0.037),
                          //   child: Container(
                          //     height: scrHeight*0.15,
                          //     child: ListView.builder(
                          //         physics: BouncingScrollPhysics(),
                          //         scrollDirection: Axis.horizontal,
                          //         shrinkWrap: true,
                          //         itemCount:nstore.length,
                          //         itemBuilder: (context, index) {
                          //           return Padding(
                          //             padding: EdgeInsets.only(right: scrWidth*0.017),
                          //             child: Column(
                          //               crossAxisAlignment: CrossAxisAlignment.start,
                          //               children: [
                          //                 InkWell(
                          //                   child: Padding(
                          //                     padding: EdgeInsets.only(
                          //                         left: scrWidth*0.03),
                          //                     child: Container(
                          //                       height:scrHeight*0.09,
                          //                       width: scrWidth*0.22,
                          //                       decoration: BoxDecoration(
                          //                         image: DecorationImage(image:
                          //                         NetworkImage(nstore[index].image),
                          //                             fit: BoxFit.fill),
                          //                         color: Colors.white,
                          //
                          //                         borderRadius: BorderRadius.circular(
                          //                             scrWidth*0.03),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: EdgeInsets.only(left: scrWidth*0.04),
                          //                   child: Column(
                          //                     crossAxisAlignment: CrossAxisAlignment
                          //                         .start,
                          //                     children: [
                          //                       SizedBox(height: scrHeight*0.002,),
                          //                       Text(
                          //                         nstore[index].storename, textAlign: TextAlign.center,
                          //                         style: TextStyle(
                          //                             fontFamily: 'Urbanist',
                          //                             fontSize: scrWidth*0.032,
                          //                             fontWeight: FontWeight.w600,
                          //                             color: Color(0xff0E0E0E)),),
                          //                       SizedBox(height: scrHeight*0.0015,),
                          //                       Text(
                          //                         nstore[index].category, textAlign: TextAlign.center,
                          //                         style: TextStyle(
                          //                             fontFamily: 'Urbanist',
                          //                             fontSize: scrWidth*0.025,
                          //                             fontWeight: FontWeight.w600,
                          //                             color: Color(0xff818181)),),
                          //
                          //                     ],
                          //                   ),
                          //                 ),
                          //
                          //
                          //               ],
                          //             ),
                          //           );
                          //         }
                          //     ),
                          //   ),
                          // ),

                          GestureDetector(
                            onTap: (){
                               Navigator.push(context,MaterialPageRoute(builder: (context)=>YourStoreCreatePage()));
                            },
                            child: Container(
                              height: scrHeight*0.045,
                              width:scrHeight*0.35,
                              decoration: BoxDecoration(
                                  color: primarycolor,
                                  borderRadius: BorderRadius.circular(scrWidth*0.02)
                              ),
                              child: Center(
                                child: Text(
                                  "View all nearest stores", style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700,
                                    fontSize: scrWidth*0.04
                                ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: scrHeight*0.03,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: scrWidth * 0.08,),
                              Padding(
                                padding:  EdgeInsets.only(top:scrHeight*0.005 ),
                                child: SvgPicture.asset("assets/images/nearstore.svg"),
                              ),
                              SizedBox(width: scrWidth * 0.03,),
                              Text("Categories", style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: scrWidth * 0.04,
                                  fontWeight: FontWeight.w600
                              ),),

                            ],
                          ),
                          SizedBox(height: scrHeight*0.03,),
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
                          grids.isEmpty?CircularProgressIndicator():Container(

                            child: Padding(
                              padding:  EdgeInsets.only(left: 10,right: 10),
                              child: GridView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3 / 4,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 25,
                                  crossAxisCount: 4,
                                ),
                                children:grids
                              ),
                            ),
                          ),


                          // ElevatedButton(onPressed: (){
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                          // }, child: Text("uhsdhw")),
                          // SizedBox(height: 100,),

                        ],

                      ),
                    ),
                     status==0?
                     Column(
                      children: [
                        SizedBox(height: scrHeight * 0.03,),
                        DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(23),
                            dashPattern: [3, 2],
                            child: SvgPicture.asset("assets/icons/shop.svg")
                        ),
                        SizedBox(height: scrHeight * 0.01,),
                        Text("Build your own online store \nhassle free!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Urbanist',
                              fontSize: scrWidth * 0.03,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff615C5C)),),
                        SizedBox(height: scrHeight * 0.02,),
                        DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(23),
                            dashPattern: [3, 2],
                            child: SvgPicture.asset("assets/icons/lens.svg")
                        ),
                        SizedBox(height: scrHeight * 0.01,),
                        Text(
                          "Manage orders and track your \nbusiness on the go!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Urbanist',
                              fontSize: scrWidth * 0.03,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff615C5C)),),
                        SizedBox(height: scrHeight * 0.02,),
                        DottedBorder(
                            borderType: BorderType.Circle,
                            radius: Radius.circular(12),
                            padding: EdgeInsets.all(23),
                            dashPattern: [3, 2],
                            child: SvgPicture.asset(
                                "assets/icons/featuresicon.svg")
                        ),
                        SizedBox(height: scrHeight * 0.01,),
                        Text(
                          "Get all the features to grow \nyour online business",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Urbanist',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff615C5C)),),
                        SizedBox(height: scrHeight * 0.03,),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => StoreDetails()));
                          },
                          child: Container(
                            height: scrHeight * 0.05,
                            width: scrWidth * 0.6,
                            decoration: BoxDecoration(
                                color: primarycolor,
                                borderRadius: BorderRadius.circular(21.5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, size: scrWidth * 0.045,
                                  color: Colors.white,),
                                Text(
                                  "Create Store", textAlign: TextAlign.center,
                                  style: TextStyle(fontFamily: 'Urbanist',
                                      fontSize: scrWidth * 0.045,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),),
                              ],
                            ),
                          ),
                        )
                      ],
                    ):
                     (status==1)?
                     Column(
                       children: [
                         SizedBox(height: scrHeight * 0.02,),
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
                             borderRadius:
                             BorderRadius.circular(21),
                           ),
                           child: Column(
                             children: [
                               SizedBox(height: scrHeight * 0.02,),
                               Text("50%", textAlign: TextAlign.center,
                                 style: TextStyle(fontFamily: 'Urbanist',
                                     fontSize: scrWidth * 0.07,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.black),),
                               SizedBox(height: scrHeight * 0.009,),

                               LinearPercentIndicator(
                                 //leaner progress bar
                                 animation: true,
                                 animationDuration: 1000,
                                 lineHeight: scrHeight * 0.021,
                                 width: scrWidth * 0.77,
                                 percent: 0.5,
                                 alignment: MainAxisAlignment.start,
                                 barRadius: Radius.circular(scrWidth * 0.2),
                                 progressColor: primarycolor,
                                 backgroundColor: Color(0xffD9D9D9),
                               ),
                               SizedBox(height: scrHeight * 0.02,),

                               Text("Store setup is completed",
                                 textAlign: TextAlign.center,
                                 style: TextStyle(fontFamily: 'Urbanist',
                                     fontSize: scrWidth * 0.04,
                                     fontWeight: FontWeight.w600,
                                     color: Colors.black),),
                             ],
                           ),
                         ),
                         SizedBox(height: scrHeight * 0.02,),
                         Padding(
                           padding:  EdgeInsets.only(left: 10,right: 10),
                           child: Container(
                             height: scrHeight*0.32,
                             width: scrWidth*0.8,
                             decoration: BoxDecoration(
                                 color: Color(0xffF3F3F3),

                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child: Padding(
                               padding:  EdgeInsets.only(left: scrWidth*0.05),
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
                                       borderRadius: BorderRadius.circular(30),
                                       // border:activeindex==0? Border.all(color: primarycolor,width: 2):Border.all(color: Colors.transparent)
                                     ),
                                     child: Padding(
                                       padding: EdgeInsets.only(left: 5,right: 5),
                                       child:SvgPicture.asset("assets/icons/tickmark.svg"),

                                     )

                                 ),
                                 stepperList: [
                                   StepperData(
                                     title: "Create online store",
                                     subtitle: "Congratulations on opening your new \nonline store!",
                                   ),
                                   StepperData(
                                     title: "Add Product",
                                     subtitle: "Create your first product by adding the \nproduct name and images.",
                                   ),
                                 ],
                                 horizontalStepperHeight:200,
                                 stepperDirection: Axis.vertical,
                                 inActiveBarColor: primarycolor,
                                 activeIndex: activeindex,
                                 barThickness: 2,
                                 activeBarColor: primarycolor,
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: scrHeight * 0.02,),

                         GestureDetector(
                           onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (
                                 context) => StoreDetailsFill2( data: shops[0],)));
                           },
                           child: Container(
                             height: scrHeight * 0.055,
                             width: scrWidth * 0.55,
                             decoration: BoxDecoration(
                                 color: primarycolor,
                                 borderRadius: BorderRadius.circular(21.5)
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(Icons.add, size: scrWidth * 0.045,
                                   color: Colors.white,),
                                 Text("Add Product", textAlign: TextAlign.center,
                                   style: TextStyle(fontFamily: 'Urbanist',
                                       fontSize: scrWidth * 0.04,
                                       fontWeight: FontWeight.w700,
                                       color: Colors.white),),
                               ],
                             ),
                           ),
                         )
                       ],
                     ):
                     (status==2)?
                     Column(
                       children: [
                         SizedBox(height: scrHeight*0.02,),
                         Container(
                           width: scrWidth*0.8,
                           height: scrHeight*0.15,
                           padding: EdgeInsets.symmetric(
                             horizontal: scrWidth * 0.015,
                             vertical: scrHeight*0.002,
                           ),
                           decoration: BoxDecoration(
                             color: textFormFieldFillColor,
                             // color: Colors.red,
                             borderRadius:
                             BorderRadius.circular(21),
                           ),
                           child: Column(
                             children: [
                               SizedBox(height: scrHeight*0.02,),
                               Text("100%",textAlign: TextAlign.center,
                                 style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.07,fontWeight: FontWeight.w600,
                                     color: Colors.black),),
                               SizedBox(height: scrHeight*0.009,),

                               LinearPercentIndicator(
                                 //leaner progress bar
                                 animation: true,
                                 animationDuration: 1000,
                                 lineHeight: scrHeight*0.021,
                                 width: scrWidth*0.77,
                                 percent: 1,
                                 alignment: MainAxisAlignment.start,
                                 barRadius: Radius.circular(scrWidth*0.2),
                                 progressColor: primarycolor,
                                 backgroundColor: Color(0xffD9D9D9),
                               ),
                               SizedBox(height: scrHeight*0.02,),

                               Text("Store setup is completed",textAlign: TextAlign.center,
                                 style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.04,fontWeight: FontWeight.w600,
                                     color: Colors.black),),
                             ],
                           ),
                         ),
                         SizedBox(height: scrHeight*0.02,),

                         Padding(
                           padding:  EdgeInsets.only(left: 10,right: 10),
                           child: Container(
                             height: scrHeight*0.32,
                             width: scrWidth*0.8,
                             decoration: BoxDecoration(
                                 color: Color(0xffF3F3F3),

                                 borderRadius: BorderRadius.circular(20)
                             ),
                             child: Padding(
                               padding:  EdgeInsets.only(left: scrWidth*0.05),
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
                                       borderRadius: BorderRadius.circular(30),
                                       // border: Border.all(color: primarycolor,width: 2)
                                     ),
                                     child: Padding(
                                       padding: EdgeInsets.only(left: 5,right: 5),
                                       child:SvgPicture.asset("assets/icons/tickmark.svg"),

                                     )

                                 ),
                                 stepperList: [
                                   StepperData(
                                     title: "Create online store",
                                     subtitle: "Congratulations on opening your new \nonline store!",
                                   ),
                                   StepperData(
                                     title: "Add Product",
                                     subtitle: "Create your first product by adding the \nproduct name and images.",
                                   ),
                                 ],
                                 horizontalStepperHeight:200,
                                 stepperDirection: Axis.vertical,
                                 inActiveBarColor: Colors.grey,
                                 activeIndex: 1,
                                 barThickness: 2,
                                 activeBarColor: primarycolor,
                               ),
                             ),
                           ),
                         ),
                         SizedBox(height: scrHeight*0.02,),
                         GestureDetector(
                           onTap: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetailsFill2()));
                           },
                           child: Container(
                             height: scrHeight*0.055,
                             width: scrWidth*0.55,
                             decoration: BoxDecoration(
                                 color: primarycolor,
                                 borderRadius: BorderRadius.circular(21.5)
                             ),
                             child: Center(
                               child: Text("View Store",textAlign: TextAlign.center,
                                 style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.04,fontWeight: FontWeight.w700,
                                     color: Colors.white),),
                             ),
                           ),
                         ),
                       ],
                     ):
                     Column(
                       children: [
                         SizedBox(height: scrHeight*0.02,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Text("Overview",
                               style: TextStyle(
                                   fontSize: scrWidth*0.04,
                                   fontFamily: 'Urbanist',
                                   fontWeight: FontWeight.w600),
                             ),
                             SizedBox(
                               width: scrWidth*0.37,
                             ),
                             Text("LifeTime",
                               style: TextStyle(
                                   fontSize: scrWidth*0.03,
                                   color: Color(0xff6F6E6E),
                                   fontFamily: 'Urbanist',
                                   fontWeight: FontWeight.w600),
                             )
                           ],
                         ),
                         SizedBox(height: scrHeight*0.013,),
                         Padding(
                           padding:  EdgeInsets.only(left: scrWidth*0.035,right: scrWidth*0.035),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                             children: [
                               InkWell(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Orders()));
                                 },
                                 child: Container(
                                   height: scrHeight*0.11,
                                   width:scrWidth*0.4,
                                   decoration: BoxDecoration(
                                       color: Color(0xff02B558),
                                       borderRadius: BorderRadius.circular(scrWidth*0.06)),
                                   child: Padding(
                                     padding:  EdgeInsets.only(left:scrWidth*0.05),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         SizedBox(height: scrHeight*0.02,),
                                         Text("Orders",
                                           style: TextStyle(
                                               fontSize: scrWidth*0.04,
                                               color: Colors.white,
                                               fontFamily: 'Urbanist',
                                               fontWeight: FontWeight.w600),
                                         ),
                                         SizedBox(height: scrHeight*0.018,),

                                         Text("0",
                                           style: TextStyle(
                                               fontSize: scrWidth*0.07,
                                               color: Colors.white,
                                               fontFamily: 'Urbanist',
                                               fontWeight: FontWeight.w700),
                                         )
                                       ],
                                     ),
                                   ),
                                 ),
                               ),
                               Container(
                                   height: scrHeight*0.11,
                                   width:scrWidth*0.4,
                                   decoration: BoxDecoration(
                                       color: Color(0xff02B558),
                                       borderRadius: BorderRadius.circular(scrWidth*0.06)),
                                   child:Padding(
                                     padding:  EdgeInsets.only(left:scrWidth*0.05),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         SizedBox(height: scrHeight*0.02,),
                                         Text("Sale",
                                           style: TextStyle(
                                               fontSize:scrWidth*0.04,
                                               color: Colors.white,
                                               fontFamily: 'Urbanist',
                                               fontWeight: FontWeight.w600),
                                         ),
                                         SizedBox(height: scrHeight*0.018,),

                                         Text("₹0",
                                           style: TextStyle(
                                               fontSize: scrWidth*0.07,
                                               color: Colors.white,
                                               fontFamily: 'Urbanist',
                                               fontWeight: FontWeight.w700),
                                         )
                                       ],
                                     ),
                                   )
                               ),

                             ],
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.only(right:scrWidth*0.46,top: scrHeight*0.026),
                           child: Container(
                             height: scrHeight*0.11,
                             width:scrWidth*0.4,
                             decoration: BoxDecoration(
                                 color: Color(0xff02B558),
                                 borderRadius: BorderRadius.circular(scrWidth*0.06)),
                             child:  Padding(
                               padding:  EdgeInsets.only(left:scrWidth*0.05),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   SizedBox(height: scrHeight*0.02,),
                                   Text("Store Views",
                                     style: TextStyle(
                                         fontSize: scrWidth*0.04,
                                         color: Colors.white,
                                         fontFamily: 'Urbanist',
                                         fontWeight: FontWeight.w600),
                                   ),
                                   SizedBox(height: scrHeight*0.018,),

                                   Text("0",
                                     style: TextStyle(
                                         fontSize: scrWidth*0.07,
                                         color: Colors.white,
                                         fontFamily: 'Urbanist',
                                         fontWeight: FontWeight.w700),
                                   )
                                 ],
                               ),
                             ),
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.only(right:scrWidth*0.65,top:scrHeight*0.02,bottom: scrHeight*0.02),
                           child: Text("Products",
                             style: TextStyle(
                                 fontSize: scrWidth*0.04,
                                 fontFamily: 'Urbanist',
                                 fontWeight: FontWeight.w600),
                           ),
                         ),
                         Row(
                           children: [
                             SizedBox(width: scrWidth*0.08,),
                             Container(
                               height: scrHeight*0.1,
                               width: scrWidth*0.4,
                               decoration: BoxDecoration(
                                   color: Color(0xffF3F3F3),
                                   borderRadius: BorderRadius.circular(scrWidth*0.06)
                               ),
                               child: Padding(
                                 padding:  EdgeInsets.only(left: scrWidth*0.05),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     SizedBox(height: scrHeight*0.02,),
                                     Text("Products",
                                       style: TextStyle(
                                           fontSize: scrWidth*0.035,
                                           fontFamily: 'Urbanist',
                                           fontWeight: FontWeight.w600),
                                     ),
                                     SizedBox(height: scrHeight*0.01,),

                                     Text("01",
                                       style: TextStyle(
                                           fontSize: scrWidth*0.06,
                                           fontFamily: 'Urbanist',
                                           fontWeight: FontWeight.w600),
                                     ),

                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(width: 18,),
                             Container(
                               height: scrHeight*0.1,
                               width: scrWidth*0.4,
                               decoration: BoxDecoration(
                                   color: Color(0xffF3F3F3),
                                   borderRadius: BorderRadius.circular(scrWidth*0.06)
                               ),
                               child: Padding(
                                 padding:  EdgeInsets.only(left: scrWidth*0.05),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     SizedBox(height: scrHeight*0.02,),
                                     Text("Categories",
                                       style: TextStyle(
                                           fontSize: scrWidth*0.035,
                                           fontFamily: 'Urbanist',
                                           fontWeight: FontWeight.w600),
                                     ),
                                     SizedBox(height: scrHeight*0.01,),

                                     Text("02",
                                       style: TextStyle(
                                           fontSize: scrWidth*0.06,
                                           fontFamily: 'Urbanist',
                                           fontWeight: FontWeight.w600),
                                     ),

                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),

                      ],
                     )

                                    //after store created

                  ]
              ),

          )
        ],
      ),
    );
  }
}
