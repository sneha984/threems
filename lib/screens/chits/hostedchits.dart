import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/pagess/hosteddraft.dart';
import 'package:threems/pagess/hosteddrawn.dart';
import 'package:threems/pagess/pendingapprovelpage.dart';
import 'package:threems/screens/chits/hostedchitpers.dart';
import 'package:threems/screens/chits/vacantchitjoin.dart';
import 'package:threems/screens/chits/yourchitpage.dart';

import '../../utils/customclip.dart';
import '../../utils/themes.dart';
import '../splash_screen.dart';
import 'create_new_chit_screen.dart';


class HostedChitPage extends StatefulWidget {
  const HostedChitPage({Key? key}) : super(key: key);

  @override
  State<HostedChitPage> createState() => _HostedChitPageState();
}

class _HostedChitPageState extends State<HostedChitPage>with TickerProviderStateMixin  {
  late  TabController _tabControllers;
  @override
  void initState() {
    _tabControllers = TabController(length: 3, vsync: this);
    _tabControllers.addListener(_handleTabSelection);

    super.initState();
  }
  void _handleTabSelection() {
    setState(() {
    });
  }
  @override
  void dispose() {
    super.dispose();
    _tabControllers.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
          centerTitle: false,


          elevation:0.1,
        backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child:  Padding(
              padding: EdgeInsets.only(top: scrHeight*0.04,
                  left: scrWidth*0.07,bottom: scrHeight*0.02,right: scrWidth*0.05),
              child:SvgPicture.asset("assets/icons/arrow.svg",),
            ),
          ),
          title: Padding(
            padding:  EdgeInsets.only(top: scrHeight*0.02),
            child: Text(
              "Chits",
              style: TextStyle(
                  fontSize: scrWidth*0.045,
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w700),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: scrHeight*0.04,
                  left: scrWidth*0.07,bottom: scrHeight*0.02,right: scrWidth*0.04),
              child:SvgPicture.asset("assets/icons/search.svg",),
            ),

