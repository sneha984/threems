import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:threems/ByeandSell/storedetailsfill.dart';
import 'package:threems/ByeandSell/storedetailsfill2.dart';
import 'dart:ui' as ui;
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';

class BuyAndSell extends StatefulWidget {
  const BuyAndSell({Key? key}) : super(key: key);

  @override
  State<BuyAndSell> createState() => _BuyAndSellState();
}

class _BuyAndSellState extends State<BuyAndSell>with TickerProviderStateMixin {
  late TabController _tabController;
  bool isShopCreated=true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        leadingWidth: 40,
        centerTitle: false,
        elevation:0.1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){},
          child:  Padding(
            padding: EdgeInsets.only(top: scrHeight*0.03,
                left: scrWidth*0.045,bottom: scrHeight*0.01,right: scrWidth*0.01),
            child:SvgPicture.asset("assets/icons/locationicon.svg",),
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top: scrHeight*0.02),
          child: Text(
            "Select Your Location",
            style: TextStyle(
                fontSize: scrWidth*0.046,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: scrHeight*0.015,),
          Padding(
            padding:  EdgeInsets.only(left: scrWidth*0.05,right: scrWidth*0.05),
            child: Container(
              height: scrHeight*0.05,
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
              Text("SHOP NOW",style: TextStyle(
                fontFamily: 'Urbanist',fontSize: 15,fontWeight: FontWeight.w700
              ),),
              Text("YOUR STORE",style: TextStyle(
                  fontFamily: 'Urbanist',fontSize: 15,fontWeight: FontWeight.w700
              ),),
            ],
        ),
      ),
          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
            children: [
              Column(
                children: [
                  SizedBox(height: scrHeight*0.02,),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: scrWidth*0.03,),
                        SvgPicture.asset("assets/icons/staricon.svg"),
                        SizedBox(width: scrWidth*0.03,),
                        Text("Sponsered Product",style: TextStyle(
                            fontFamily: 'Urbanist',fontSize: scrWidth*0.04,fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
              isShopCreated?Column(
                children: [
                  SizedBox(height: scrHeight*0.03,),
                      DottedBorder(
                      borderType: BorderType.Circle,
                        radius: Radius.circular(12),
                        padding: EdgeInsets.all(23),
                        dashPattern: [3,2],
                        child: SvgPicture.asset("assets/icons/shop.svg")
                      ),
                  SizedBox(height: scrHeight*0.01,),
                  Text("Build your own online store \nhassle free!",textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.03,fontWeight: FontWeight.w600,
                      color: Color(0xff615C5C)),),
                  SizedBox(height: scrHeight*0.02,),
                  DottedBorder(
                      borderType: BorderType.Circle,
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(23),
                      dashPattern: [3,2],
                      child: SvgPicture.asset("assets/icons/lens.svg")
                  ),
                  SizedBox(height: scrHeight*0.01,),
                  Text("Manage orders and track your \nbusiness on the go!",textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.03,fontWeight: FontWeight.w600,
                        color: Color(0xff615C5C)),),
                  SizedBox(height: scrHeight*0.02,),
                  DottedBorder(
                      borderType: BorderType.Circle,
                      radius: Radius.circular(12),
                      padding: EdgeInsets.all(23),
                      dashPattern: [3,2],
                      child: SvgPicture.asset("assets/icons/featuresicon.svg")
                  ),
                  SizedBox(height: scrHeight*0.01,),
                  Text("Get all the features to grow \nyour online business",textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Urbanist',fontSize: 12,fontWeight: FontWeight.w600,
                        color: Color(0xff615C5C)),),
                  SizedBox(height: scrHeight*0.03,),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetails()));
                    },
                    child: Container(
                      height: scrHeight*0.05,
                      width: scrWidth*0.6,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(21.5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,size: scrWidth*0.045,color: Colors.white,),
                          Text("Create Store",textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.045,fontWeight: FontWeight.w700,
                                color: Colors.white),),
                        ],
                      ),
                    ),
                  )
                ],
              )
                  :Column(
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
                        Text("50%",textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.07,fontWeight: FontWeight.w600,
                              color: Colors.black),),
                        SizedBox(height: scrHeight*0.009,),

                        LinearPercentIndicator(
                          //leaner progress bar
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: scrHeight*0.021,
                          width: scrWidth*0.77,
                          percent: 0.5,
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
                  GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreDetailsFill2()));
                    },
                    child: Container(
                      height: scrHeight*0.055,
                      width: scrWidth*0.55,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(21.5)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,size: scrWidth*0.045,color: Colors.white,),
                          Text("Add Product",textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Urbanist',fontSize: scrWidth*0.04,fontWeight: FontWeight.w700,
                                color: Colors.white),),
                        ],
                      ),
                    ),
                  )

                ],
              )
            ],
          ))

        ],
      ),
    );
  }
}
