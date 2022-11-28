import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/utils/themes.dart';

import '../../screens/splash_screen.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with TickerProviderStateMixin{
  late  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }
  void _handleTabSelection() {
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: primarycolor,
              height: 110,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8,),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: scrHeight * 0.027,
                            left: scrWidth*0.03
                          ),
                          child: Container(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              "assets/icons/whitearrow.svg",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: scrHeight * 0.027,
                          left: scrWidth * 0.05,),
                        child: Text("Orders",style:TextStyle(
                            fontSize: scrWidth * 0.046,
                            color: Colors.white,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                  SizedBox(height: 18,),
                  Container(
                    height: 32,
                    color: primarycolor,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 8),
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                         labelPadding: EdgeInsets.only(left: scrWidth*0.023,right: scrWidth*0.019),
                        unselectedLabelColor: Colors.white,
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600,
                            fontFamily: 'Urbanist',fontSize:15),
                        labelColor: Color(0xff0D0D0D),
                        labelStyle: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Urbanist',fontSize: 15),
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        tabs: [
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Pending",),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Accepted",),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Delivered",),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 32,
                              width: 100,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white, width: 1)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Cancelled",),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: TabBarView(
              controller: _tabController,
              children: [
                Container(),
                Container(),
                Container(),
                Container(),
              ],
            ))
          ]
      ),),
    );
  }
}
