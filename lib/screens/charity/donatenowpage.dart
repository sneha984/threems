import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:threems/Authentication/auth.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/screens/charity/payment.dart';
import 'package:threems/screens/charity/pdfviewpage.dart';
import 'package:threems/screens/charity/verification_details.dart';
import 'package:threems/simple.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../model/charitymodel.dart';
import '../../utils/themes.dart';
import '../../widgets/flchart.dart';
import '../splash_screen.dart';

List totalAmounts=[];
double sum=0;
class DonateNowPage extends StatefulWidget {
  final CharityModel charities;

  const DonateNowPage({Key? key, required this.charities}) : super(key: key);

  @override
  State<DonateNowPage> createState() => _DonateNowPageState();
}

class _DonateNowPageState extends State<DonateNowPage>with TickerProviderStateMixin {
  late YoutubePlayerController _controllers;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
   bool onclick=true;
  var videoId;
  late PlayerState _playerState;
  Duration? remainingTime;
  int count = 1;

  CharityModel? chari;
  getDonation(){
    FirebaseFirestore
        .instance
        .collection('charity').doc(widget.charities.charityId).snapshots().listen((event) {
          chari=CharityModel.fromJson(event.data()!);

          if(mounted){
            setState(() {

            });
          }
    });
  }

  getTime() async {
    DateTime deadLine = widget.charities.endDate!.toDate();
    for (int i = count; i > 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      remainingTime = deadLine.difference(DateTime.now());
      // DateTime.now().difference(launch);
    }

    print(mounted);

    if (mounted) {
      setState(() {});
    }
    getTime();
  }

  final ScrollController _controller = ScrollController();
  final double _height = 100.0;
  void _animateToIndex(int index) {
    _controller.animateTo(
      index * _height,
      duration: Duration(seconds: 1),
       curve: Curves.linear,
    );
  }
  getAmount(){
    for(int i=0;i<widget.charities.payments!.length;i++){
      double x=widget.charities.payments![i].amount!;
      totalAmounts.add(x);
      sum=sum+x;

    }
  }


  late  TabController _tabControllerr;

  @override

