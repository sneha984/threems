import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:threems/model/charitymodel.dart';
import 'package:threems/screens/charity/paymentdetailspage.dart';

import '../../utils/themes.dart';
import '../../widgets/flchart.dart';
import '../splash_screen.dart';
import 'basic_details.dart';
import 'fundrisingdasgboard2.dart';



class FundRaisingDashboard extends StatefulWidget {
  final CharityModel charity;

  const FundRaisingDashboard({Key? key, required this.charity}) : super(key: key);

  @override
  State<FundRaisingDashboard> createState() => _FundRaisingDashboardState();
}

class _FundRaisingDashboardState extends State<FundRaisingDashboard>with TickerProviderStateMixin {


  String? _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  final String dynamicLink = 'https://threems.page.link';
  final String link = 'https://threems.page.link/kuri_Invite';
  CharityModel? chari;
  getDonation(){
    FirebaseFirestore
        .instance
        .collection('charity').doc(widget.charity.charityId).snapshots().listen((event) {
      chari=CharityModel.fromJson(event.data()!);

      if(mounted){
        setState(() {

        });
      }
    });
  }

  late  TabController _tabControllerrs;
  double progressvalue=270.0  ;
  late  TabController _tabController;
  late Timer _timer;
  late final   _random ;
  String? _annotationValue;
  @override
  void initState() {
    _random = Random();
    // _timer = Timer.periodic(const Duration(seconds: 1), (_timer) {
    setState(() {

      int _value = progressvalue.toInt();
      if (_value <360) {
        progressvalue = _value.toDouble();
        _annotationValue = ('${_value/4} %');
      }
    });
    // }
    // );
    _tabControllerrs = TabController(length: 4, vsync: this,initialIndex: 2);
    _tabControllerrs.addListener(_handleTabSelections);
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);

