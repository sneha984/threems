import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/Authentication/auth.dart';
import 'package:threems/model/usermodel.dart';

import '../../model/charitymodel.dart';
import '../../utils/themes.dart';
import '../../widgets/list.dart';
import '../splash_screen.dart';
import 'donatenowpage.dart';



class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage>with TickerProviderStateMixin {

  List<Widget> tabs =[];
  List<Widget> tabBars =[];

  // getCharitys(){
  //   FirebaseFirestore.instance
  //       .collection('charity')
  //       .where('userId',isNotEqualTo :currentuser!.userId)
  //       .snapshots().listen((event) {
  //
  //     for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
  //
  //       doc['cause'] == 0
  //           ? charityList1.add(CharityModel.fromJson(doc!.data()!))
  //           : doc['cause'] == 1
  //           ? charityList2.add(CharityModel.fromJson(doc!.data()!))
  //           : doc['cause']==2?charityList3.add(CharityModel.fromJson(doc!.data()!)):
  //       charityList4.add(CharityModel.fromJson(doc!.data()!));
  //     }
  //
  //     if (mounted) {
  //       setState(() {});
  //     }
  //       });
  //   print(charityList1.length);
  //   print(charityList2.length);
  //   print(charityList3.length);
  //   print(charityList4.length);
  // }
  Map<String,dynamic> causeMap={};
  Map<String,dynamic> charityLengthMap={};
  List<String> causes=[];
  getDropdown(){
    FirebaseFirestore.instance.collection('dropdown').snapshots().listen((event) {
      causes=[];
      tabs=[];
      tabBars=[];
      int i=0;
      _tabController = TabController(length: event.docs.length, vsync: this);
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        causeMap[doc.get('value')]=doc.data();
        causes.add(doc.get('value'));
        tabBars.add(
            StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
          stream:FirebaseFirestore.instance
              .collection('charity')
              .where('userId',isNotEqualTo :currentuser!.userId)
              .where('cause',isEqualTo:doc.get('causeId'))
              .snapshots(),
          builder: (context, snapshot) {

            List<CharityModel> charityList1 = [];
            if(snapshot.data==null){
              return Center(child: Text("No charity Found under this category"),);
            }
            for(DocumentSnapshot<Map<String,dynamic>> doc in snapshot.data!.docs){
              charityList1.add(CharityModel.fromJson(doc.data()!));
            }
            charityLengthMap[doc.get('value')]=charityList1.length;
            return ListView.separated(
              itemCount: charityList1.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index){
                final charities=charityList1[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>DonateNowPage(charities: charities,)));
                  },
                  child: Row(
                    children: [
                      SizedBox(width: scrWidth*0.05,),
                      Container(
                        height: scrHeight*0.138,
                        width: scrWidth*0.297,
                        decoration: BoxDecoration(
                          // color: Colors.grey,
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                                image: NetworkImage(charities.image!),fit: BoxFit.fill)
                        ),
                      ),
                      SizedBox(width: scrWidth*0.05,),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: scrWidth*0.6,
                            child: Text(charities.charityDetailes.toString(),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: scrWidth * 0.036,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(height: scrHeight*0.01,),

                          Row(
                            children: [
                              Text(charities.userName!,style: TextStyle(
                                  fontSize:scrWidth*0.036,
                                  color: Color(0xff827E7E),
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w500)),
                              SizedBox(width: scrWidth*0.009,),
                              SvgPicture.asset("assets/icons/Frame (1).svg"),

                            ],
                          ),
                          SizedBox(height: scrHeight*0.015,),


                          Text(
                            currencyConvert
                                .format(charities.valueAmount)
                                .toString(),
                            style: TextStyle(
                                fontSize: scrWidth * 0.039,
                                color: primarycolor,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(width: scrWidth*0.1,)
                        ],
                      )
                    ],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: scrHeight*0.025,);
            },
            );
          }
        ));
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
                    backgroundColor: Color(0xffD4D4D4),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('charity')
                          .where('userId',isNotEqualTo :currentuser!.userId)
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

  late  TabController _tabController;
  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  @override
  void initState() {
    // getCharitys();
    _tabController = TabController(length: 0, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getDropdown();
    super.initState();
  }
  void _handleTabSelection() {
    setState(() {
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:tabs.isEmpty?const Center(child: CircularProgressIndicator(),): DefaultTabController(
        length:tabs.length,
        child: Column(
          children: [
            Container(
              height: scrHeight*0.158,
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
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:  Padding(
                      padding: EdgeInsets.only(
                          top: scrHeight*0.1,
                          left: scrWidth*0.07,
                          // bottom: scrHeight*0.02,
                          right: scrWidth*0.05),
                      child:Container(
                        width: scrWidth*0.04,
                          height: scrHeight*0.03,
                          child: SvgPicture.asset("assets/icons/arrow.svg",)),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: scrHeight*0.1,),
                    child: Container(
                      height: scrHeight*0.042,
                      width: scrWidth*0.75,
                      decoration: BoxDecoration(
                          color: Color(0xffE9EEF3),

                          borderRadius: BorderRadius.circular(17)
                      ),
                      child: TextFormField(
                        decoration:  InputDecoration(
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(
                                  top: scrHeight*0.01,
                                  left: scrWidth*0.04,
                                  bottom: scrHeight*0.01,
                                  right: scrWidth*0.05),
                              child:SvgPicture.asset("assets/icons/Vector (4).svg",),
                            ),
                            border: InputBorder.none,
                            hintText: "Search Campaigns",
                            hintStyle: TextStyle(
                              fontFamily: 'Urbanist',fontWeight: FontWeight.w500,
                              fontSize: scrWidth*0.042,
                              color: Color(0xff8391A1),
                            )
                        ),
                        cursorColor: Colors.black,
                        cursorHeight: 20,
                        cursorWidth: 0.5,

                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: scrHeight*0.017,),
            Row(
              children: [
                SizedBox(width: scrWidth*0.045,),
                Container(
                  width: scrWidth*0.09,
                  height: scrHeight*0.04,
                  decoration: BoxDecoration(
                      color: primarycolor,
                      borderRadius: BorderRadius.circular(17.5)
                  ),
                  child:Padding(
                    padding:  EdgeInsets.only(top: scrHeight*0.01,bottom: scrHeight*0.01),
                    child: SvgPicture.asset("assets/icons/Group (1).svg",),
                  ),
                ),
                SizedBox(width: scrWidth*0.02,),
                Expanded(
                  child: Container(
                    height: scrHeight*0.037,
                    child: TabBar(
                        isScrollable: true,
                        indicatorWeight: 0.05,
                        controller: _tabController,
                        unselectedLabelColor: Color(0xffA7A7A7),
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Urbanist',fontSize: scrWidth*0.0385),
                        labelColor: Color(0xff0D0D0D),
                        labelStyle: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Urbanist',fontSize: scrWidth*0.0385),
                        // indicatorPadding: EdgeInsets.only(bottom: scrHeight*0.00,left: scrWidth*0.00,right: scrWidth*0.00),
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            color: Color.fromRGBO(169, 255, 188, 0.4)),
                        indicatorSize: TabBarIndicatorSize.label,
                        padding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
                        tabs:tabs,
                        //  indicatorWeight: 1,
                        // tabs: [
                        //   GestureDetector(
                        //     onTap: (){
                        //       setState(() {
                        //         _tabController.index=0;
                        //       });
                        //     },
                        //     child: Tab(
                        //       child: Container(
                        //         height: scrHeight*0.038,
                        //         width: scrWidth*0.27,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(17.5),
                        //             border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                        //         child: Row(
                        //           children: [
                        //             SizedBox(width: scrWidth*0.03,),
                        //             Text("Medical",),
                        //             SizedBox(width: scrWidth*0.025,),
                        //             Padding(
                        //               padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                        //               child: CircleAvatar(
                        //                 radius: 11,
                        //                 child: Text(charityList1.length.toString() ,style: tababrnumberFont),
                        //                 backgroundColor:(_tabController.index==0)? Colors.white:Color(0xffD4D4D4),
                        //
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   GestureDetector(
                        //     onTap: (){
                        //       setState(() {
                        //         _tabController.index=1;
                        //
                        //
                        //       });
                        //     },
                        //     child: Tab(
                        //       child: Container(
                        //         height: scrHeight*0.038,
                        //         width: scrWidth*0.27,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(17.5),
                        //             border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06),width: scrWidth*0.003)),
                        //         child: Row(
                        //           children: [
                        //             SizedBox(width: scrWidth*0.02,),
                        //             Text("Education"),
                        //             SizedBox(width: scrWidth*0.01,),
                        //             Padding(
                        //               padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                        //               child: CircleAvatar(
                        //
                        //                 radius: 11,
                        //                 child: Text(charityList2.length.toString(),style:  tababrnumberFont),
                        //                 backgroundColor:(_tabController.index==1)? Colors.white:Color(0xffD4D4D4),
                        //
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   GestureDetector(
                        //     onTap: (){
                        //       setState(() {
                        //         _tabController.index=2;
                        //       });
                        //     },
                        //     child: Tab(
                        //       child: Container(
                        //         height: scrHeight*0.038,
                        //         width: scrWidth*0.27,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(17.5),
                        //             border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                        //         child: Row(
                        //           children: [
                        //             SizedBox(width: scrWidth*0.04,),
                        //             Text("Disaster"),
                        //             SizedBox(width: scrWidth*0.009,),
                        //             Padding(
                        //               padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                        //               child: CircleAvatar(
                        //
                        //                 radius: 11,
                        //                 child: Text(charityList3.length.toString(),style: tababrnumberFont
                        //                 ),
                        //                 backgroundColor:(_tabController.index==2)? Colors.white:Color(0xffD4D4D4),
                        //
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        //   GestureDetector(
                        //     onTap: (){
                        //       setState(() {
                        //         _tabController.index=3;
                        //       });
                        //     },
                        //     child: Tab(
                        //       child: Container(
                        //         height: scrHeight*0.038,
                        //         width: scrWidth*0.27,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(17.5),
                        //             border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                        //         child: Row(
                        //           children: [
                        //             SizedBox(width: scrWidth*0.04,),
                        //             Text("Others"),
                        //             SizedBox(width: scrWidth*0.03,),
                        //             Padding(
                        //               padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                        //               child: CircleAvatar(
                        //
                        //                 radius: 11,
                        //                 child: Text(charityList4.length.toString(),style: tababrnumberFont
                        //                 ),
                        //                 backgroundColor:(_tabController.index==3)? Colors.white:Color(0xffD4D4D4),
                        //
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ]
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: scrHeight*0.001,),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabBars,
                //[
                  // ListView.separated(
                  //   itemCount: charityList1.length,
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   physics: BouncingScrollPhysics(),
                  //   itemBuilder: (context,index){
                  //     final charities=charityList1[index];
                  //     return GestureDetector(
                  //       onTap: (){
                  //          Navigator.push(context,MaterialPageRoute(builder: (context)=>DonateNowPage(charities: charities,)));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Container(
                  //             height: scrHeight*0.138,
                  //             width: scrWidth*0.297,
                  //             decoration: BoxDecoration(
                  //               // color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 image: DecorationImage(
                  //                     image: NetworkImage(charities.image!),fit: BoxFit.fill)
                  //             ),
                  //           ),
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Column(
                  //             mainAxisSize: MainAxisSize.max,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 width: scrWidth*0.6,
                  //                 child: Text(charities.charityDetailes.toString(),
                  //                     maxLines: 5,
                  //                     overflow: TextOverflow.ellipsis,
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.036,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600)),
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               Row(
                  //                 children: [
                  //                   Text(charities.beneficiaryName!,style: TextStyle(
                  //                       fontSize:scrWidth*0.036,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500)),
                  //                   SizedBox(width: scrWidth*0.009,),
                  //                   SvgPicture.asset("assets/icons/Frame (1).svg"),
                  //
                  //                 ],
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //               Container(
                  //                   height: scrHeight*0.003,
                  //                   width: scrWidth*0.55,
                  //                   child: LinearPercentIndicator(
                  //                     percent: _list[index].value,
                  //                     backgroundColor: Color(0xffE9F6FF),
                  //                     animation: true,
                  //                     animationDuration: 1000,
                  //                     progressColor: Color(0xff343434),
                  //                   )
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               // SizedBox(height: scrHeight*0.024,),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     currencyConvert
                  //                         .format(charities.valueAmount)
                  //                         .toString(),
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.039,
                  //                         color: primarycolor,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600),
                  //                   ),
                  //                   SizedBox(width: scrWidth*0.17,),
                  //                   Text(_list[index].days,style: TextStyle(
                  //                       fontSize:scrWidth*0.03,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500),),
                  //                 ],
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }, separatorBuilder: (BuildContext context, int index) {
                  //   return SizedBox(height: scrHeight*0.025,);
                  // },
                  // ),
                  // ListView.separated(
                  //   itemCount: charityList2.length,
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   physics: BouncingScrollPhysics(),
                  //   itemBuilder: (context,index){
                  //     final charities=charityList2[index];
                  //     return GestureDetector(
                  //       onTap: (){
                  //         Navigator.push(context,MaterialPageRoute(builder: (context)=>DonateNowPage(charities: charities,)));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Container(
                  //             height: scrHeight*0.138,
                  //             width: scrWidth*0.297,
                  //             decoration: BoxDecoration(
                  //               // color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 image: DecorationImage(
                  //                     image: NetworkImage(charities.image!),fit: BoxFit.fill)
                  //             ),
                  //           ),
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Column(
                  //             mainAxisSize: MainAxisSize.max,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 width: scrWidth*0.6,
                  //                 child: Text(charities.charityDetailes.toString(),
                  //                     maxLines: 5,
                  //                     overflow: TextOverflow.ellipsis,
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.036,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600)),
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               Row(
                  //                 children: [
                  //                   Text(charities.userName!,style: TextStyle(
                  //                       fontSize:scrWidth*0.036,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500)),
                  //                   SizedBox(width: scrWidth*0.009,),
                  //                   SvgPicture.asset("assets/icons/Frame (1).svg"),
                  //
                  //                 ],
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //               Container(
                  //                   height: scrHeight*0.003,
                  //                   width: scrWidth*0.55,
                  //                   child: LinearPercentIndicator(
                  //                     percent: _list[index].value,
                  //                     backgroundColor: Color(0xffE9F6FF),
                  //                     animation: true,
                  //                     animationDuration: 1000,
                  //                     progressColor: Color(0xff343434),
                  //                   )
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               // SizedBox(height: scrHeight*0.024,),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     currencyConvert
                  //                         .format(charities.valueAmount)
                  //                         .toString(),
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.039,
                  //                         color: primarycolor,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600),
                  //                   ),
                  //                   SizedBox(width: scrWidth*0.1,),
                  //                   Text(_list[index].days,style: TextStyle(
                  //                       fontSize:scrWidth*0.03,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500),),
                  //                 ],
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }, separatorBuilder: (BuildContext context, int index) {
                  //   return SizedBox(height: scrHeight*0.025,);
                  // },
                  // ),
                  // ListView.separated(
                  //   itemCount: charityList3.length,
                  //   shrinkWrap: true,
                  //   // scrollDirection: Axis.vertical,
                  //   // physics: BouncingScrollPhysics(),
                  //   itemBuilder: (context,index){
                  //     final charities=charityList3[index];
                  //     return GestureDetector(
                  //       onTap: (){
                  //         Navigator.push(context,MaterialPageRoute(builder: (context)=>DonateNowPage(charities: charities,)));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Container(
                  //             height: scrHeight*0.138,
                  //             width: scrWidth*0.297,
                  //             decoration: BoxDecoration(
                  //               // color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 image: DecorationImage(
                  //                     image: NetworkImage(charities.image!),fit: BoxFit.fill)
                  //             ),
                  //           ),
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Column(
                  //             mainAxisSize: MainAxisSize.max,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 width: scrWidth*0.6,
                  //                 child: Text(charities.charityDetailes.toString(),
                  //                     maxLines: 5,
                  //                     overflow: TextOverflow.ellipsis,
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.036,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600)),
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               Row(
                  //                 children: [
                  //                   Text(charities.userName!,style: TextStyle(
                  //                       fontSize:scrWidth*0.036,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500)),
                  //                   SizedBox(width: scrWidth*0.009,),
                  //                   SvgPicture.asset("assets/icons/Frame (1).svg"),
                  //
                  //                 ],
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //               Container(
                  //                   height: scrHeight*0.003,
                  //                   width: scrWidth*0.55,
                  //                   child: LinearPercentIndicator(
                  //                     percent: _list[index].value,
                  //                     backgroundColor: Color(0xffE9F6FF),
                  //                     animation: true,
                  //                     animationDuration: 1000,
                  //                     progressColor: Color(0xff343434),
                  //                   )
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               // SizedBox(height: scrHeight*0.024,),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     currencyConvert
                  //                         .format(charities.valueAmount)
                  //                         .toString(),
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.039,
                  //                         color: primarycolor,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600),
                  //                   ),
                  //                   SizedBox(width: scrWidth*0.17,),
                  //                   Text(_list[index].days,style: TextStyle(
                  //                       fontSize:scrWidth*0.03,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500),),
                  //                 ],
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }, separatorBuilder: (BuildContext context, int index) {
                  //   return SizedBox(height: scrHeight*0.025,);
                  // },
                  // ),
                  // ListView.separated(
                  //   itemCount: charityList4.length,
                  //   shrinkWrap: true,
                  //   scrollDirection: Axis.vertical,
                  //   physics: BouncingScrollPhysics(),
                  //   itemBuilder: (context,index){
                  //     final charities=charityList4[index];
                  //     return GestureDetector(
                  //       onTap: (){
                  //         Navigator.push(context,MaterialPageRoute(builder: (context)=>DonateNowPage(charities: charities,)));
                  //       },
                  //       child: Row(
                  //         children: [
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Container(
                  //             height: scrHeight*0.138,
                  //             width: scrWidth*0.297,
                  //             decoration: BoxDecoration(
                  //               // color: Colors.grey,
                  //                 borderRadius: BorderRadius.circular(30),
                  //                 image: DecorationImage(
                  //                     image: NetworkImage(charities.image!),fit: BoxFit.fill)
                  //             ),
                  //           ),
                  //           SizedBox(width: scrWidth*0.05,),
                  //           Column(
                  //             mainAxisSize: MainAxisSize.max,
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               // Text(charities.charityDetailes!,style: TextStyle(
                  //               //     fontSize:scrWidth*0.036,
                  //               //     fontFamily: 'Urbanist',
                  //               //     fontWeight: FontWeight.w600)),
                  //               Container(
                  //                 width: scrWidth*0.6,
                  //                 child: Text(charities.charityDetailes.toString(),
                  //                     maxLines: 5,
                  //                     overflow: TextOverflow.ellipsis,
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.036,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600)),
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               Row(
                  //                 children: [
                  //                   Text(charities.beneficiaryName!,
                  //                       style: TextStyle(
                  //                       fontSize:scrWidth*0.036,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500)),
                  //                   SizedBox(width: scrWidth*0.009,),
                  //                   SvgPicture.asset("assets/icons/Frame (1).svg"),
                  //
                  //                 ],
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //               Container(
                  //                   height: scrHeight*0.003,
                  //                   width: scrWidth*0.55,
                  //                   child: LinearPercentIndicator(
                  //                     percent: _list[index].value,
                  //                     backgroundColor: Color(0xffE9F6FF),
                  //                     animation: true,
                  //                     animationDuration: 1000,
                  //                     progressColor: Color(0xff343434),
                  //                   )
                  //               ),
                  //               SizedBox(height: scrHeight*0.01,),
                  //
                  //               // SizedBox(height: scrHeight*0.024,),
                  //               Row(
                  //                 children: [
                  //                   Text(
                  //                     currencyConvert
                  //                         .format(charities.valueAmount)
                  //                         .toString(),
                  //                     style: TextStyle(
                  //                         fontSize: scrWidth * 0.039,
                  //                         color: primarycolor,
                  //                         fontFamily: 'Urbanist',
                  //                         fontWeight: FontWeight.w600),
                  //                   ),
                  //                   SizedBox(width: scrWidth*0.17,),
                  //                   Text(_list[index].days,style: TextStyle(
                  //                       fontSize:scrWidth*0.03,
                  //                       color: Color(0xff827E7E),
                  //                       fontFamily: 'Urbanist',
                  //                       fontWeight: FontWeight.w500),),
                  //                 ],
                  //               )
                  //             ],
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   }, separatorBuilder: (BuildContext context, int index) {
                  //   return SizedBox(height: scrHeight*0.025,);
                  // },
                  // ),
               // ],//
              ),
            )
          ],
        ),
      ),
    );
  }
}
