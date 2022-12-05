import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/servicesModel.dart';
import '../../utils/themes.dart';
import '../charity/verification_details.dart';
import '../home_screen.dart';
import '../splash_screen.dart';
import 'AddYouService.dart';
import 'detailesSinglePage.dart';
Position? position;
bool ?editService;
StreamController controller = StreamController<int>.broadcast();
class ServiceDetailesPage extends StatefulWidget {
  final String subCategoryName;
  final String category;
  const ServiceDetailesPage({Key? key, required this.subCategoryName, required this.category, })
      : super(key: key);

  @override
  State<ServiceDetailesPage> createState() => _ServiceDetailesPageState();
}

class _ServiceDetailesPageState extends State<ServiceDetailesPage> {
  String selectedCity2 = '';
  TextEditingController city2 = TextEditingController();
  List<String> serviceCity = [];
  List<ServiceDetails> serviceList=[];
  StreamSubscription<Position>? positionStream;
  Stream? orderStream;
  final geo = Geoflutterfire();
  late GeoFirePoint center;
  // getService() {
  //   FirebaseFirestore.instance
  //       .collection('services')
  //       .where('subCategory', isEqualTo: widget.subCategoryName)
  //       .snapshots()
  //       .listen((event) {
  //     serviceList = [];
  //     for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
  //       serviceList!.add(ServiceDetails.fromJson(doc.data()!));
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }
  int s1=0;
  getService() {
    print("details lat and long");
    print(lat);
    print(long);
    center = geo.point(latitude: lat!, longitude: long!);
    var collectionReference =  FirebaseFirestore.instance
        .collection('services')
        .where('subCategory', isEqualTo: widget.subCategoryName);
       double? radius = 100;
       String field = 'position';
       print(field);
    // Stream<List<DocumentSnapshot>>
       geo.collection(collectionRef: collectionReference  )
        .within(center: center, radius: radius, field: field,strictMode: true).listen((event) {
       serviceList = [];
       for (var doc in event) {
        serviceList!.add(ServiceDetails.fromJson(doc.data()!));
      }
      s1 =event.length;
       print(s1);
       print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");


         if (mounted) {
           setState(() {});
         }
    });
  }
  @override
  void initState() {
    super.initState();
    getService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 40,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: tabBarColor,

        title: Text(
          widget.subCategoryName,
          style: TextStyle(
              fontSize: scrWidth * 0.046,
              color: Colors.white,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: scrWidth * 0.038,
                top: scrHeight * 0.04,
                bottom: scrHeight * 0.02),
            child: InkWell(
              onTap: () {
                editService=false;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddServicePage(
                        subCategoryName:widget.subCategoryName,
                        Category:widget.category
                        )));
              },
              child: Container(
                height: scrHeight * 0.07,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 11,
                      color:primarycolor
                    ),
                    Text(
                      "Create New",
                      style: TextStyle(
                          color: primarycolor,
                          fontSize: CreateChitFont,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
                height: MediaQuery.of(context).size.height,
                child: serviceList?.length==0
                    ? Center(
                        child: Text('No list Found',style: GoogleFonts.urbanist(
                          fontSize: 15
                        ),),
                      )
                    : serviceList.isEmpty?CircularProgressIndicator():ListView.builder(
                        padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.05,
                        ),
                        itemCount: serviceList?.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final serviceItems = serviceList?[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              bottom: 10,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => detailesSinglePage(
                                            // subCategoryName: subcategories[index]['sub'],
                                            // category: widget.serviceCategoryName,
                                            services:serviceItems

                                            // image:categories![index]['image'],
                                            // serviceId:categories![index].id,

                                          )));
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE3F2FD),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  serviceItems!.image.toString(),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                     Expanded(child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       crossAxisAlignment: CrossAxisAlignment.start,

                                       children: [
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           crossAxisAlignment: CrossAxisAlignment.start,

                                           children: [
                                             Text(
                                               'Name : ${serviceItems.name.toString()}',
                                               style: GoogleFonts.urbanist(
                                                   fontSize: 14),
                                             ),
                                             SizedBox(
                                               height: 15,
                                             ),
                                             Text(
                                               'Wage : ${serviceItems.wage} / ${serviceItems.serviceUnit}',
                                               style: GoogleFonts.urbanist(
                                                   fontSize: 14),
                                             ),
                                           ],
                                         ),
                                         InkWell(
                                             onTap: () {
                                               Uri call = Uri.parse(
                                                   'tel://${serviceList![index].phoneNumber!}');

                                               launchUrl(call);
                                             },
                                             child: Padding(
                                               padding: const EdgeInsets.only(top: 5.0),
                                               child: CircleAvatar(
                                                 backgroundColor: tabBarColor,
                                                   child: Icon(Icons.phone,color: Colors.white,size: 25,)),
                                             )),
                                       ],
                                     ))

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
