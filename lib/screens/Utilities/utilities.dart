import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threems/screens/Utilities/services_subcategory.dart';
import 'package:threems/screens/home_screen.dart';
import 'package:threems/screens/splash_screen.dart';
import 'dart:io';

import '../../Buy&sell/shopheadimageslider.dart';
import '../../model/service category.dart';
import '../../utils/themes.dart';
import '../../widgets/head_image_slider.dart';
import 'details.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> {
  // List services = [
  //   {
  //     'serviceName':'Salone & Spa',
  //     'image':"assets/images/salone.svg",
  //     'subCategories':[
  //       {
  //
  //       }
  //     ]
  //
  //
  //   },
  //   {
  //     'serviceName':'Appliance Repair & Service',
  //     'image':'assets/images/appliance.svg',
  //   },
  //   {
  //     'serviceName':'Cleaning & Pest Control',
  //     'image':'assets/images/cleaning.svg',
  //   },
  //   {
  //     'serviceName':'Electrician, Plumber & Carpenters',
  //     'image':'assets/images/electrician.svg',
  //   },
  //   {
  //     'serviceName':'Home Painting',
  //     'image':'assets/images/painter.svg',
  //   },
  //   {
  //     'serviceName':'Vehicle Service',
  //     'image':'assets/images/vehicleservice.svg',
  //   },
  //   {
  //     'serviceName':'Driver',
  //     'image':'assets/images/painter.svg',
  //   },
  //   {
  //     'serviceName':'Masons',
  //     'image':'assets/images/painter.svg',
  //   },
  //   {
  //     'serviceName':'Carpenter',
  //     'image':'assets/images/painter.svg',
  //   },
  //
  // ];
  String currentAddress = 'Perinthalmanna';

  // List<ServiceCategory>? categories;
  List? categories = [];

  // getCategory() {
  //   FirebaseFirestore.instance
  //       .collection('serviceCategory')
  //       .snapshots()
  //       .listen((event) {
  //     categories = [];
  //     for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
  //       categories!.add(ServiceCategory.fromJson(doc.data()!));
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }
  getCategory() {
    FirebaseFirestore.instance
        .collection('serviceCategory')
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        categories = [];
        for (DocumentSnapshot data in event.docs) {
          categories?.add(data);
        }
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
          leading: InkWell(
            onTap: () {
              // _determinePosition();
            },
            child: Container(
              height: 30,
              width: 30,
              child: Padding(
                padding: EdgeInsets.only(
                  top: scrHeight * 0.03,
                  left: scrWidth * 0.07,
                  bottom: scrHeight * 0.01,
                ),
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
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: scrWidth * 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.85,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categories!.length,
                      padding: EdgeInsets.only(
                          top: 25, bottom: 15, left: 20, right: 15),
                      itemBuilder: (BuildContext context, int index) {
                        return categories!.isEmpty
                            ? Container(
                                child: Center(
                                  child: Text(
                                    "No  Category",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceSubcategoryPage(
                                                serviceCategoryName:
                                                    categories![index]
                                                        ['serviceCategory'],
                                                image: categories![index]
                                                    ['image'],
                                                serviceId:
                                                    categories![index].id,
                                              )));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => ServiceDetailesPage(
                                  //               category: categories![index]
                                  //                   .serviceCategory!,
                                  //             )));
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Color(0xffF3F3F3),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.network(
                                            categories![index]['image'],
                                            height: 55,
                                            width: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: scrHeight * 0.04,
                                      child: Center(
                                        child: Text(
                                          categories![index]['serviceCategory'],
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.029,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ),
                  SizedBox(
                    height: scrWidth * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: scrWidth * 0.045, right: scrWidth * 0.045),
                    child: Text(
                      "Sponsered Ads",
                      style: TextStyle(
                          fontSize: scrWidth * 0.046,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: scrWidth * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: scrWidth * 0.045,
                        right: scrWidth * 0.045,
                        top: scrWidth * 0.025),
                    height: scrHeight * .18,
                    width: scrWidth * 1,
                    child: ImageSlide(type: 'utilities'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