  void initState() {

    _tabControllerr = TabController(length: 4, vsync: this);
    _tabControllerr.addListener(_handleTabSelection);

    super.initState();
    getAmount();
    getTime();
    getDonation();
    _controllers = YoutubePlayerController(
      initialVideoId:videoId=YoutubePlayer.convertUrlToId(widget.charities.youTubeLink!).toString(),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay:false,
        loop: false,
        isLive: false,
        forceHD: false,
      ),
    );
  }
  void _handleTabSelection() {
    setState(() {
    });
  }
  void listener() {
    if (_isPlayerReady && mounted && !_controllers.value.isFullScreen) {
      setState(() {
        _playerState = _controllers.value.playerState;
        _videoMetaData = _controllers.metadata;
      });
    }
  }

  var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  @override
  void deactivate() {
    _controllers.pause();
    super.deactivate();
  }
  @override
  void dispose() {
    _controllers.dispose();

    super.dispose();
    _tabControllerr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime deadLine = widget.charities.endDate!.toDate();
    final DateFormat formatter = DateFormat('dd MMMM yyyy');
    final String formatted = formatter.format(deadLine);
    // double sum=0;
    // List payAmount=[];
    // for(int i=0;i<widget.charities.payments!.length;i++){
    //   double x=widget.charities.payments![i].amount!;
    //   payAmount.add(x);
    //   sum=sum+x;
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        // leadingWidth:600,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: scrHeight * 0.02,
               left: scrWidth * 0.05,
               bottom: scrHeight * 0.01,
                right: scrWidth * 0.04),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top: 6),
          child: Text("Back",style: TextStyle(
              fontSize: scrWidth*0.045,
              color: Colors.black,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w700),),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: scrHeight*0.023,bottom: scrHeight*0.015,right: scrWidth*0.03),
            child: Container(
              height: scrHeight*0.07,
              width: scrWidth * 0.34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primarycolor,
              ),
              child: Center(
                child: Text(
                  "${chari?.payments?.length??0} Supporters",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: scrWidth*0.036,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
         // physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  height: scrWidth*0.6,
                  width:scrWidth,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffBEFFCC),
                          Color.fromRGBO(190, 255, 204, 0) ,
                        ],
                      )
                  ),
                ),
                SizedBox(
                  height: scrHeight*2.3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scrHeight*0.025,),
                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.05),
                        child: Container(
                          height: scrHeight*0.18,
                          width: scrWidth*0.9,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.20), // shadow color
                                    blurRadius: 15, // shadow radius
                                    offset: Offset(5, 10), // shadow offset
                                    spreadRadius:
                                    0.4, // The amount the box should be inflated prior to applying the blur
                                    blurStyle: BlurStyle.normal // set blur style
                                ),
                              ],
                            // image: DecorationImage(
                            //     image: NetworkImage(widget.charities.image!),
                            //     fit: BoxFit.fill
                            // ),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(scrWidth * 0.09),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:widget.charities?.image??'',
                            ),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   right: 10,
                      //   top: 10,
                      //   child: Container(
                      //     height: scrHeight*0.03,
                      //     width: scrWidth*0.16,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white.withOpacity(0.7),
                      //         borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: Center(
                      //       child: Row(
                      //         children: [
                      //           SizedBox(width: scrWidth*0.03,),
                      //
                      //           Text("Edit",style: TextStyle(
                      //             fontSize: scrWidth*0.035,
                      //             fontFamily: 'Urbanist',
                      //             fontWeight: FontWeight.w600,
                      //             color: Colors.white
                      //           ),),
                      //           SizedBox(width:scrWidth*0.01,),
                      //           SvgPicture.asset("assets/icons/Group 143.svg")
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: scrHeight*0.03,),

                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: scrWidth*0.05),
                            child: Container(
                              width: scrWidth*0.76,
                              child: Text(widget.charities.charityDetailes!,style: TextStyle(
                                fontSize: scrWidth*0.045,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Urbanist'
                              ),),
                            ),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(top: scrHeight*0.06),
                            child: Text(
                              remainingTime == null
                                ? "..."
                                : "${remainingTime?.inDays} Days Left"
                                .toString(),
                                style: TextStyle(
                                fontSize: scrWidth*0.027,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                                color: Color(0xff827E7E)
                            ),),
                          ),

                        ],
                      ),
                      SizedBox(height: scrHeight*0.02,),
                      Row(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: scrWidth*0.05),
                            child: Container(
                              height: scrHeight*0.15,
                              width: scrWidth*0.01,
                              decoration: BoxDecoration(
                                color: Color(0xff28B446),
                              ),

                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: scrWidth*0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Created by",style: TextStyle(
                                    fontSize: scrWidth*0.033,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffA0A0A0)
                                ),),
                                SizedBox(height: scrHeight*0.008,),

                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: scrWidth*0.035,
                                      backgroundImage:NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiuZGp08DDSD0P3PMfKSbbPu2nVmJdH74gHg&usqp=CAU"),
                                    ),
                                    SizedBox(width: scrWidth*0.02,),
                                    Text(widget.charities.orgName!,style: TextStyle(
                                        fontSize: scrWidth*0.045,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff353333)
                                    ),),
                                    SizedBox(width: scrWidth*0.01,),
                                    SvgPicture.asset("assets/icons/Frame (1).svg"),
                                  ],
                                ),
                                SizedBox(height: scrHeight*0.01,),
                                Text("The fund will benifit for",style: TextStyle(
                                    fontSize: scrWidth*0.033,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffA0A0A0)
                                ),),
                                SizedBox(height: scrHeight*0.015,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(widget.charities.beneficiaryName!,style: TextStyle(
                                        fontSize: scrWidth*0.045,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff353333)
                                    ),),
                                    // SizedBox(width:scrWidth*0.5,),
                                    // SvgPicture.asset("assets/icons/whatsapp_icon.svg")
                                  ],
                                ),
                                SizedBox(height: scrHeight*0.002,),
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/icons/location.svg"),
                                    SizedBox(width: scrWidth*0.01,),
                                    Text(widget.charities.beneficiaryLocation!,style: TextStyle(
                                        fontSize: scrWidth*0.032,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffA0A0A0)),),],)],),)],),
                              SizedBox(height: scrHeight*0.025,),
                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                          //               Expanded(
                          //                 child: ClipRect(
                          //                   child: Align(
                          //                     heightFactor: 0.35,
                          //                     child: Padding(
                          //                       padding:  EdgeInsets.only(left: scrWidth*0.07,right: scrWidth*0.03),
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
                          //                 pointers: <GaugePointer>[
                          //                   RangePointer(
                          //                       value: 110,
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
                          //                     value: 110,
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
                          //                     widget:Text("28%",textAlign: TextAlign.center,style: TextStyle(
                          //                         fontSize: 23,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
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
                                    fontSize: scrWidth*0.039,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w500),),
                                SizedBox(height: scrHeight*0.006,),

                                Text(currencyConvert
                                    .format(chari!.totalReceived??0)
                                    .toString(),style: TextStyle(
                                    fontSize: scrWidth*0.075,
                                    color: primarycolor,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w700),),
                                SizedBox(height: scrHeight*0.004,),

                                Row(
                                  children: [
                                    Text("Out of ",style: TextStyle(
                                        fontSize: scrWidth*0.039,
                                        color: Colors.black,
                                        fontFamily: 'Urbanist',
                                        fontWeight: FontWeight.w600),),
                                    Text(currencyConvert
                                        .format(widget.charities.valueAmount)
                                        .toString(),style: TextStyle(
                                        fontSize: scrWidth*0.039,
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
                      // SizedBox(height: scrHeight*0.02,),
                  //     Padding(
                  //       padding:  EdgeInsets.only(left: scrWidth*0.05),
                  //       child: Text("Analytics",style: TextStyle(
                  //           fontSize: scrHeight*0.02,
                  //           fontFamily: 'Urbanist',
                  //           fontWeight: FontWeight.w500,
                  //
                  //       ),),
                  //     ),
                  //     SizedBox(height: scrHeight*0.025,),
                  // Container(
                  //   height: scrHeight*0.042,
                  //   width: scrWidth*0.92,
                  //   child: TabBar(
                  //       labelPadding: EdgeInsets.only(left: scrWidth*0.019,right: scrWidth*0.019),
                  //       unselectedLabelStyle: TextStyle(
                  //         fontFamily: 'Poppins',fontSize: scrWidth*0.04,fontWeight: FontWeight.w400
                  //     ),
                  //       unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.3),
                  //       indicatorSize: TabBarIndicatorSize.label,
                  //       labelColor: Colors.white,
                  //       labelStyle: TextStyle(
                  //           fontFamily: 'Poppins',fontSize: scrWidth*0.04,fontWeight: FontWeight.w400
                  //       ),
                  //       indicator: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(60),
                  //           color: primarycolor
                  //       ),
                  //     isScrollable: true,
                  //     controller: _tabControllerr,
                  //       tabs: [
                  //     Container(
                  //       height: scrHeight*0.047,
                  //       width:scrWidth*0.23,
                  //       decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(60),
                  //           color: Color.fromRGBO(0, 0, 0, 0.05)
                  //       ),
                  //       child: Center(child: Text("Day",)),),
                  //         Container(
                  //           height: scrHeight*0.047,
                  //           width:scrWidth*0.23,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(60),
                  //
                  //               color: Color.fromRGBO(0, 0, 0, 0.05)
                  //           ),
                  //           child: Center(child: Text("Week",)),),
                  //         Container(
                  //           height: scrHeight*0.047,
                  //           width:scrWidth*0.23,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(60),
                  //               color: Color.fromRGBO(0, 0, 0, 0.05)
                  //           ),
                  //           child: Center(child: Text("Month",)),),
                  //         Container(
                  //           height: scrHeight*0.047,
                  //           width:scrWidth*0.23,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(60),
                  //               color: Color.fromRGBO(0, 0, 0, 0.05)
                  //           ),
                  //           child: Center(child: Text("Year",)),),
                  //   ]),
                  // ),
                  // Expanded(
                  //   child: TabBarView(
                  //     controller: _tabControllerr,
                  //       children: [
                  //         Container(),
                  //         Container(),
                  //         Padding(
                  //           padding:  EdgeInsets.only(left: scrWidth*0.04,right: scrWidth*0.04),
                  //           child: Flchartpage(),),
                  //         Container(),
                  //       ]
                  //   ),
                  // ),
                      // SizedBox(height: scrHeight*0.01,),
                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.05),
                        child: Text("Bank Details",style: TextStyle(
                          fontSize: scrWidth*0.047,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                      // SizedBox(height: scrHeight*0.03,),
                      // Padding(
                      //   padding:EdgeInsets.only(),
                      //   child: Image(image: AssetImage("assets/icons/card 2.png")),
                      // ),
                      Stack(
                        children: [
                          Container(
                            width: scrWidth*1,
                            height: scrHeight*0.3,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("assets/images/card desigbn.png"),fit: BoxFit.fill)
                            ),
                          ),
                          Positioned(
                            top: scrHeight*0.04,
                              left: scrWidth*0.15,
                              child: Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: scrWidth*0.3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(widget.charities.bankName!,style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),
                                        SizedBox(height: scrHeight*0.005,),
                                        Text("IFSC : ${widget.charities.ifscCode}",style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: scrHeight*0.05,),
                                  Padding(
                                    padding:  EdgeInsets.only(right: scrWidth*0.6),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Banking Name",style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),
                                        SizedBox(height: scrHeight*0.002,),
                                        Text(widget.charities.accountHolderName!,style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),
                                        SizedBox(height: scrHeight*0.005,),
                                        Text("Account Number",style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),
                                        SizedBox(height: scrHeight*0.002,),

                                        Text(widget.charities.accountNumber!,style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white
                                        ),),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: scrHeight*0.0,),
                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.05),
                        child: Text("Supporting Documents",style: TextStyle(
                          fontSize: scrWidth*0.047,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),),
                      ),
                      // SizedBox(height: scrHeight*0.02,),
                      // Padding(
                      //   padding: EdgeInsets.only(left: scrWidth*0.05),
                      //   child: Container(
                      //     height: scrHeight*0.2,
                      //     width: scrWidth,
                      //     // color: Colors.red,
                      //     child: ListView.separated(
                      //       controller: _controller,
                      //       physics: BouncingScrollPhysics(),
                      //       separatorBuilder: (context, index) => SizedBox(
                      //         width: scrWidth * 0.028,
                      //       ),
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: _items.length,
                      //       itemBuilder: (context, index) {
                      //         return Container(
                      //           child: Row(
                      //             children: [
                      //                Container(
                      //                 height: scrHeight*0.18,
                      //                 width: scrWidth*0.256,
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(8),
                      //                 ),
                      //                 child: ClipRRect(
                      //                   borderRadius: BorderRadius.circular(8),
                      //                   child: CachedNetworkImage(
                      //                     imageUrl:_items[index],
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //               ),
                      //               (index==2)?InkWell(
                      //                 onTap: (){
                      //                   _animateToIndex(3);
                      //                   },
                      //                 child: Padding(
                      //                   padding: EdgeInsets.only(right: 10),
                      //                   child: CircleAvatar(
                      //                     radius: scrWidth*0.04,
                      //                     backgroundColor: Colors.green,
                      //                     child:SvgPicture.asset("assets/icons/arrownext.svg")
                      //                   ),
                      //                 ),
                      //               ):Container(),
                      //             ],
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //   ),
                      // ),

                      InkWell(
                        onTap: (){
                          print("-----------------------------------mmmmmmmmmmmmmmmmmmmmmmm------------------------");
                                 print(widget.charities.fileNme);
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context)=>PdfViewPage(charity:widget.charities,)
                                 ));

                        },
                        child: Container(
                          height: 119,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage("assets/icons/pdfimage.png"),fit: BoxFit.fill)
                                ),
                              ),
                               Padding(
                                 padding:  EdgeInsets.only(left: scrWidth*0.07),
                                 child: Text(widget.charities.fileNme!,style: TextStyle(
                                   fontWeight: FontWeight.w400,
                                 ),),
                               ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: scrHeight*0.02,),

                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.05),
                        child: Text("Genuinity Documents",style: TextStyle(
                          fontSize: scrWidth*0.047,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700,
                        ),),
                      ),
                      SizedBox(height: scrHeight*0.02,),
                      InkWell(
                        onTap: (){
                          print("-----------------------------------mmmmmmmmmmmmmmmmmmmmmmm------------------------");
                          print(widget.charities.docNme!);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>PdfPage(charitys:widget.charities,)
                          ));

                        },
                        child: Container(
                          height: 119,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage("assets/icons/pdfimage.png"),fit: BoxFit.fill)
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(left: scrWidth*0.07),
                                child: Text(widget.charities.docNme??'',style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: scrHeight*0.02,),
                      Padding(
                        padding:  EdgeInsets.only(left: scrWidth*0.05),
                        child: Text("Videos",style: TextStyle(
                          fontSize: scrWidth*0.047,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                      SizedBox(height: scrHeight*0.02,),
                      GestureDetector(
                        onTap: (){
                         setState(() {
                            onclick;
                         });
                         //  Uri call = Uri.parse(
                         //      'https://${widget.charities.youTubeLink!}');
                         //
                         //  launchUrl(call);

                        },
                          child: Padding(
                            padding:  EdgeInsets.only(left: 15,right: 15),
                            child: YoutubePlayer(
                              controller: _controllers,
                              aspectRatio: 16 / 9,
                              showVideoProgressIndicator:false,
                              progressColors: ProgressBarColors(
                                playedColor: Colors.white,
                                handleColor: Colors.white,
                              ),
                              onReady: () {
                                _controller.addListener(listener);
                              },
                            ),
                          // ),
                      ),

                      // Padding(
                      //   padding:  EdgeInsets.only(left: scrWidth*0.05),
                      //   child: Container(
                      //     width: scrWidth*0.9,
                      //     height: scrHeight*0.2,
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //           image: NetworkImage(
                      //               "https://ichef.bbci.co.uk/news/976/cpsprodpb/920A/production/_103068373_048715246-1.jpg"),
                      //           fit: BoxFit.fill
                      //       ),
                      //       boxShadow: const [
                      //         BoxShadow(
                      //             color: Color.fromRGBO(0, 0, 0, 0.20), // shadow color
                      //             blurRadius: 15, // shadow radius
                      //             offset: Offset(5, 10), // shadow offset
                      //             spreadRadius:
                      //             0.4, // The amount the box should be inflated prior to applying the blur
                      //             blurStyle: BlurStyle.normal // set blur style
                      //         ),
                      //       ],
                      //     ),
                      //     child: Center(
                      //         child:SvgPicture.asset("assets/icons/youtubeicon.svg")
                      //
                      //     ),
                      //
                      //   ),
                      // ),
                      ),
                      SizedBox(height: scrHeight*0.02,),
                      InkWell(
                        onTap: (){
                          Uri? video=Uri.tryParse(widget.charities.videoLink!);
                        launchUrl(video!);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 19,bottom: 10,right: 19),
                          child: Text(widget.charities.videoLink??'',style: TextStyle(color: Colors.indigo),),
                        ),

                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(left: scrWidth*0.05),
                            child: Text("Supporters",style: TextStyle(
                              fontSize: scrWidth*0.047,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),),
                          ),
                          Row(
                            children: [
                              Text("see more",style: TextStyle(
                                fontSize: scrWidth*0.04,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w500,
                              ),),
                              SizedBox(width: scrWidth*0.01,),


                              CircleAvatar(
                                radius: scrWidth*0.02,
                                backgroundColor: Colors.green,
                                child: Center(child: SvgPicture.asset("assets/icons/smallarrow.svg")),
                              ),
                               SizedBox(width: scrWidth*0.04,)

                            ],
                          )

                        ],
                      ),
                      SizedBox(height: scrHeight*0.025,),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                          itemCount: chari!.payments!.length??0,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                            // print(widget.charities.payments![index].amount);
                            final data=chari!.payments![index];
                            return Padding(
                              padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.04),
                              child: Container(
                                height: scrHeight*0.09,
                                width: scrWidth*0.03,
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
                                    SizedBox(width: scrWidth*0.03,),
                                    CircleAvatar(
                                      radius: 19,
                                      backgroundImage:
                                      NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQiuZGp08DDSD0P3PMfKSbbPu2nVmJdH74gHg&usqp=CAU"),
                                    ),
                                    SizedBox(width: scrWidth*0.055,),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: scrHeight*0.031,),
                                        Text(data.userName!,style: TextStyle(
                                          fontSize: scrWidth*0.035,
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w600,
                                        ),),

                                        // Text("12 june 22",style: TextStyle(
                                        //     fontSize: scrWidth*0.025,
                                        //     fontFamily: 'Urbanist',
                                        //     fontWeight: FontWeight.w500,
                                        //     color: Color(0xff8B8B8B)
                                        // ),),
                                      ],
                                    ),
                                    SizedBox(width: scrWidth*0.1,),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          // Text(currencyConvert.format(data.amount).toString(),style: TextStyle(
                                          //     fontSize: scrWidth*0.046,
                                          //     fontFamily: 'Urbanist',
                                          //     fontWeight: FontWeight.w700,
                                          //     color: primarycolor),),
                                          SizedBox(width: scrWidth*0.01,),
                                          chari==null?Container():(chari!.payments![index].verified==false)?
                                          InkWell(
                                            onTap: (){
                                              // bottomsheets(context);
                                            },
                                            child: Container(
                                              height:25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(image:AssetImage("assets/icons/warning.png")
                                                    ,fit: BoxFit.fill),
                                              ),

                                            ),
                                          ) :Container(),

                                          SizedBox(width: scrWidth*0.02,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: scrHeight*0.015,
                          ),
                      ),
                      ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar:widget.charities.status==1? Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: GestureDetector(
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(charitymodel: widget.charities,)));
          },
          child: Container(
            height: scrHeight*0.073,
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(width: scrWidth*0.035,),
                Container(
                  height: scrHeight*0.06,
                  width: scrWidth*0.9,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(17)
                  ),
                  child:Center(
                    child: Text("DONATE NOW",style: TextStyle(
                        fontSize: scrWidth*0.035,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w800,
                        color: Color(0xffFFFFFF)
                    ),),
                  ),
                ),
                SizedBox(width: scrWidth*0.04,),
                // Container(
                //   height: scrHeight*0.06,
                //   width: scrWidth*0.14,
                //   decoration: BoxDecoration(
                //       color: primarycolor,
                //       borderRadius: BorderRadius.circular(17),
                //
                //   ),
                //   child: Padding(
                //     padding:  EdgeInsets.only(top: scrHeight*0.015,bottom: scrHeight*0.015),
                //     child: SvgPicture.asset("assets/icons/share.svg"),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ):SizedBox(),

    );
  }
  void bottomsheets(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: scrHeight*0.3,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                    child: Text(
                      "Please Report to Admin ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    )),
                SizedBox(height: scrHeight*0.07,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);

                      },
                      child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Center(child: Text("Cancel",style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Urbanist'),),),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        CharityModel chrt=widget.charities;
                        FirebaseFirestore.instance.collection('charityReport').add(chrt.toJson()).then((value) => value.update({
                          "reportDate":DateFormat.yMMMd().format(DateTime.now()),
                        }));
                        },
                      child: Container(
                        height: 45,
                        width: 100,
                        decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: Text("Ok",style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Urbanist'),),),

                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
