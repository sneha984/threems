
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/model/servicesModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/themes.dart';
import '../splash_screen.dart';

class detailesSinglePage extends StatefulWidget {
  final ServiceDetails services;
  const detailesSinglePage({Key? key, required this.services, }) : super(key: key);

  @override
  State<detailesSinglePage> createState() => _detailesSinglePageState();
}

class _detailesSinglePageState extends State<detailesSinglePage> with TickerProviderStateMixin{
   TabController? _tabController;
  ServiceDetails? services;
  @override
  void initState() {
    services=widget.services;
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(scrWidth * 0.15),
        child: Container(
          /*decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: Offset(0, 4),
                blurRadius: 25),
          ]),*/
          child: AppBar(
            elevation: 0,
            toolbarHeight: 75,
            automaticallyImplyLeading: true,
            backgroundColor: tabBarColor,
            title: Text(
              'Back',
              style: TextStyle(
                  fontSize: scrWidth * 0.046,
                  color: Colors.white,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600),
            ),

          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: scrWidth*0.3,
                color: tabBarColor,

              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top:scrWidth*0.2,left:scrWidth*0.1 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              services!.name.toString(),
                              style: TextStyle(
                                  fontSize: scrWidth * 0.07,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w800),
                            ),
                            SizedBox(height: scrWidth*0.01,),
                            Text(
                              services!.address.toString(),
                              style: TextStyle(
                                  fontSize: scrWidth * 0.04,
                                  color: Colors.grey,
                                  fontFamily: 'Urbanist',
                                  // fontWeight: FontWeight.
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding:  EdgeInsets.only(right:scrWidth*0.07 ),
                          child: InkWell(
                            onTap: (){

                                  Uri call = Uri.parse(
                                  'tel://${services!.phoneNumber!}');

                                  launchUrl(call);
                            },
                            child: Container(
                              height: scrWidth*0.19,
                              width:  scrWidth*0.19,
                              decoration: BoxDecoration(
                                color: tabBarColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SvgPicture.asset('assets/images/call.svg',height: 20,width: 20,),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),


                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: scrWidth * 0.05, right: scrWidth * 0.05,top: scrWidth * 0.09),
                child: Container(
                  height: scrHeight * 0.05,
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
                      Text("Services", style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: scrWidth*0.04,
                          fontWeight: FontWeight.w700
                      ),),
                      Text("About us", style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize:scrWidth*0.04 ,
                          fontWeight: FontWeight.w700
                      ),),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(scrWidth*0.07),
                        child: Container(
                            child: Text(services!.servicesProvided.toString(),
                              style: TextStyle(
                                  fontSize: scrWidth * 0.046,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),)),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(scrWidth*0.07),
                        child: Container(
                            child: Text(services!.aboutService.toString(),
                              style: TextStyle(
                                  fontSize: scrWidth * 0.046,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),)),
                      ),
                      // IncomeFirstPage(),
                      // AddExpensesPage(),

                    ]
                ),

              )
            ],
          ),
          Positioned(
              top: scrHeight*0.01,
              left: scrWidth*0.057,
              right: scrWidth*0.057,

              child: Container(
                height: scrWidth*0.41,
                width: scrWidth*0.001,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color(0xffF3F3F3),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 4,
                      offset: Offset(0, 7),
                      color: Colors.grey.withOpacity(0.15),
                    ),
                  ],
                ),
                child: Container(

                    child: ClipRRect(
                         borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage( imageUrl:services!.image.toString(),fit: BoxFit.cover,))),


              )
          ),

        ],
      ),
    );
  }
}