            Padding(
              padding:  EdgeInsets.only(right: scrWidth*0.04,top: scrHeight*0.046,bottom: scrHeight*0.026),
              child: InkWell(
                onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateNewChitScreen()));
                },
                child: Container(
                  height: scrHeight*0.07,
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
                        "Create Chit",
                        style: TextStyle(
                            color: Colors.white,
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
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(
              top: scrHeight*0.03,
              bottom: scrHeight*0.025
            ),
            child: Container(
              height: scrHeight*0.037,
              child: TabBar(
                  isScrollable: true,
                   indicatorWeight: 0.05,
                  controller: _tabControllers,
                   unselectedLabelColor: Color(0xffA7A7A7),
                   labelColor: Colors.black,
                   labelStyle: TextStyle(fontWeight: FontWeight.w500,
                       fontFamily: 'Urbanist',fontSize: scrWidth*0.0385
                   ),

                    // indicatorPadding: EdgeInsets.only(bottom: scrHeight*0.00,left: scrWidth*0.00,right: scrWidth*0.00),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.5),
                      color: Color.fromRGBO(169, 255, 188, 0.6)),
                    indicatorSize: TabBarIndicatorSize.label,
                   padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                   labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
                  //  indicatorWeight: 1,

                  tabs: [

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _tabControllers.index=0;
                        });
                      },
                      child: Tab(
                        child: Container(
                          height: scrHeight*0.04,
                          width: scrWidth*0.343,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                          child: Row(
                            children: [
                              SizedBox(width: scrWidth*0.065,),
                              Text("Your Chits",),
                              SizedBox(width: scrWidth*0.03,),
                              Padding(
                                padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                                child: CircleAvatar(
                                  radius: 11,
                                  child: Text("3",style: tababrnumberFont),
                                  backgroundColor:(_tabControllers.index==0)? Color.fromRGBO(0, 128, 54, 0.47):Color(0xffD4D4D4),

                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          _tabControllers.index=1;


                        });
                      },
                      child: Tab(
                        child: Container(
                          height: scrHeight*0.04,
                          width: scrWidth*0.343,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06),width: scrWidth*0.003)),
                          child: Row(
                            children: [
                              SizedBox(width: scrWidth*0.027,),
                              Text("Vacant Chits"),
                              SizedBox(width: scrWidth*0.02,),
                              Padding(
                                padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                                child: CircleAvatar(

                                  radius: 11,
                                  child: Text("3",style:  tababrnumberFont),
                                  backgroundColor:(_tabControllers.index==1)? Color.fromRGBO(0, 128, 54, 0.47):Color(0xffD4D4D4),

                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                   GestureDetector(
                     onTap: (){
                       setState(() {
                       _tabControllers.index=2;
                       });
                     },
                     child: Tab(
                        child: Container(
                          height: scrHeight*0.04,
                          width: scrWidth*0.343,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.5),
                              border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                          child: Row(
                            children: [
                              SizedBox(width: scrWidth*0.025,),
                              Text("Hosted Chits"),
                              SizedBox(width: scrWidth*0.024,),
                              Padding(
                                padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                                child: CircleAvatar(

                                  radius: 11,
                                  child: Text("4",style: tababrnumberFont
                                  ),
                                  backgroundColor:(_tabControllers.index==2)? Color.fromRGBO(0, 128, 54, 0.47):Color(0xffD4D4D4),

                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                   ),
                  ]
              ),
            ),
          ),

          Expanded(
              child: TabBarView(
                controller: _tabControllers,
            children: [
              Container(
                color: Colors.white,

                child: Column(
                  children: [
                    SizedBox(
                      height: scrHeight *0.025,
                    ),
                    ListView.builder(
                        padding:  EdgeInsets.only(
                          left:scrHeight*0.02,
                          right:scrHeight*0.02,
                          bottom:scrHeight*0.02,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: 1, // the length
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>YourChitPage()));
                                },
                                child: Container(
                                  height: scrHeight * 0.17,
                                   width: scrWidth*0.95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: const Offset(
                                          2.0,
                                          2.0,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                    ],
                                  ),

                                  // height: 147,
                                  // width: 339,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: scrWidth*0.025,
                                                right:scrWidth*0.025,
                                                // bottom: scrWidth*0.025,
                                                top: scrWidth*0.03
                                            ),
                                            child: Container(
                                              width:scrWidth*0.15,
                                              height: scrHeight*0.07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(14),
                                                color: Colors.grey.withOpacity(0.1),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: scrHeight * 0.015,
                                              ),
                                               Text(
                                                "Name",
                                                style:chitcardone10,
                                              ),

                                               Text(
                                                "First Logic Chit",
                                                style: chitcard15
                                              ),


                                              Padding(
                                                padding: EdgeInsets.only(left: scrWidth*0.55),
                                                child: Text(
                                                  "Value",
                                                  style: chitcardone10,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(right: scrWidth*0.01),
                                                        child:SvgPicture.asset("assets/icons/timericon.svg",),

                                                      ),

                                                       Text(
                                                        "10 Months",
                                                        style: tenmonthsfont
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:scrHeight*0.135,
                                                  ),
                                                   Text(
                                                    "₹50.000",
                                                    style: valuefontchit
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: scrWidth*0.28,
                                            height: scrHeight*0.03,
                                            // height: 24,
                                            // width: 102,

                                            decoration: BoxDecoration(
                                                color: Color(0xffECECEC),
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.035,),
                                                  child: SvgPicture.asset("assets/icons/people.svg",),
                                                ),
                                                 Text("10/10 Users",style: tenbytenfont)

                                              ],
                                            ),
                                          ),
                                          SizedBox(width: scrWidth*0.1,),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [

                                               Text(
                                                "Subscription",
                                                style: chitcardone10,
                                              ),
                                              SizedBox(height: scrHeight*0.001,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "₹2.000",
                                                    style:valuefontchit
                                                  ),
                                                  Text(
                                                    "/month",
                                                    style: chitcardtwomonth10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                ),

              ),
              Container(
                color: Colors.white,

                child:  Column(
                    children: [
                      SizedBox(
                        height: scrHeight *0.015,
                      ),
                      ListView.builder(
                          padding:  EdgeInsets.only(
                            left:scrHeight*0.02,

                            right:scrHeight*0.02,
                            bottom:scrHeight*0.02,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: 1, // the length
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:  EdgeInsets.only(top: scrHeight*0.01),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context)=>VacantChitJoinPage()));
                                },
                                child: Container(
                                  height: scrHeight * 0.17,
                                  width: scrWidth*0.95,
                                  // height: 147,
                                  // width: 339,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        offset: const Offset(
                                          2.0,
                                          2.0,
                                        ),
                                        blurRadius: 20.0,
                                        spreadRadius: 1.0,
                                      ), //BoxShadow
                                    ],
                                  ),

                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: scrWidth*0.025,
                                                right:scrWidth*0.025,
                                                // bottom: scrWidth*0.025,
                                                top: scrWidth*0.03
                                            ),
                                            child: Container(
                                              width:scrWidth*0.15,
                                              height: scrHeight*0.07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(14),
                                                color: Colors.grey.withOpacity(0.1),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: scrHeight * 0.015,
                                              ),
                                              Text(
                                                "Name",
                                                style:chitcardone10,
                                              ),

                                              Text(
                                                  "First Logic Chit",
                                                  style: chitcard15
                                              ),


                                              Padding(
                                                padding: EdgeInsets.only(left: scrWidth*0.55),
                                                child: Text(
                                                  "Value",
                                                  style: chitcardone10,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(right: scrWidth*0.01),
                                                        child:SvgPicture.asset("assets/icons/timericon.svg",),

                                                      ),

                                                      Text(
                                                          "10 Months",
                                                          style: tenmonthsfont
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:scrHeight*0.135,
                                                  ),
                                                  Text(
                                                      "₹50.000",
                                                      style: valuefontchit
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        indent: 30,
                                        endIndent: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: scrWidth*0.28,
                                            height: scrHeight*0.03,
                                            // height: 24,
                                            // width: 102,

                                            decoration: BoxDecoration(
                                                color: Color(0xffECECEC),
                                                borderRadius: BorderRadius.circular(16)
                                            ),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.035,),
                                                  child: SvgPicture.asset("assets/icons/people.svg",),
                                                ),
                                                Text("10/10 Users",style: tenbytenfont)

                                              ],
                                            ),
                                          ),
                                          SizedBox(width: scrWidth*0.1,),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [

                                              Text(
                                                "Subscription",
                                                style: chitcardone10,
                                              ),
                                              SizedBox(height: scrHeight*0.001,),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      "₹2.000",
                                                      style:valuefontchit
                                                  ),
                                                  Text(
                                                    "/month",
                                                    style: chitcardtwomonth10,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),),
              Container(
                color: Colors.white,
                  child: Column(
                children: [
                  SizedBox(
                    height: scrHeight *0.01,
                  ),
                  ListView.builder(
                      padding:  EdgeInsets.only(
                          left:scrHeight*0.02,
                          right:scrHeight*0.02,
                          bottom:scrHeight*0.02,
                      ),

                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 3, // the length
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:  EdgeInsets.only(top: scrHeight*0.015),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                (index==0)?
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PendingApprovelPage())):(index==1)?
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HostedDrawnPage())):
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HostedDraftPage()));
                              });
                            },
                            child: Container(
                              height: scrHeight * 0.17,
                              width: scrWidth*0.95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    offset: const Offset(
                                      2.0,
                                      2.0,
                                    ),
                                    blurRadius: 20.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                ],
                              ),

                              // height: 147,
                              // width: 339,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: scrWidth*0.025,
                                            right:scrWidth*0.025,
                                            // bottom: scrWidth*0.025,
                                            top: scrWidth*0.03
                                        ),
                                        child: Container(
                                          width:scrWidth*0.15,
                                          height: scrHeight*0.07,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(14),
                                            color: Colors.grey.withOpacity(0.1),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: scrHeight * 0.015,
                                          ),
                                          Row(
                                            children: [
                                               Text(
                                                "Name",
                                                style: chitcardone10
                                              ),
                                              SizedBox(width: scrWidth*0.467,),
                                              CustomPaint(
                                                size: Size(
                                                    scrWidth*0.4,
                                                    (scrWidth *0.04)
                                                        .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                                                painter: (index==2)?RCustomPainter():RPSCustomPainter(),
                                                child: Container(
                                                  width: scrWidth*0.17,
                                                  height: scrHeight*0.023,
                                                  padding: EdgeInsets.only(left: scrWidth*0.01),
                                                  child: Center(
                                                    child: (index==2)?Text("Draft",style: TextStyle(color: Colors.black,
                                                          fontSize: scrWidth*0.027,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
                                                      ),):Text("Published",style: TextStyle(color: Colors.white,
                                                        fontSize: scrWidth*0.027,fontFamily: 'Urbanist',fontWeight: FontWeight.w600
                                                      ),),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                           Text(
                                            "First Logic Chit",
                                            style: chitcard15
                                          ),


                                           Padding(
                                             padding: EdgeInsets.only(left: scrWidth*0.55),
                                            child: Text(
                                              "Value",
                                              style: chitcardone10
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: scrWidth*0.01),
                                                    child:SvgPicture.asset("assets/icons/timericon.svg",),

                                                  ),

                                                  Text(
                                                    "10 Months",
                                                    style:tenmonthsfont
                                                  ),
                                                ],
                                              ),
                                               SizedBox(
                                                 width:scrHeight*0.135,
                                              ),
                                               Text(
                                                "₹50.000",
                                                style: valuefontchit
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    indent: 30,
                                  endIndent: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: scrWidth*0.28,
                                        height: scrHeight*0.03,
                                        decoration: BoxDecoration(
                                          color: Color(0xffECECEC),
                                          borderRadius: BorderRadius.circular(16)
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.035,),
                                              child: SvgPicture.asset("assets/icons/people.svg",),
                                            ),
                                            Text("10/10 Users",style: tenbytenfont)

                                          ],
                                        ),
                                      ),
                                      SizedBox(width: scrWidth*0.1,),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [

                                           Text(
                                            "Subscription",
                                            style:chitcardone10
                                          ),
                                          SizedBox(height: scrHeight*0.001,),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "₹2.000",
                                                style: valuefontchit
                                              ),
                                              Text(
                                                "/month",
                                                style:chitcardtwomonth10
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              )
              ),

            ],

          ))
        ],
      ),


    );
  }
}
