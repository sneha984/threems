import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/model/usermodel.dart';

import '../../model/charitymodel.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'basic_details.dart';
import 'fundraisingdashboard.dart';

class SeeMoreCharities extends StatefulWidget {
  const SeeMoreCharities({Key? key}) : super(key: key);

  @override
  State<SeeMoreCharities> createState() => _SeeMoreCharitiesState();
}

class _SeeMoreCharitiesState extends State<SeeMoreCharities>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Widget> tabs=[];
  List<Widget> tabView=[];
  Map<String,dynamic> causes={};
  Map<String,dynamic> charityLengthMaps={};
  List<String> causeDetails=[];
  getdropdowns(){
    FirebaseFirestore.instance.collection('dropdown').snapshots().listen((event) {
      causeDetails=[];
      tabs=[];
      tabView=[];
      int i=0;
      _tabController = TabController(length: event.docs.length, vsync: this);
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        causes[doc.get('value')]=doc.data();
        causeDetails.add(doc.get('value'));
        tabView.add(StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
            stream: FirebaseFirestore
                .instance
                .collection('charity')
                .where('userId',isEqualTo: currentuser!.userId)
                .where('cause' ,isEqualTo: doc.get('causeId')).snapshots(),
            builder: (context,snapshot){
              List<CharityModel> charityList=[];
              if(snapshot.data==null){
                return Center(child: Text("nkfnceknfe"),);
              }
              for(DocumentSnapshot<Map<String,dynamic>> doc in snapshot.data!.docs){
                charityList.add(CharityModel.fromJson(doc.data()!));
              }
              charityLengthMaps[doc.get('value')]=charityList.length;
              return ListView.separated(
                itemCount: charityList.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final charity=charityList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FundRaisingDashboard(charity: charity,)));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: scrWidth * 0.05,
                        ),
                        Container(
                          height: scrHeight * 0.135,
                          width: scrWidth * 0.285,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  image: NetworkImage(charity.image??''),
                                  fit: BoxFit.fill)),
                        ),
                        SizedBox(
                          width: scrWidth * 0.05,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: scrWidth*0.6,
                              child: Text(charity.charityDetailes??'',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: scrWidth * 0.036,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top: 5,bottom: 6),
                              child: LinearPercentIndicator(
                                //leaner progress bar
                                animation: true,
                                animationDuration: 1000,
                                lineHeight: 3,
                                width: 189,
                                percent: charity.totalReceived!/charity.valueAmount!,
                                alignment: MainAxisAlignment.start,
                                barRadius: Radius.circular(1.5),

                                progressColor: Color(0xff343434),
                                backgroundColor: Color(0xffE9F6FF),
                              ),
                            ),
                            SizedBox(
                              height: scrHeight * 0.02,
                            ),
                            Text(
                              currencyConvert
                                  .format(charity.valueAmount??0)
                                  .toString(),
                              style: TextStyle(
                                  fontSize: scrWidth * 0.039,
                                  color: primarycolor,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: scrHeight*0.02,),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: scrHeight * 0.025,
                  );
                },
              );
            }));
        tabs.add(
            Tab(
              child: Container(
                height: scrHeight*0.038,
                width: scrWidth*0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.5),
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     SizedBox(width: scrWidth*0.02,),
                    Text(doc.get('value')),
                    // SizedBox(width: scrWidth*0.025,),
                    Padding(
                      padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035,right: 5),
                      child: CircleAvatar(
                        radius: 11,
                        backgroundColor: Colors.white,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('charity')
                                .where('userId',isEqualTo :currentuser!.userId)
                                .where('cause',isEqualTo:doc.get('causeId'))
                                .snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return CircularProgressIndicator();
                              }
                              return Text(snapshot.data!.docs.length.toString() ,style: tababrnumberFont);
                            }
                        ),

                      ),
                    )
                  ],
                ),
              ),
            )
        );
        i++;
      }
      if(mounted){
        setState(() {

        });
      }
    });
  }
  // List<CharityModel> charityDetailsList1 = [];
  // List<CharityModel> charityDetailsList2 = [];
  // List<CharityModel> charityDetailsList3 = [];
  // List<CharityModel> charityDetailsList4 = [];


  // getCharity() {
  //   print("test ${currentuser!.userId}");
  //   FirebaseFirestore.instance
  //       .collection('charity')
  //       .where('userId', isEqualTo: currentuser!.userId)
  //       .snapshots()
  //       .listen((event) {
  //         charityDetailsList1=[];
  //         charityDetailsList2=[];
  //         charityDetailsList3=[];
  //         charityDetailsList4=[];
  //         for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
  //       // if(doc['cause']==1){
  //       //   charityDetailsList1.add(CharityModel.fromJson(doc!.data()!));
  //       //
  //       // }else if(doc['cause']==2){
  //       //
  //       // }
  //       doc['cause'] == 0
  //           ? charityDetailsList1.add(CharityModel.fromJson(doc!.data()!))
  //           : doc['cause'] == 1
  //               ? charityDetailsList2.add(CharityModel.fromJson(doc!.data()!))
  //               : doc['cause']==2?charityDetailsList3.add(CharityModel.fromJson(doc!.data()!)):
  //                       charityDetailsList4.add(CharityModel.fromJson(doc!.data()!));
  //     }
  //     print(charityDetailsList1.length);
  //     print(charityDetailsList2.length);
  //     print(charityDetailsList3.length);
  //     print(charityDetailsList4.length);
  //
  //
  //         if (mounted) {
  //       setState(() {});
  //     }
  //   });
  // }

  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );

  @override
  void initState() {
    // getCharity();
    _tabController = TabController(length: 0, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getdropdowns();
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: scrHeight * 0.158,
            width: scrWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: scrHeight * 0.1,
                            left: scrWidth * 0.07,
                            // bottom: scrHeight*0.02,
                            right: scrWidth * 0.04),
                        child: SvgPicture.asset(
                          "assets/icons/arrow.svg",
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: scrHeight * 0.1,
                      ),
                      child: Text(
                        "Your Charities",
                        style: TextStyle(
                            fontSize: scrWidth * 0.045,
                            color: Colors.black,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: scrWidth*0.28,),
                    Padding(
                      padding:EdgeInsets.only(top: scrHeight * 0.1,),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BasicDetails()));

                        },
                        child: Container(
                          height: scrHeight*0.035,
                          width: scrWidth * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: primarycolor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                size: 11,
                                color: Colors.white,
                              ),
                              Text(
                                "Create New",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: CreateChitFont,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   padding: EdgeInsets.only(
                //       left: scrWidth * 0.02, top: scrHeight * 0.02),
                //   child: Container(
                //     height: scrHeight * 0.042,
                //     width: scrWidth * 0.9,
                //     decoration: BoxDecoration(
                //         color: Color(0xffE9EEF3),
                //         borderRadius: BorderRadius.circular(17)),
                //     child: TextFormField(
                //       decoration: InputDecoration(
                //           prefixIcon: Padding(
                //             padding: EdgeInsets.only(
                //                 top: scrHeight * 0.01,
                //                 left: scrWidth * 0.04,
                //                 bottom: scrHeight * 0.01,
                //                 right: scrWidth * 0.05),
                //             child: SvgPicture.asset(
                //               "assets/icons/Vector (4).svg",
                //             ),
                //           ),
                //           border: InputBorder.none,
                //           hintText: "search here",
                //           hintStyle: TextStyle(
                //             fontFamily: 'Urbanist',
                //             fontWeight: FontWeight.w500,
                //             fontSize: scrWidth * 0.042,
                //             color: Colors.grey,
                //           )),
                //       cursorColor: Colors.black,
                //       cursorHeight: 20,
                //       cursorWidth: 0.5,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(
            height: scrHeight * 0.017,
          ),
          Row(
            children: [
              SizedBox(
                width: scrWidth * 0.045,
              ),
              // Container(
              //   width: scrWidth * 0.09,
              //   height: scrHeight * 0.04,
              //   decoration: BoxDecoration(
              //       color: primarycolor,
              //       borderRadius: BorderRadius.circular(17.5)),
              //   child: Padding(
              //     padding: EdgeInsets.only(
              //         top: scrHeight * 0.01, bottom: scrHeight * 0.01),
              //     child: SvgPicture.asset(
              //       "assets/icons/Group (1).svg",
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   width: scrWidth * 0.02,
              // ),
              Expanded(
                child: Container(
                  height: scrHeight * 0.039,
                  child: TabBar(
                      isScrollable: true,
                      indicatorWeight: 0.05,
                      controller: _tabController,
                      unselectedLabelColor: Color(0xffA7A7A7),
                      unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Urbanist',
                          fontSize: scrWidth * 0.0385),
                      labelColor: Color(0xff0D0D0D),
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Urbanist',
                          fontSize: scrWidth * 0.0385),
                      // indicatorPadding: EdgeInsets.only(bottom: scrHeight*0.00,left: scrWidth*0.00,right: scrWidth*0.00),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.5),
                          color: Color.fromRGBO(169, 255, 188, 0.4)),
                      indicatorSize: TabBarIndicatorSize.label,
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: EdgeInsets.only(
                          left: scrWidth * 0.023, right: scrWidth * 0.019),
                      //  indicatorWeight: 1,
                      tabs:tabs,
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _tabController.index = 0;
                        //     });
                        //   },
                        //   child: Tab(
                        //     child: Container(
                        //       height: scrHeight * 0.038,
                        //       width: scrWidth * 0.27,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(17.5),
                        //           border: Border.all(
                        //               color: Color.fromRGBO(0, 0, 0, 0.06),
                        //               width: scrWidth * 0.003)),
                        //       child: Row(
                        //         children: [
                        //           SizedBox(
                        //             width: scrWidth * 0.03,
                        //           ),
                        //           Text(
                        //             "Medical",
                        //           ),
                        //           SizedBox(
                        //             width: scrWidth * 0.025,
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(
                        //                 bottom: scrHeight * 0.0035,
                        //                 top: scrHeight * 0.0035),
                        //             child: CircleAvatar(
                        //               radius: 11,
                        //               child:
                        //                   Text(charityDetailsList1.length.toString(), style: tababrnumberFont),
                        //               backgroundColor:
                        //                   (_tabController.index == 0)
                        //                       ? Colors.white
                        //                       : Color(0xffD4D4D4),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _tabController.index = 1;
                        //     });
                        //   },
                        //   child: Tab(
                        //     child: Container(
                        //       height: scrHeight * 0.038,
                        //       width: scrWidth * 0.27,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(17.5),
                        //           border: Border.all(
                        //               color: Color.fromRGBO(0, 0, 0, 0.06),
                        //               width: scrWidth * 0.003)),
                        //       child: Row(
                        //         children: [
                        //           SizedBox(
                        //             width: scrWidth * 0.02,
                        //           ),
                        //           Text("Education"),
                        //           SizedBox(
                        //             width: scrWidth * 0.004,
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(
                        //                 bottom: scrHeight * 0.0035,
                        //                 top: scrHeight * 0.0035),
                        //             child: CircleAvatar(
                        //               radius: 11,
                        //               child: Text(charityDetailsList2.length.toString(), style: tababrnumberFont),
                        //               backgroundColor:
                        //                   (_tabController.index == 1)
                        //                       ? Colors.white
                        //                       : Color(0xffD4D4D4),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _tabController.index = 2;
                        //     });
                        //   },
                        //   child: Tab(
                        //     child: Container(
                        //       height: scrHeight * 0.038,
                        //       width: scrWidth * 0.27,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(17.5),
                        //           border: Border.all(
                        //               color: Color.fromRGBO(0, 0, 0, 0.06),
                        //               width: scrWidth * 0.003)),
                        //       child: Row(
                        //         children: [
                        //           SizedBox(
                        //             width: scrWidth * 0.03,
                        //           ),
                        //           Text("Disaster"),
                        //           SizedBox(
                        //             width: scrWidth * 0.02,
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(
                        //                 bottom: scrHeight * 0.0035,
                        //                 top: scrHeight * 0.0035),
                        //             child: CircleAvatar(
                        //               radius: 11,
                        //               child:
                        //                   Text(charityDetailsList3.length.toString(), style: tababrnumberFont),
                        //               backgroundColor:
                        //                   (_tabController.index == 2)
                        //                       ? Colors.white
                        //                       : Color(0xffD4D4D4),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _tabController.index = 3;
                        //     });
                        //   },
                        //   child: Tab(
                        //     child: Container(
                        //       height: scrHeight * 0.038,
                        //       width: scrWidth * 0.27,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(17.5),
                        //           border: Border.all(
                        //               color: Color.fromRGBO(0, 0, 0, 0.06),
                        //               width: scrWidth * 0.003)),
                        //       child: Row(
                        //         children: [
                        //           SizedBox(
                        //             width: scrWidth * 0.05,
                        //           ),
                        //           Text("Others"),
                        //           SizedBox(
                        //             width: scrWidth * 0.025,
                        //           ),
                        //           Padding(
                        //             padding: EdgeInsets.only(
                        //                 bottom: scrHeight * 0.0035,
                        //                 top: scrHeight * 0.0035),
                        //             child: CircleAvatar(
                        //               radius: 11,
                        //               child:
                        //               Text(charityDetailsList4.length.toString(), style: tababrnumberFont),
                        //               backgroundColor:
                        //               (_tabController.index == 3)
                        //                   ? Colors.white
                        //                   : Color(0xffD4D4D4),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),


                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: scrHeight * 0.001,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabView,
                // ListView.separated(
                //   itemCount: charityDetailsList1.length,
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   physics: BouncingScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final charity=charityDetailsList1[index];
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => FundRaisingDashboard(charity: charity,)));
                //       },
                //       child: Row(
                //         children: [
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Container(
                //             height: scrHeight * 0.135,
                //             width: scrWidth * 0.285,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30),
                //                 image: DecorationImage(
                //                     image: NetworkImage(charity.image!),
                //                     fit: BoxFit.fill)),
                //           ),
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Column(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 width: scrWidth*0.6,
                //                 child: Text(charity.charityDetailes.toString(),
                //                     maxLines: 5,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.036,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600)),
                //               ),
                //               SizedBox(
                //                 height: scrHeight * 0.02,
                //               ),
                //               // Container(
                //               //     height: scrHeight * 0.004,
                //               //     width: scrWidth * 0.55,
                //               //     child: LinearPercentIndicator(
                //               //       animation: true,
                //               //       animationDuration: 1000,
                //               //       percent: _items[index].value,
                //               //       backgroundColor: Color(0xffE9F6FF),
                //               //       progressColor: Color(0xff343434),
                //               //     )),
                //
                //               Row(
                //                 children: [
                //                   Text("0000000",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //                   Text("/",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //                   Text(
                //                     currencyConvert
                //                         .format(charity.valueAmount)
                //                         .toString(),
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //
                //                 ],
                //               ),
                //               SizedBox(height: scrHeight*0.02,),
                //             ],
                //           )
                //         ],
                //       ),
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, int index) {
                //     return SizedBox(
                //       height: scrHeight * 0.025,
                //     );
                //   },
                // ),
                // ListView.separated(
                //   itemCount: charityDetailsList2.length,
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   physics: BouncingScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final charity=charityDetailsList2[index];
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => FundRaisingDashboard(charity: charity,)));
                //       },
                //       child: Row(
                //         children: [
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Container(
                //             height: scrHeight * 0.135,
                //             width: scrWidth * 0.285,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30),
                //                 image: DecorationImage(
                //                     image: NetworkImage(charity.image!),
                //                     fit: BoxFit.fill)),
                //           ),
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Column(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 width:scrWidth*0.6,
                //                 child: Text(charity.charityDetailes!,
                //                     maxLines: 5,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.036,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600)),
                //               ),
                //               SizedBox(
                //                 height: scrHeight * 0.02,
                //               ),
                //               // Container(
                //               //     height: scrHeight * 0.004,
                //               //     width: scrWidth * 0.55,
                //               //     child: LinearPercentIndicator(
                //               //       animation: true,
                //               //       animationDuration: 1000,
                //               //       percent: _items[index].value,
                //               //       backgroundColor: Color(0xffE9F6FF),
                //               //       progressColor: Color(0xff343434),
                //               //     )),
                //
                //               Row(
                //                 children: [
                //                   Text("0000000",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //                   Text("/",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //                   Text(
                //                     currencyConvert
                //                         .format(charity.valueAmount)
                //                         .toString(),
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //
                //                 ],
                //               ),
                //               SizedBox(height: scrHeight*0.02,),
                //
                //             ],
                //           )
                //         ],
                //       ),
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, int index) {
                //     return SizedBox(
                //       height: scrHeight * 0.025,
                //     );
                //   },
                // ),
                // ListView.separated(
                //   itemCount: charityDetailsList3.length,
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   physics: BouncingScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final charity=charityDetailsList3[index];
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => FundRaisingDashboard(charity: charity,)));
                //       },
                //       child: Row(
                //         children: [
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Container(
                //             height: scrHeight * 0.135,
                //             width: scrWidth * 0.285,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30),
                //                 image: DecorationImage(
                //                     image: NetworkImage(charity.image!),
                //                     fit: BoxFit.fill)),
                //           ),
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Column(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 width: scrWidth*0.6,
                //                 child: Text(charity.charityDetailes!,
                //                     maxLines: 5,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.036,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600)),
                //               ),
                //               SizedBox(
                //                 height: scrHeight * 0.02,
                //               ),
                //               // Container(
                //               //     height: scrHeight * 0.004,
                //               //     width: scrWidth * 0.55,
                //               //     child: LinearPercentIndicator(
                //               //       animation: true,
                //               //       animationDuration: 1000,
                //               //       percent: _items[index].value,
                //               //       backgroundColor: Color(0xffE9F6FF),
                //               //       progressColor: Color(0xff343434),
                //               //     )),
                //
                //               Row(
                //                 children: [
                //                   Text("0000000",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //                   Text("/",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //                   Text(
                //                     currencyConvert
                //                         .format(charity.valueAmount)
                //                         .toString(),
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //
                //                 ],
                //               ),
                //               SizedBox(height: scrHeight*0.02,),
                //
                //             ],
                //           )
                //         ],
                //       ),
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, int index) {
                //     return SizedBox(
                //       height: scrHeight * 0.025,
                //     );
                //   },
                // ),
                // ListView.separated(
                //   itemCount: charityDetailsList4.length,
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   physics: BouncingScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final charity=charityDetailsList4[index];
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => FundRaisingDashboard(charity: charity,)));
                //       },
                //       child: Row(
                //         children: [
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Container(
                //             height: scrHeight * 0.135,
                //             width: scrWidth * 0.285,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(30),
                //                 image: DecorationImage(
                //                     image: NetworkImage(charity.image!),
                //                     fit: BoxFit.fill)),
                //           ),
                //           SizedBox(
                //             width: scrWidth * 0.05,
                //           ),
                //           Column(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 width: scrWidth*0.6,
                //                 child: Text(charity.charityDetailes!,
                //                     maxLines: 5,
                //                     overflow: TextOverflow.ellipsis,
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.036,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600)),
                //               ),
                //               SizedBox(
                //                 height: scrHeight * 0.02,
                //               ),
                //               // Container(
                //               //     height: scrHeight * 0.004,
                //               //     width: scrWidth * 0.55,
                //               //     child: LinearPercentIndicator(
                //               //       animation: true,
                //               //       animationDuration: 1000,
                //               //       percent: _items[index].value,
                //               //       backgroundColor: Color(0xffE9F6FF),
                //               //       progressColor: Color(0xff343434),
                //               //     )),
                //
                //               Row(
                //                 children: [
                //                   Text("0000000",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //                   Text("/",
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //                   Text(
                //                     currencyConvert
                //                         .format(charity.valueAmount)
                //                         .toString(),
                //                     style: TextStyle(
                //                         fontSize: scrWidth * 0.039,
                //                         color: primarycolor,
                //                         fontFamily: 'Urbanist',
                //                         fontWeight: FontWeight.w600),
                //                   ),
                //
                //
                //                 ],
                //               ),
                //               SizedBox(height: scrHeight*0.02,),
                //
                //             ],
                //           )
                //         ],
                //       ),
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, int index) {
                //     return SizedBox(
                //       height: scrHeight * 0.025,
                //     );
                //   },
                // ),

            ),
          )
        ],
      ),
    );
  }
}