    super.initState();
    getDonation();

  }
  void _handleTabSelection() {
    setState(() {
    });
  }
  void _handleTabSelections() {
    setState(() {
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabControllerrs.dispose();
    _tabController.dispose();

  }
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '??? ',
  );
  @override
  Widget build(BuildContext context) {
    // double sum=0;
    // List payAmount=[];
    // for(int i=0;i<widget.charity.payments!.length;i++){
    //   double x=widget.charity.payments![i].amount!;
    //   payAmount.add(x);
    //   sum=sum+x;
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: chari==null
          ?SizedBox():chari!.block==false?
      //     :(chari!.status==0)
      //     ?Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Stack(
      //       children: [
      //         Container(
      //           height: scrHeight*0.45,
      //           width:scrWidth,
      //           decoration: BoxDecoration(
      //               gradient: LinearGradient(
      //                 begin: Alignment.topCenter,
      //                 end: Alignment.bottomCenter,
      //                 colors: [
      //                   Color(0xffA1FFC9),
      //                   Color(0xffFFFFFF),
      //                 ],
      //               )
      //           ),
      //     ),
      //           Column(
      //             mainAxisSize: MainAxisSize.max,
      //             children: [
      //               Padding(
      //                 padding:  EdgeInsets.only( top: scrHeight*0.09,),
      //                 child: Row(
      //                   children: [
      //                     InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Padding(
      //                         padding: EdgeInsets.only(
      //                           // top: scrHeight * 0.09,
      //                            left: scrWidth * 0.05,
      //                           // bottom: scrHeight * 0.02,
      //                             right: scrWidth * 0.04),
      //                         child: Icon(
      //                           Icons.arrow_back,
      //                           color: Colors.black,
      //                           size: 25,
      //                         ),
      //                       ),
      //                     ),
      //                     Text("Fundraise Dashboard",style: TextStyle(
      //                         fontSize: scrWidth*0.045,
      //                         color: Colors.black,
      //                         fontFamily: 'Urbanist',
      //                         fontWeight: FontWeight.w700),),
      //                     SizedBox(width: scrWidth*0.13,),
      //
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(height: scrHeight*0.03,),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                 children: [
      //                   Text("Recent Charity",style: TextStyle(
      //                       fontSize: scrWidth*0.04,
      //                       color: Colors.black,
      //                       fontFamily: 'Urbanist',
      //                       fontWeight: FontWeight.w500),),
      //                   SizedBox(width: scrWidth*0.39,),
      //                   // GestureDetector(
      //                   //   onTap: (){
      //                   //      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BasicDetails()));
      //                   //   },
      //                   //   child: Text("Edit",style: TextStyle(
      //                   //       fontSize: scrWidth*0.044,
      //                   //       color: Colors.black,
      //                   //       fontFamily: 'Urbanist',
      //                   //       fontWeight: FontWeight.w700),),
      //                   // ),
      //                 ],
      //               ),
      //               SizedBox(height: scrHeight*0.015,),
      //               Container(
      //                 height: scrHeight*0.12,
      //                   width: scrWidth*0.88,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(9),
      //                   color: Colors.white,
      //                 ),
      //                 child: Row(
      //                   children: [
      //                     SizedBox(width: scrWidth*0.02,),
      //                     Container(
      //                       width: scrWidth*0.3,
      //                       height: scrHeight*0.1,
      //                       decoration: BoxDecoration(
      //                         // image: DecorationImage(image: NetworkImage(widget.charity.image??''),fit: BoxFit.fill),
      //                         borderRadius: BorderRadius.circular(10),
      //                         // color: Colors.grey,
      //
      //                       ),
      //                       child: ClipRRect(
      //                         borderRadius: BorderRadius.circular(scrWidth * 0.09),
      //                         child: CachedNetworkImage(
      //                           fit: BoxFit.cover,
      //                           imageUrl:widget.charity?.image??'',
      //                         ),
      //                       ),
      //                     ),
      //
      //
      //                      SizedBox(width:scrWidth*0.03),
      //                     Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         SizedBox(height: scrHeight*0.015,),
      //                         Container(
      //                           width:  scrWidth*0.4,
      //                           child: Text(widget.charity.charityDetailes!,style: TextStyle(
      //                               fontSize: scrWidth*0.033,
      //                               color: Colors.black,
      //                               fontFamily: 'Urbanist',
      //                               fontWeight: FontWeight.w600),),
      //                         ),
      //                         SizedBox(height: scrHeight*0.03,),
      //                         GestureDetector(
      //                           onTap: (){
      //                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>FundRisingdashboardtwo()));
      //                           },
      //                           child: Container(
      //                             width: scrWidth*0.2,
      //                             height: scrHeight*0.023,
      //                             decoration: BoxDecoration(
      //                               borderRadius: BorderRadius.circular(5),
      //                               color: Color(0xffF14336),
      //
      //                             ),
      //                             child: Center(
      //                               child: Text("IN REVIEW",style: TextStyle(
      //                                   fontSize: scrWidth*0.03,
      //                                   color: Colors.white,
      //                                   fontFamily: 'Urbanist',
      //                                   fontWeight: FontWeight.w700),),
      //                             ),
      //                           ),
      //                         )
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //               ),
      //               // InkWell(
      //               //   onTap: () async {
      //               //     await _createDynamicLink(false);
      //               //     Share.share(
      //               //         'Inviting you to join *${widget.charity.charityDetailes}* \n \n \n $_linkMessage');
      //               //   },
      //               //   child: Padding(
      //               //     padding:  EdgeInsets.only(left: scrWidth*0.2),
      //               //     child: SvgPicture.asset("assets/icons/shareicon.svg",),
      //               //   ),
      //               // ),
      //               Padding(
      //                 padding:  EdgeInsets.only(top: scrHeight*0.025,right: scrWidth*0.45),
      //                 child: Text("Recent Charity Progress",style: TextStyle(
      //                     fontSize:  scrWidth*0.04,
      //                     color: Colors.black,
      //                     fontFamily: 'Urbanist',
      //                     fontWeight: FontWeight.w500),),
      //               ),
      //               SizedBox(height: scrHeight*0.01,),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   // Expanded(
      //                   //   child: ClipRect(
      //                   //     child: Align(
      //                   //       heightFactor: 0.35,
      //                   //       child: Padding(
      //                   //         padding:  EdgeInsets.only(left: scrWidth*0.07,right: scrWidth*0.03),
      //                   //         //25
      //                   //         child: SfRadialGauge(
      //                   //             axes: <RadialAxis>[
      //                   //               RadialAxis(
      //                   //                 canScaleToFit: false,
      //                   //                 minimum: 0,
      //                   //                 interval: 1,
      //                   //                 maximum: 360,
      //                   //                 showLabels: false,
      //                   //                 showLastLabel: false,
      //                   //                 showTicks: false,
      //                   //                 startAngle: 270,
      //                   //                 endAngle: 270,
      //                   //                 radiusFactor: 0.95,
      //                   //                 axisLineStyle: AxisLineStyle(
      //                   //                   thickness:0.23,
      //                   //                   color: Colors.grey.withOpacity(0.2),
      //                   //                   thicknessUnit: GaugeSizeUnit.factor,
      //                   //                 ),
      //                   //                 pointers: <GaugePointer>[
      //                   //                   RangePointer(
      //                   //                       value: 0,
      //                   //                       enableAnimation: true,
      //                   //                       animationDuration: 6000,
      //                   //                       animationType: AnimationType.slowMiddle,
      //                   //                       width: 0.23,
      //                   //                       sizeUnit: GaugeSizeUnit.factor,
      //                   //                       cornerStyle: CornerStyle.startCurve,
      //                   //                       gradient: const SweepGradient(colors: <Color>[
      //                   //                         primarycolor,
      //                   //                         Color(0xff96c8aa)
      //                   //                       ],
      //                   //                           stops: <double>[
      //                   //                             0.74,
      //                   //                             1.3
      //                   //                           ])),
      //                   //                   MarkerPointer(
      //                   //                     enableAnimation: true,
      //                   //                     animationDuration: 6000,
      //                   //                     animationType: AnimationType.slowMiddle,
      //                   //                     value: 0,
      //                   //                     markerWidth: 17,
      //                   //                     markerHeight: 17,
      //                   //                     borderWidth:4,
      //                   //                     borderColor:  Color(0xff96c8aa),
      //                   //                     markerType: MarkerType.circle,
      //                   //                     color: Colors.white,
      //                   //                   )
      //                   //                 ],
      //                   //                 annotations:<GaugeAnnotation> [
      //                   //                   GaugeAnnotation(angle: 0,positionFactor: 0.18,
      //                   //                     widget:Text("0%",textAlign: TextAlign.center,style: TextStyle(
      //                   //                         fontSize: 23,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
      //                   //                     ),),
      //                   //                   )
      //                   //
      //                   //                 ],
      //                   //
      //                   //               )
      //                   //             ]),
      //                   //       ),
      //                   //     ),
      //                   //   ),
      //                   // ),
      //                   Padding(
      //                     padding:  EdgeInsets.only(left: scrWidth*0.07,top: scrHeight*0.024,),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         Text("Raised",style: TextStyle(
      //                             fontSize: scrWidth*0.034,
      //                             color: Colors.black,
      //                             fontFamily: 'Urbanist',
      //                             fontWeight: FontWeight.w500),),
      //                         SizedBox(height: scrHeight*0.006,),
      //
      //                         Text("???0",style: TextStyle(
      //                             fontSize: scrWidth*0.05,
      //                             color: primarycolor,
      //                             fontFamily: 'Urbanist',
      //                             fontWeight: FontWeight.w700),),
      //                         SizedBox(height: scrHeight*0.004,),
      //
      //                         Row(
      //                           children: [
      //                             Text("Out of ",style: TextStyle(
      //                                 fontSize: scrWidth*0.034,
      //                                 color: Colors.black,
      //                                 fontFamily: 'Urbanist',
      //                                 fontWeight: FontWeight.w600),),
      //                             Text(currencyConvert
      //                                 .format(widget.charity.valueAmount)
      //                                 .toString(),style: TextStyle(
      //                                 fontSize: scrWidth*0.034,
      //                                 color: Colors.black,
      //                                 fontFamily: 'Urbanist',
      //                                 fontWeight: FontWeight.w600),),
      //                           ],
      //                         ),
      //                         SizedBox(height: scrHeight*0.02,),
      //                       ],
      //                     ),
      //                   )
      //
      //                 ],
      //               ),
      //               // Padding(
      //               //   padding:  EdgeInsets.only(top: scrHeight*0.02,right: scrWidth*0.7),
      //               //   child: Text("Analytics",style: TextStyle(
      //               //       fontSize: scrWidth*0.04,
      //               //       color: Colors.black,
      //               //       fontFamily: 'Urbanist',
      //               //       fontWeight: FontWeight.w500),),
      //               // ),
      //             ],
      //           ),
      //
      //
      //       ],
      //     ),
      //     SizedBox(height: scrHeight*0.025,),
      //     // Padding(
      //     //   padding: EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
      //     //   child: TabBar(
      //     //       labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
      //     //       unselectedLabelStyle: TextStyle(
      //     //           fontFamily: 'Poppins',fontSize: scrWidth*0.039,fontWeight: FontWeight.w400
      //     //       ),
      //     //       unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.3),
      //     //       indicatorSize: TabBarIndicatorSize.label,
      //     //       labelColor: Colors.white,
      //     //       labelStyle: TextStyle(
      //     //           fontFamily: 'Poppins',fontSize: scrWidth*0.039,fontWeight: FontWeight.w400
      //     //       ),
      //     //       indicator: BoxDecoration(
      //     //           borderRadius: BorderRadius.circular(60),
      //     //           color: primarycolor
      //     //       ),
      //     //       isScrollable: true,
      //     //       controller: _tabControllerrs,
      //     //       tabs: [
      //     //         Container(
      //     //           height: scrHeight*0.043,
      //     //           width:scrWidth*0.22,
      //     //           decoration: BoxDecoration(
      //     //               borderRadius: BorderRadius.circular(60),
      //     //               color: Color.fromRGBO(0, 0, 0, 0.05)
      //     //           ),
      //     //           child: Center(child: Text("Day",)),),
      //     //         Container(
      //     //           height: scrHeight*0.043,
      //     //           width:scrWidth*0.22,
      //     //           decoration: BoxDecoration(
      //     //               borderRadius: BorderRadius.circular(60),
      //     //
      //     //               color: Color.fromRGBO(0, 0, 0, 0.05)
      //     //           ),
      //     //           child: Center(child: Text("Week",)),),
      //     //         Container(
      //     //           height: scrHeight*0.043,
      //     //           width:scrWidth*0.22,
      //     //           decoration: BoxDecoration(
      //     //               borderRadius: BorderRadius.circular(60),
      //     //               color: Color.fromRGBO(0, 0, 0, 0.05)
      //     //           ),
      //     //           child: Center(child: Text("Month",)),),
      //     //         Container(
      //     //           height: scrHeight*0.043,
      //     //           width:scrWidth*0.22,
      //     //           decoration: BoxDecoration(
      //     //               borderRadius: BorderRadius.circular(60),
      //     //               color: Color.fromRGBO(0, 0, 0, 0.05)
      //     //           ),
      //     //           child: Center(child: Text("Year",)),),
      //     //       ]),
      //     // ),
      //     // Expanded(
      //     //   child: TabBarView(
      //     //       controller: _tabControllerrs,
      //     //       children: [
      //     //         Center(
      //     //           child: Text("No Analytics Here",style: TextStyle(
      //     //             fontSize: scrWidth*0.03,
      //     //             fontWeight: FontWeight.w600,
      //     //             fontFamily: 'Urbanist',
      //     //             color: Color(0xffA8A8A8)
      //     //           ),),
      //     //         ),
      //     //         Center(
      //     //           child: Text("No Analytics Here",style: TextStyle(
      //     //               fontSize: scrWidth*0.03,
      //     //               fontWeight: FontWeight.w600,
      //     //               fontFamily: 'Urbanist',
      //     //               color: Color(0xffA8A8A8)
      //     //           ),),
      //     //         ),
      //     //         Center(
      //     //           child: Text("No Analytics Here",style: TextStyle(
      //     //               fontSize: scrWidth*0.03,
      //     //               fontWeight: FontWeight.w600,
      //     //               fontFamily: 'Urbanist',
      //     //               color: Color(0xffA8A8A8)
      //     //           ),),
      //     //         ),
      //     //         Center(
      //     //           child: Text("No Analytics Here",style: TextStyle(
      //     //               fontSize: scrWidth*0.03,
      //     //               fontWeight: FontWeight.w600,
      //     //               fontFamily: 'Urbanist',
      //     //               color: Color(0xffA8A8A8)
      //     //           ),),
      //     //         ),                ]
      //     //   ),
      //     // ),
      //   ],
      // )
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  height: scrHeight*0.45,
                  width:scrWidth,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffA1FFC9),
                          Color(0xffFFFFFF),
                        ],
                      )
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only( top: scrHeight*0.09,),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                // top: scrHeight * 0.09,
                                  left: scrWidth * 0.05,
                                  // bottom: scrHeight * 0.02,
                                  right: scrWidth * 0.04),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                          Text("Fundraise Dashboard",style: TextStyle(
                              fontSize: scrWidth*0.045,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700),),
                          SizedBox(width: scrWidth*0.13,),

                        ],
                      ),
                    ),
                    SizedBox(height: scrHeight*0.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Recent Charity",style: TextStyle(
                            fontSize: scrWidth*0.04,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500),),
                        SizedBox(width: scrWidth*0.44,),
                        // Row(
                        //   children: [
                        //     Text("See more ",style: TextStyle(
                        //         fontSize: scrWidth*0.04,
                        //         color: Colors.black,
                        //         fontFamily: 'Urbanist',
                        //         fontWeight: FontWeight.w600),),
                        //     Container(
                        //       height: scrHeight*0.018,
                        //       width: scrWidth*0.04,
                        //       decoration: BoxDecoration(
                        //           color: Color(0xff28B446),
                        //           borderRadius: BorderRadius.circular(30)
                        //       ),
                        //       child:Padding(
                        //         padding:  EdgeInsets.only(top: scrHeight*0.002,bottom: scrHeight*0.002),
                        //         child: SvgPicture.asset("assets/icons/smallarrowsvg.svg"),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                        // GestureDetector(
                        //   onTap: (){
                        //      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        //          BasicDetails(char: widget.charity, update: true,)));
                        //   },
                        //   child: Text("Edit",style: TextStyle(
                        //       fontSize: scrWidth*0.044,
                        //       color: Colors.black,
                        //       fontFamily: 'Urbanist',
                        //       fontWeight: FontWeight.w700),),
                        // ),
                      ],
                    ),
                    SizedBox(height: scrHeight*0.015,),
                    chari!.status==0? Container(
                      height: scrHeight*0.12,
                      width: scrWidth*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.02,),
                          Container(
                            width: scrWidth*0.3,
                            height: scrHeight*0.1,
                            decoration: BoxDecoration(
                              // image: DecorationImage(image: NetworkImage(
                              //     widget.charity.image!),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(scrWidth * 0.09),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:widget.charity?.image??'',
                              ),
                            ),
                          ),

                          // Positioned(
                          //   top: 50,
                          //   bottom: 7,
                          //   left: 5,
                          //   right: 44,
                          //   child:ClipRRect(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     child: BackdropFilter(
                          //       filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          //       child: Center(
                          //         child: Text("Disaster",style: TextStyle(
                          //             fontSize: scrWidth*0.02,
                          //             color: Colors.black,
                          //             fontFamily: 'Urbanist',
                          //             fontWeight: FontWeight.w700),),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: ,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.013,),
                              Padding(
                                padding:  EdgeInsets.only(left: scrWidth*0.05),
                                child: Container(
                                  width: scrWidth*0.5,
                                  child: Text(widget.charity.charityDetailes.toString(),style: TextStyle(
                                      fontSize: scrWidth*0.033,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                ),
                              ),
                              SizedBox(height: scrHeight*0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: scrWidth*0.05),
                                    child: GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FundRisingdashboardtwo()));
                                      },
                                      child: Container(
                                        width: scrWidth*0.2,
                                        height: scrHeight*0.023,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            // color: Color(0xff28B446),
                                            color: Colors.red
                                        ),
                                        child: Center(
                                          child: Text("IN REVIEW",style: TextStyle(
                                              fontSize: scrWidth*0.03,
                                              color: Colors.white,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 30,),
                                  //       InkWell(
                                  //         onTap: (){
                                  //
                                  // Share.share(
                                  //     'Welcome to First Logic Meta Lab https://firstlogicmetalab.com');
                                  //         },
                                  //         child: Padding(
                                  //           padding:  EdgeInsets.only(left: scrWidth*0.2),
                                  //           child: SvgPicture.asset("assets/icons/shareicon.svg",),
                                  //         ),
                                  //       ),

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ):(chari!.status==1)?Container(
                      height: scrHeight*0.12,
                      width: scrWidth*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.02,),
                          Container(
                            width: scrWidth*0.3,
                            height: scrHeight*0.1,
                            decoration: BoxDecoration(
                              // image: DecorationImage(image: NetworkImage(
                              //     widget.charity.image!),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(scrWidth * 0.09),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:widget.charity?.image??'',
                              ),
                            ),
                          ),

                          // Positioned(
                          //   top: 50,
                          //   bottom: 7,
                          //   left: 5,
                          //   right: 44,
                          //   child:ClipRRect(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     child: BackdropFilter(
                          //       filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          //       child: Center(
                          //         child: Text("Disaster",style: TextStyle(
                          //             fontSize: scrWidth*0.02,
                          //             color: Colors.black,
                          //             fontFamily: 'Urbanist',
                          //             fontWeight: FontWeight.w700),),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: ,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.013,),
                              Padding(
                                padding:  EdgeInsets.only(left: scrWidth*0.05),
                                child: Container(
                                  width: scrWidth*0.5,
                                  child: Text(widget.charity.charityDetailes.toString(),style: TextStyle(
                                      fontSize: scrWidth*0.033,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                ),
                              ),
                              SizedBox(height: scrHeight*0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: scrWidth*0.05),
                                    child: GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FundRisingdashboardtwo()));
                                      },
                                      child: Container(
                                        width: scrWidth*0.2,
                                        height: scrHeight*0.023,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xff28B446),
                                          // color: Colors.red
                                        ),
                                        child: Center(
                                          child: Text("ACCEPTED",style: TextStyle(
                                              fontSize: scrWidth*0.03,
                                              color: Colors.white,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 30,),
                                  //       InkWell(
                                  //         onTap: (){
                                  //
                                  // Share.share(
                                  //     'Welcome to First Logic Meta Lab https://firstlogicmetalab.com');
                                  //         },
                                  //         child: Padding(
                                  //           padding:  EdgeInsets.only(left: scrWidth*0.2),
                                  //           child: SvgPicture.asset("assets/icons/shareicon.svg",),
                                  //         ),
                                  //       ),

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ):Container(
                      height: scrHeight*0.12,
                      width: scrWidth*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.02,),
                          Container(
                            width: scrWidth*0.3,
                            height: scrHeight*0.1,
                            decoration: BoxDecoration(
                              // image: DecorationImage(image: NetworkImage(
                              //     widget.charity.image!),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(scrWidth * 0.09),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:widget.charity?.image??'',
                              ),
                            ),
                          ),

                          // Positioned(
                          //   top: 50,
                          //   bottom: 7,
                          //   left: 5,
                          //   right: 44,
                          //   child:ClipRRect(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     child: BackdropFilter(
                          //       filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          //       child: Center(
                          //         child: Text("Disaster",style: TextStyle(
                          //             fontSize: scrWidth*0.02,
                          //             color: Colors.black,
                          //             fontFamily: 'Urbanist',
                          //             fontWeight: FontWeight.w700),),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: ,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.013,),
                              Padding(
                                padding:  EdgeInsets.only(left: scrWidth*0.05),
                                child: Container(
                                  width: scrWidth*0.5,
                                  child: Text(widget.charity.charityDetailes.toString(),style: TextStyle(
                                      fontSize: scrWidth*0.033,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                ),
                              ),
                              SizedBox(height: scrHeight*0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: scrWidth*0.05),
                                    child: GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FundRisingdashboardtwo()));
                                      },
                                      child: Container(
                                        width: scrWidth*0.2,
                                        height: scrHeight*0.023,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            // color: Color(0xff28B446),
                                            color: Colors.red
                                        ),
                                        child: Center(
                                          child: Text("REJECTED",style: TextStyle(
                                              fontSize: scrWidth*0.03,
                                              color: Colors.white,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 30,),
                                  //       InkWell(
                                  //         onTap: (){
                                  //
                                  // Share.share(
                                  //     'Welcome to First Logic Meta Lab https://firstlogicmetalab.com');
                                  //         },
                                  //         child: Padding(
                                  //           padding:  EdgeInsets.only(left: scrWidth*0.2),
                                  //           child: SvgPicture.asset("assets/icons/shareicon.svg",),
                                  //         ),
                                  //       ),

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: scrHeight*0.02,right: scrWidth*0.45),
                      child: Text("Recent Charity Progress",style: TextStyle(
                          fontSize:  scrWidth*0.04,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: scrHeight*0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: ClipRect(
                        //     child: Align(
                        //       heightFactor: 0.35,
                        //       child: Padding(
                        //         padding:  EdgeInsets.only(left: scrWidth*0.07,right: scrWidth*0.03),
                        //         //25
                        //         child: SfRadialGauge(
                        //             axes: <RadialAxis>[
                        //               RadialAxis(
                        //                 canScaleToFit: false,
                        //                 minimum: 0,
                        //                 interval: 1,
                        //                 maximum: 360,
                        //                 showLabels: false,
                        //                 showLastLabel: false,
                        //                 showTicks: false,
                        //                 startAngle: 270,
                        //                 endAngle: 270,
                        //                 radiusFactor: 0.95,
                        //                 axisLineStyle: AxisLineStyle(
                        //                   thickness:0.23,
                        //                   color: Colors.grey.withOpacity(0.2),
                        //                   thicknessUnit: GaugeSizeUnit.factor,
                        //                 ),
                        //                 pointers:  <GaugePointer>[
                        //                   RangePointer(
                        //                       value: progressvalue,
                        //                       enableAnimation: true,
                        //                       animationDuration: 6000,
                        //                       animationType: AnimationType.slowMiddle,
                        //                       width: 0.23,
                        //                       sizeUnit: GaugeSizeUnit.factor,
                        //                       cornerStyle: CornerStyle.startCurve,
                        //                       gradient: SweepGradient(colors: <Color>[
                        //                         primarycolor,
                        //                         Color(0xff96c8aa)
                        //                       ],
                        //                           stops: <double>[
                        //                             0.74,
                        //                             1.3
                        //                           ])),
                        //                   MarkerPointer(
                        //                     enableAnimation: true,
                        //                     animationDuration: 6000,
                        //                     animationType: AnimationType.slowMiddle,
                        //                     value: progressvalue,
                        //                     markerWidth: 17,
                        //                     markerHeight: 17,
                        //                     borderWidth:4,
                        //                     borderColor:  Color(0xff96c8aa),
                        //                     markerType: MarkerType.circle,
                        //                     color: Colors.white,
                        //                   )
                        //                 ],
                        //                 annotations:<GaugeAnnotation> [
                        //                   GaugeAnnotation(angle: 0,positionFactor: 0.18,
                        //                     widget:Text("70%",textAlign: TextAlign.center,style: TextStyle(
                        //                         fontSize: 19,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
                        //                     ),),
                        //                   )
                        //
                        //                 ],
                        //
                        //               )
                        //             ]),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding:  EdgeInsets.only(left: scrWidth*0.06,top: scrHeight*0.024,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Raised",style: TextStyle(
                                  fontSize: scrWidth*0.034,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500),),
                              SizedBox(height: scrHeight*0.006,),

                              Text("???${chari?.totalReceived??0}",
                                // "???15,23,340",
                                style: TextStyle(
                                    fontSize: scrWidth*0.05,
                                    color: primarycolor,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700),),
                              SizedBox(height: scrHeight*0.004,),

                              Row(
                                children: [
                                  Text("Out of ",style: TextStyle(
                                      fontSize: scrWidth*0.034,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                  Text(currencyConvert
                                      .format(widget.charity.valueAmount)
                                      .toString(),style: TextStyle(
                                      fontSize: scrWidth*0.034,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                ],
                              ),
                              SizedBox(height: scrHeight*0.05,),
                            ],
                          ),
                        )

                      ],
                    ),

                    // Padding(
                    //   padding:  EdgeInsets.only(right: scrWidth*0.7,top: scrHeight*0.013),
                    //   child: Text("Analytics",style: TextStyle(
                    //       fontSize: scrWidth*0.04,
                    //       color: Colors.black,
                    //       fontFamily: 'Urbanist',
                    //       fontWeight: FontWeight.w500),),
                    // ),
                  ],
                ),


              ],
            ),
            // Padding(
            //   padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
            //   child: TabBar(
            //       labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
            //       unselectedLabelStyle: TextStyle(
            //           fontFamily: 'Poppins',fontSize: scrWidth*0.039,fontWeight: FontWeight.w400
            //       ),
            //       unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.3),
            //       indicatorSize: TabBarIndicatorSize.label,
            //       labelColor: Colors.white,
            //       labelStyle: TextStyle(
            //           fontFamily: 'Poppins',fontSize: scrWidth*0.039,fontWeight: FontWeight.w400
            //       ),
            //       indicator: BoxDecoration(
            //           borderRadius: BorderRadius.circular(60),
            //           color: primarycolor
            //       ),
            //       isScrollable: true,
            //       controller: _tabController,
            //       tabs: [
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Day",)),),
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Week",)),),
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Month",)),),
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Year",)),),
            //       ]),
            // ),
            // SizedBox(height: scrHeight*0.02,),
            // SizedBox(
            //   height: scrHeight*0.3,
            //   child: TabBarView(
            //       controller: _tabController,
            //       children: [
            //
            //         Container(),
            //         Container(),
            //         Padding(
            //           padding:  EdgeInsets.only(left: scrWidth*0.04,right: scrWidth*0.04),
            //           child: Flchartpage(),),
            //         Container(),
            //       ]),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: scrWidth*0.065,),
                Text("Donation History",style: TextStyle(
                    fontSize: scrWidth*0.04,
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500),),
                SizedBox(width: scrWidth*0.02,),

                Container(
                  height: scrHeight*0.018,
                  width: scrWidth*0.04,
                  decoration: BoxDecoration(
                      color: Color(0xff28B446),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:Padding(
                    padding:  EdgeInsets.only(top: scrHeight*0.002,bottom: scrHeight*0.002),
                    child: SvgPicture.asset("assets/icons/smallarrowsvg.svg"),
                  ),
                ),

              ],
            ),
            ListView.separated(
              itemCount: chari!.payments!.length??0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final datas=chari!.payments![index];
                List<Payments> paylist=chari!.payments!;
                return Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentDetailsPage(
                        payments:paylist, index: index,
                        id: widget.charity.charityId!,)));
                    },
                    child: Container(
                      height: scrHeight*0.11,
                      width: scrWidth*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1), // shadow color
                              blurRadius: 15, // shadow radius
                              offset: Offset(5, 10), // shadow offset
                              spreadRadius:
                              0.4, // The amount the box should be inflated prior to applying the blur
                              blurStyle: BlurStyle.normal // set blur style
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.045,),
                          CircleAvatar(
                            radius: scrWidth*0.05,
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiuZGp08DDSD0P3PMfKSbbPu2nVmJdH74gHg&usqp=CAU"),
                          ),
                          SizedBox(width: scrWidth*0.05,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.045,),
                              Container(
                                width: 130,
                                child: Text(datas.userName!,style: TextStyle(
                                  fontSize: scrWidth*0.043,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                              // Text("Perinthalmanna",style: TextStyle(
                              //     fontSize: scrWidth*0.03,
                              //     fontFamily: 'Urbanist',
                              //     fontWeight: FontWeight.w500,
                              //     color: Color(0xff8B8B8B)
                              // ),),


                            ],
                          ),
                          SizedBox(width: scrWidth*0.06,),
                          Text(currencyConvert.format(datas.amount??0).toString(),style: TextStyle(
                              fontSize: scrWidth*0.046,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              color: primarycolor),),
                          SizedBox(width: scrWidth*0.01,),
                          chari==null?Container():(chari!.payments![index].verified==false)?Container(
                            height: scrHeight*0.07,
                            width: scrWidth*0.05,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGRuEPLzDl41yaNFb1LZEWImxseXmRcMBqkg&usqp=CAU"))
                            ),
                          ): Container(
                            height: scrHeight*0.08,
                            width: scrWidth*0.08,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM7oMFBoxJbc4nTI2k2SlW8IPQr70WMbo8OIZ92lUZVQ_jsSUp5_CFj9vug5JP0SoAsYw&usqp=CAU"))
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: scrHeight*0.015,
              ),
            ),
            SizedBox(height: scrHeight*0.04,),
            //         // Text("the uhdufhn wneufhwufhn  eijwfhefuhwef uefbwuefburbfurfucgeugfrgferugfur",overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,)
            // SingleCircularSlider(
            //   288,
            //   130,
            //   height: 150,
            //     width: 150,
            //     baseColor: Colors.black38,
            //     selectionColor:Colors.blue,
            //     handlerColor: Colors.grey,
            //     handlerOutterRadius: 20.0,
            //
            //     // onSelectionChange: _updateLabels,
            //      showRoundedCapInSelection: true,
            //
            //     showHandlerOutter: true,
            //   shouldCountLaps: true,
            //   sliderStrokeWidth: 17.0,
            //
            //
            // ),
            SizedBox(height: 40,)
          ],
        ),
      ):SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  height: scrHeight*0.45,
                  width:scrWidth,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffA1FFC9),
                          Color(0xffFFFFFF),
                        ],
                      )
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only( top: scrHeight*0.09,),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                // top: scrHeight * 0.09,
                                  left: scrWidth * 0.05,
                                  // bottom: scrHeight * 0.02,
                                  right: scrWidth * 0.04),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                          Text("Fundraise Dashboard",style: TextStyle(
                              fontSize: scrWidth*0.045,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700),),
                          SizedBox(width: scrWidth*0.13,),

                        ],
                      ),
                    ),
                    SizedBox(height: scrHeight*0.03,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Recent Charity",style: TextStyle(
                            fontSize: scrWidth*0.04,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w500),),
                        SizedBox(width: scrWidth*0.44,),
                        // Row(
                        //   children: [
                        //     Text("See more ",style: TextStyle(
                        //         fontSize: scrWidth*0.04,
                        //         color: Colors.black,
                        //         fontFamily: 'Urbanist',
                        //         fontWeight: FontWeight.w600),),
                        //     Container(
                        //       height: scrHeight*0.018,
                        //       width: scrWidth*0.04,
                        //       decoration: BoxDecoration(
                        //           color: Color(0xff28B446),
                        //           borderRadius: BorderRadius.circular(30)
                        //       ),
                        //       child:Padding(
                        //         padding:  EdgeInsets.only(top: scrHeight*0.002,bottom: scrHeight*0.002),
                        //         child: SvgPicture.asset("assets/icons/smallarrowsvg.svg"),
                        //       ),
                        //     ),
                        //
                        //   ],
                        // ),
                        // GestureDetector(
                        //   onTap: (){
                        //      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                        //          BasicDetails(char: widget.charity, update: true,)));
                        //   },
                        //   child: Text("Edit",style: TextStyle(
                        //       fontSize: scrWidth*0.044,
                        //       color: Colors.black,
                        //       fontFamily: 'Urbanist',
                        //       fontWeight: FontWeight.w700),),
                        // ),
                      ],
                    ),
                    SizedBox(height: scrHeight*0.015,),
                    Container(
                      height: scrHeight*0.12,
                      width: scrWidth*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.02,),
                          Container(
                            width: scrWidth*0.3,
                            height: scrHeight*0.1,
                            decoration: BoxDecoration(
                              // image: DecorationImage(image: NetworkImage(
                              //     widget.charity.image!),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey,

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(scrWidth * 0.09),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:widget.charity?.image??'',
                              ),
                            ),
                          ),

                          // Positioned(
                          //   top: 50,
                          //   bottom: 7,
                          //   left: 5,
                          //   right: 44,
                          //   child:ClipRRect(
                          //     borderRadius: BorderRadius.all(Radius.circular(10)),
                          //     child: BackdropFilter(
                          //       filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                          //       child: Center(
                          //         child: Text("Disaster",style: TextStyle(
                          //             fontSize: scrWidth*0.02,
                          //             color: Colors.black,
                          //             fontFamily: 'Urbanist',
                          //             fontWeight: FontWeight.w700),),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: ,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.013,),
                              Padding(
                                padding:  EdgeInsets.only(left: scrWidth*0.05),
                                child: Container(
                                  width: scrWidth*0.5,
                                  child: Text(widget.charity.charityDetailes.toString(),style: TextStyle(
                                      fontSize: scrWidth*0.033,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                ),
                              ),
                              SizedBox(height: scrHeight*0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: scrWidth*0.05),
                                    child: GestureDetector(
                                      onTap: (){
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>FundRisingdashboardtwo()));
                                      },
                                      child: Container(
                                        width: scrWidth*0.2,
                                        height: scrHeight*0.023,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            // color: Color(0xff28B446),
                                            color: Colors.red
                                        ),
                                        child: Center(
                                          child: Text("BLOCKED",style: TextStyle(
                                              fontSize: scrWidth*0.03,
                                              color: Colors.white,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700),),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: 30,),
                                  //       InkWell(
                                  //         onTap: (){
                                  //
                                  // Share.share(
                                  //     'Welcome to First Logic Meta Lab https://firstlogicmetalab.com');
                                  //         },
                                  //         child: Padding(
                                  //           padding:  EdgeInsets.only(left: scrWidth*0.2),
                                  //           child: SvgPicture.asset("assets/icons/shareicon.svg",),
                                  //         ),
                                  //       ),

                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(top: scrHeight*0.02,right: scrWidth*0.45),
                      child: Text("Recent Charity Progress",style: TextStyle(
                          fontSize:  scrWidth*0.04,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500),),
                    ),
                    SizedBox(height: scrHeight*0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Expanded(
                        //   child: ClipRect(
                        //     child: Align(
                        //       heightFactor: 0.35,
                        //       child: Padding(
                        //         padding:  EdgeInsets.only(left: scrWidth*0.07,right: scrWidth*0.03),
                        //         //25
                        //         child: SfRadialGauge(
                        //             axes: <RadialAxis>[
                        //               RadialAxis(
                        //                 canScaleToFit: false,
                        //                 minimum: 0,
                        //                 interval: 1,
                        //                 maximum: 360,
                        //                 showLabels: false,
                        //                 showLastLabel: false,
                        //                 showTicks: false,
                        //                 startAngle: 270,
                        //                 endAngle: 270,
                        //                 radiusFactor: 0.95,
                        //                 axisLineStyle: AxisLineStyle(
                        //                   thickness:0.23,
                        //                   color: Colors.grey.withOpacity(0.2),
                        //                   thicknessUnit: GaugeSizeUnit.factor,
                        //                 ),
                        //                 pointers:  <GaugePointer>[
                        //                   RangePointer(
                        //                       value: progressvalue,
                        //                       enableAnimation: true,
                        //                       animationDuration: 6000,
                        //                       animationType: AnimationType.slowMiddle,
                        //                       width: 0.23,
                        //                       sizeUnit: GaugeSizeUnit.factor,
                        //                       cornerStyle: CornerStyle.startCurve,
                        //                       gradient: SweepGradient(colors: <Color>[
                        //                         primarycolor,
                        //                         Color(0xff96c8aa)
                        //                       ],
                        //                           stops: <double>[
                        //                             0.74,
                        //                             1.3
                        //                           ])),
                        //                   MarkerPointer(
                        //                     enableAnimation: true,
                        //                     animationDuration: 6000,
                        //                     animationType: AnimationType.slowMiddle,
                        //                     value: progressvalue,
                        //                     markerWidth: 17,
                        //                     markerHeight: 17,
                        //                     borderWidth:4,
                        //                     borderColor:  Color(0xff96c8aa),
                        //                     markerType: MarkerType.circle,
                        //                     color: Colors.white,
                        //                   )
                        //                 ],
                        //                 annotations:<GaugeAnnotation> [
                        //                   GaugeAnnotation(angle: 0,positionFactor: 0.18,
                        //                     widget:Text("70%",textAlign: TextAlign.center,style: TextStyle(
                        //                         fontSize: 19,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
                        //                     ),),
                        //                   )
                        //
                        //                 ],
                        //
                        //               )
                        //             ]),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding:  EdgeInsets.only(left: scrWidth*0.06,top: scrHeight*0.024,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Raised",style: TextStyle(
                                  fontSize: scrWidth*0.034,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500),),
                              SizedBox(height: scrHeight*0.006,),

                              Text("???${chari?.totalReceived??0}",
                                // "???15,23,340",
                                style: TextStyle(
                                    fontSize: scrWidth*0.05,
                                    color: primarycolor,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700),),
                              SizedBox(height: scrHeight*0.004,),

                              Row(
                                children: [
                                  Text("Out of ",style: TextStyle(
                                      fontSize: scrWidth*0.034,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                  Text(currencyConvert
                                      .format(widget.charity.valueAmount)
                                      .toString(),style: TextStyle(
                                      fontSize: scrWidth*0.034,
                                      color: Colors.black,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),),
                                ],
                              ),
                              SizedBox(height: scrHeight*0.05,),
                            ],
                          ),
                        )

                      ],
                    ),

                    // Padding(
                    //   padding:  EdgeInsets.only(right: scrWidth*0.7,top: scrHeight*0.013),
                    //   child: Text("Analytics",style: TextStyle(
                    //       fontSize: scrWidth*0.04,
                    //       color: Colors.black,
                    //       fontFamily: 'Urbanist',
                    //       fontWeight: FontWeight.w500),),
                    // ),
                  ],
                ),


              ],
            ),
            // Padding(
            //   padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
            //   child: TabBar(
            //       labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
            //       unselectedLabelStyle: TextStyle(
            //           fontFamily: 'Poppins',fontSize: scrWidth*0.039,fontWeight: FontWeight.w400
            //       ),
            //       unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.3),
            //       indicatorSize: TabBarIndicatorSize.label,
            //       labelColor: Colors.white,
            //       labelStyle: TextStyle(
            //           fontFamily: 'Poppins',fontSize: scrWidth*0.039,fontWeight: FontWeight.w400
            //       ),
            //       indicator: BoxDecoration(
            //           borderRadius: BorderRadius.circular(60),
            //           color: primarycolor
            //       ),
            //       isScrollable: true,
            //       controller: _tabController,
            //       tabs: [
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Day",)),),
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Week",)),),
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Month",)),),
            //         Container(
            //           height: scrHeight*0.043,
            //           width:scrWidth*0.22,
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(60),
            //               color: Color.fromRGBO(0, 0, 0, 0.05)
            //           ),
            //           child: Center(child: Text("Year",)),),
            //       ]),
            // ),
            // SizedBox(height: scrHeight*0.02,),
            // SizedBox(
            //   height: scrHeight*0.3,
            //   child: TabBarView(
            //       controller: _tabController,
            //       children: [
            //
            //         Container(),
            //         Container(),
            //         Padding(
            //           padding:  EdgeInsets.only(left: scrWidth*0.04,right: scrWidth*0.04),
            //           child: Flchartpage(),),
            //         Container(),
            //       ]),
            // ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: scrWidth*0.065,),
                Text("Donation History",style: TextStyle(
                    fontSize: scrWidth*0.04,
                    color: Colors.black,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w500),),
                SizedBox(width: scrWidth*0.02,),

                Container(
                  height: scrHeight*0.018,
                  width: scrWidth*0.04,
                  decoration: BoxDecoration(
                      color: Color(0xff28B446),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child:Padding(
                    padding:  EdgeInsets.only(top: scrHeight*0.002,bottom: scrHeight*0.002),
                    child: SvgPicture.asset("assets/icons/smallarrowsvg.svg"),
                  ),
                ),

              ],
            ),
            ListView.separated(
              itemCount: chari!.payments!.length??0,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                final datas=chari!.payments![index];
                List<Payments> paylist=chari!.payments!;
                return Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentDetailsPage(
                        payments:paylist, index: index,
                        id: widget.charity.charityId!,)));
                    },
                    child: Container(
                      height: scrHeight*0.11,
                      width: scrWidth*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1), // shadow color
                              blurRadius: 15, // shadow radius
                              offset: Offset(5, 10), // shadow offset
                              spreadRadius:
                              0.4, // The amount the box should be inflated prior to applying the blur
                              blurStyle: BlurStyle.normal // set blur style
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: scrWidth*0.045,),
                          CircleAvatar(
                            radius: scrWidth*0.05,
                            backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiuZGp08DDSD0P3PMfKSbbPu2nVmJdH74gHg&usqp=CAU"),
                          ),
                          SizedBox(width: scrWidth*0.05,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.045,),
                              Container(
                                width: 130,
                                child: Text(datas.userName!,style: TextStyle(
                                  fontSize: scrWidth*0.043,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),),
                              ),
                              // Text("Perinthalmanna",style: TextStyle(
                              //     fontSize: scrWidth*0.03,
                              //     fontFamily: 'Urbanist',
                              //     fontWeight: FontWeight.w500,
                              //     color: Color(0xff8B8B8B)
                              // ),),


                            ],
                          ),
                          SizedBox(width: scrWidth*0.06,),
                          Text(currencyConvert.format(datas.amount??0).toString(),style: TextStyle(
                              fontSize: scrWidth*0.046,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              color: primarycolor),),
                          SizedBox(width: scrWidth*0.01,),
                          chari==null?Container():(chari!.payments![index].verified==false)?Container(
                            height: scrHeight*0.07,
                            width: scrWidth*0.05,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGRuEPLzDl41yaNFb1LZEWImxseXmRcMBqkg&usqp=CAU"))
                            ),
                          ): Container(
                            height: scrHeight*0.08,
                            width: scrWidth*0.08,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRM7oMFBoxJbc4nTI2k2SlW8IPQr70WMbo8OIZ92lUZVQ_jsSUp5_CFj9vug5JP0SoAsYw&usqp=CAU"))
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: scrHeight*0.015,
              ),
            ),
            SizedBox(height: scrHeight*0.04,),
            //         // Text("the uhdufhn wneufhwufhn  eijwfhefuhwef uefbwuefburbfurfucgeugfrgferugfur",overflow: TextOverflow.ellipsis,maxLines: 1,softWrap: false,)
            // SingleCircularSlider(
            //   288,
            //   130,
            //   height: 150,
            //     width: 150,
            //     baseColor: Colors.black38,
            //     selectionColor:Colors.blue,
            //     handlerColor: Colors.grey,
            //     handlerOutterRadius: 20.0,
            //
            //     // onSelectionChange: _updateLabels,
            //      showRoundedCapInSelection: true,
            //
            //     showHandlerOutter: true,
            //   shouldCountLaps: true,
            //   sliderStrokeWidth: 17.0,
            //
            //
            // ),
            SizedBox(height: 40,)
          ],
        ),
      )
    );
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://threems.page.link/kuri_Invite',
      longDynamicLink: Uri.parse(
        'https://threems.page.link/chit_invite?chitId=${widget.charity.charityId}&referralId=${widget.charity.userId}',
      ),
      link: Uri.parse(dynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.firstlogicmetalab.threems',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.flutter.plugins.firebase.dynamiclinksexample',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;

      print(_linkMessage);
    });
  }


}
