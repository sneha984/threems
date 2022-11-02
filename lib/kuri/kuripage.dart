import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/kuri/addedkuriprivate.dart';
import 'package:threems/kuri/addedkuripublic.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/kuri/hostedkuripage.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class Kuripage extends StatefulWidget {
  const Kuripage({Key? key}) : super(key: key);

  @override
  State<Kuripage> createState() => _KuripageState();
}

class _KuripageState extends State<Kuripage>with TickerProviderStateMixin {
  late  TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

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
            padding: EdgeInsets.only(top: scrHeight*0.03,
                left: scrWidth*0.05,bottom: scrHeight*0.01,right: scrWidth*0.05),
            child:SvgPicture.asset("assets/icons/arrow.svg",),
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top: scrHeight*0.02),
          child: Text(
            "Kuri",
            style: TextStyle(
                fontSize: scrWidth*0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: scrWidth*0.04,top: scrHeight*0.045,bottom: scrHeight*0.025),
            child: InkWell(
              onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateKuriPage()));
              },
              child: Container(
                height: scrHeight*0.07,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrWidth*0.04),
                  color: primarycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.white,
                    ),
                    Text(
                      "Create Kuri",
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
      body:Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(
                top: scrHeight*0.03,
                 bottom: scrHeight*0.014
            ),
            child: Container(
              height: scrHeight*0.039,
              child: TabBar(
                  isScrollable: true,
                  indicatorWeight: 0.05,
                  controller: _tabController,
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
                  padding: EdgeInsets.only(left: scrWidth*0.02,right: scrWidth*0.6),
                  indicatorPadding: EdgeInsets.zero,
                   labelPadding: EdgeInsets.only(left: scrWidth*0.022,right: scrWidth*0.019),
                  //  indicatorWeight: 1,

                  tabs: [
                    Tab(
                      child: Container(
                        height: scrHeight*0.04,
                        width: scrWidth*0.343,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06), width: scrWidth*0.003)),
                        child: Row(
                          children: [
                            SizedBox(width: scrWidth*0.05,),
                            Text("Added Kuri",),
                            SizedBox(width: scrWidth*0.03,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                              child: CircleAvatar(
                                radius: 11,
                                child: Text("3",style: tababrnumberFont),
                                backgroundColor: Color.fromRGBO(0, 128, 54, 0.54),

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        height: scrHeight*0.04,
                        width: scrWidth*0.343,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17.5),
                            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.06),width: scrWidth*0.003)),
                        child: Row(
                          children: [
                            SizedBox(width: scrWidth*0.05,),
                            Text("Hosted Kuri"),
                            SizedBox(width: scrWidth*0.02,),
                            Padding(
                              padding:  EdgeInsets.only(bottom: scrHeight*0.0035,top: scrHeight*0.0035),
                              child: CircleAvatar(
                                radius: 11,
                                child: Text("3",style:  tababrnumberFont),
                                backgroundColor: Color.fromRGBO(0, 128, 54, 0.47),

                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListView.builder(
                            padding:  EdgeInsets.only(
                              top: scrHeight*0.01,
                              left:scrHeight*0.02,
                              right:scrHeight*0.02,
                              bottom:scrHeight*0.02,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: EdgeInsets.only(top: scrHeight*0.01),
                                child: GestureDetector(
                                  onTap: (){
                                    (index==0)?
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AddedKuriPublic())):
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>AddedKuriPrivate()));


                                  },
                                  child: Container(
                                    height: scrHeight * 0.25,
                                    width: scrWidth*0.95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
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
                                        SizedBox(height: scrHeight*0.01,),
                                        Row(
                                          children: [
                                            SizedBox(width: scrWidth*0.04,),
                                            Container(
                                              height: scrHeight*0.065,
                                              width: scrWidth*0.15,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(11),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0wRDAivyQVAx54eks-rILb0NY6HcuSKkPEw&usqp=CAU"),fit: BoxFit.fill)
                                              ),
                                            ),
                                            SizedBox(width: scrWidth*0.024,),
                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: scrHeight*0.015,),
                                                Text("Name",style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff989898),
                                                    fontSize: scrWidth*0.03,
                                                    fontFamily: 'Urbanist'),),
                                                SizedBox(height: scrHeight*0.004,),
                                                Text("Rasheed's Daughter Wedding",style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                    fontSize: scrWidth*0.04,
                                                    fontFamily: 'Urbanist')),
                                                SizedBox(height: scrHeight*0.006,),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Center(child: Text(
                                                          "20 Days Left",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.white,
                                                              fontSize: scrWidth*0.025,
                                                              fontFamily: 'Urbanist'))),
                                                      height: scrHeight*0.023,
                                                      width: scrWidth*0.22,
                                                      decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.circular(scrWidth*0.04)
                                                      ),
                                                    ),
                                                    SizedBox(width: scrWidth*0.13,),

                                                    Row(
                                                      children: [
                                                        SvgPicture.asset("assets/icons/timeiconsvg.svg"),
                                                        SizedBox(width: scrWidth*0.02,),
                                                        Text("22 March 2022",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xffA4A4A4),
                                                              fontSize: scrWidth*0.035,
                                                              fontFamily: 'Urbanist'),)],)],)],)],),
                                        SizedBox(height: scrHeight*0.025,),
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: scrWidth*0.02),
                                          child: LinearPercentIndicator(
                                            //leaner progress bar
                                            animation: true,
                                            animationDuration: 1000,
                                            lineHeight: scrHeight*0.025,
                                            width: scrWidth*0.86,
                                            percent: 0.3,
                                            alignment: MainAxisAlignment.start,
                                            barRadius: Radius.circular(scrWidth*0.2),
                                            progressColor: primarycolor,
                                            backgroundColor: Color(0xffD9D9D9),
                                          ),
                                        ),
                                        SizedBox(height: scrHeight*0.015,),

                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceAround,

                                          children: [
                                            Column(
                                                mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Text("Collected",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.w600,
                                                            color: Color(0xff989898),
                                                            fontSize: scrWidth*0.026,
                                                            fontFamily: 'Urbanist'),
                                                ),
                                                    SizedBox(height: scrHeight*0.002,),
                                                    Text("₹25,000",style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: primarycolor,
                                                        fontSize: scrWidth*0.026,
                                                        fontFamily: 'Urbanist'),),


                                              ],
                                            ),
                                            SizedBox(width: scrWidth*0.35,),

                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.end,
                                              children: [
                                                    Text("Value",style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xff989898),
                                                        fontSize: scrWidth*0.026,
                                                        fontFamily: 'Urbanist'),),
                                                SizedBox(height: scrHeight*0.002,),

                                                Text("₹5,00,000",style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color:primarycolor,
                                                    fontSize: scrWidth*0.026,
                                                    fontFamily: 'Urbanist'),),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: scrHeight*0.012,),

                                        Container(
                                          height: scrHeight*0.036,
                                          width: scrWidth*0.83,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(9),
                                            color: primarycolor,

                                          ),
                                          child:Center(child: Text("Pay Now",style: TextStyle(fontWeight: FontWeight.w700,color: Color(0xffFFFFFF),fontSize: 14,fontFamily: 'Urbanist'),)),


                                        )

                                      ],
                                    ),

                                  ),
                                ),
                              );

                        })
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListView.builder(
                            padding:  EdgeInsets.only(
                              top: scrHeight*0.01,
                              left:scrHeight*0.02,
                              right:scrHeight*0.02,
                              bottom:scrHeight*0.02,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 1,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: EdgeInsets.only(top: scrHeight*0.02),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>HostedKuriPage()));
                                  },
                                  child: Container(
                                    height: scrHeight * 0.21,
                                    width: scrWidth*0.95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
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
                                        SizedBox(height: scrHeight*0.01,),
                                        Row(
                                          children: [
                                            SizedBox(width: scrWidth*0.04,),
                                            Container(
                                              height: scrHeight*0.065,
                                              width: scrWidth*0.15,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(11),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0wRDAivyQVAx54eks-rILb0NY6HcuSKkPEw&usqp=CAU"),fit: BoxFit.fill)
                                              ),
                                            ),
                                            SizedBox(width: scrWidth*0.024,),
                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: scrHeight*0.015,),
                                                Text("Name",style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff989898),
                                                    fontSize: scrWidth*0.03,
                                                    fontFamily: 'Urbanist'),),
                                                SizedBox(height: scrHeight*0.004,),
                                                Text("Rasheed's Daughter Wedding",style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff000000),
                                                    fontSize: scrWidth*0.04,
                                                    fontFamily: 'Urbanist')),
                                                SizedBox(height: scrHeight*0.006,),
                                                Row(
                                                  children: [
                                                    Container(
                                                      child: Center(child: Text(
                                                          "20 Days Left",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: Colors.white,
                                                              fontSize: scrWidth*0.025,
                                                              fontFamily: 'Urbanist'))),
                                                      height: scrHeight*0.023,
                                                      width: scrWidth*0.22,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius: BorderRadius.circular(scrWidth*0.04)
                                                      ),
                                                    ),
                                                    SizedBox(width: scrWidth*0.13,),

                                                    Row(
                                                      children: [
                                                        SvgPicture.asset("assets/icons/timeiconsvg.svg"),
                                                        SizedBox(width: scrWidth*0.02,),
                                                        Text("22 March 2022",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w600,
                                                              color: Color(0xffA4A4A4),
                                                              fontSize: scrWidth*0.035,
                                                              fontFamily: 'Urbanist'),)],)],)],)],),
                                        SizedBox(height: scrHeight*0.025,),
                                        Padding(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: scrWidth*0.02),
                                          child: LinearPercentIndicator(
                                            //leaner progress bar
                                            animation: true,
                                            animationDuration: 1000,
                                            lineHeight: scrHeight*0.025,
                                            width: scrWidth*0.86,
                                            percent: 0.3,
                                            alignment: MainAxisAlignment.start,
                                            barRadius: Radius.circular(scrWidth*0.2),
                                            progressColor: primarycolor,
                                            backgroundColor: Color(0xffD9D9D9),
                                          ),
                                        ),
                                        SizedBox(height: scrHeight*0.015,),

                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceAround,

                                          children: [
                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: [
                                                Text("Collected",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      color: Color(0xff989898),
                                                      fontSize: scrWidth*0.026,
                                                      fontFamily: 'Urbanist'),
                                                ),
                                                SizedBox(height: scrHeight*0.002,),
                                                Text("₹25,000",style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: primarycolor,
                                                    fontSize: scrWidth*0.026,
                                                    fontFamily: 'Urbanist'),),


                                              ],
                                            ),
                                            SizedBox(width: scrWidth*0.35,),

                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.start,
                                              crossAxisAlignment:CrossAxisAlignment.end,
                                              children: [
                                                Text("Value",style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xff989898),
                                                    fontSize: scrWidth*0.026,
                                                    fontFamily: 'Urbanist'),),
                                                SizedBox(height: scrHeight*0.002,),

                                                Text("₹5,00,000",style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color:primarycolor,
                                                    fontSize: scrWidth*0.026,
                                                    fontFamily: 'Urbanist'),),
                                              ],
                                            )
                                          ],
                                        ),



                                      ],
                                    ),

                                  ),
                                ),
                              );

                            })
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),


    );
  }
}
