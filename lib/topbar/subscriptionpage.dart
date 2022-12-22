import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:threems/utils/themes.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            IconButton(onPressed: (){
              Navigator.pop(context);

            }, icon:Icon(Icons.arrow_back_ios_outlined,size: 20,)),
            SizedBox(height: 20,),

            Align(
            alignment: Alignment.center,
            child: Text(
              "Choose Your Plan",
              style: TextStyle(
                  fontSize: scrWidth*0.046,
                  color: Colors.black,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: 20,),
          SingleChildScrollView(
            scrollDirection:Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Container(
                  height: scrHeight*0.56,
                  width: scrWidth*0.8,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          primarycolor,
                          Color(0xff28B446),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      // border: Border.all(width: 1,color: Colors.green)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium",
                          style: TextStyle(
                              fontSize: scrWidth*0.048,
                              color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Connect",
                          style: TextStyle(
                              fontSize: scrWidth*0.08,
                              color: Colors.white,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Container(
                            height: 30,
                              width: 35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/icons/tickimage.png"))
                            ),
                          ),
        
                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  color: Colors.white,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/tickimage.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  color: Colors.white,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/tickimage.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  color: Colors.white,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/tickimage.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  color: Colors.white,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 35,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/tickimage.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  color: Colors.white,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                    SizedBox(height: 10,),
                    Container(
                            height: scrHeight*0.07,
                            width: scrWidth*0.69,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1,color: Colors.white70)
                            ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Text(
                            "MONTHLY PLAN",
                            style: TextStyle(
                                fontSize: scrWidth*0.038,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "₹15.00/Month",
                            style: TextStyle(
                                fontSize: scrWidth*0.039,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w800),
                          ),

                        ],
                      )
                    ),
                        SizedBox(height: 27,),
                        Center(
                          child: Text(
                            "3 days free trail for new subscribers only",
                            style: TextStyle(
                                fontSize: scrWidth*0.03,
                                color: Colors.white,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        SizedBox(height: 7,),

                        Container(
                            height: scrHeight*0.07,
                            width: scrWidth*0.68,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),
                                Text(
                                  "YEARLY PLAN",
                                  style: TextStyle(
                                      fontSize: scrWidth*0.038,
                                      color: Colors.white,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "₹529.00/Year",
                                  style: TextStyle(
                                      fontSize: scrWidth*0.039,
                                      color: Colors.white,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w800),
                                ),

                              ],
                            )
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Container(
                  height: scrHeight*0.56,
                  width: scrWidth*0.8,
                  decoration: BoxDecoration(
                    // color: Colors.green,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffbd9b16),
                        Color(0xffd4af38),
                        Color(0xffbd9b16),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(width: 1,color: Colors.green)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Premium",
                          style: TextStyle(
                              fontSize: scrWidth*0.048,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Gold",
                          style: TextStyle(
                              fontSize: scrWidth*0.08,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 16,),
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 34,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/blacktick.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 34,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/blacktick.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 34,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/blacktick.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 36,
                              width: 34,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/icons/blacktick.png"))
                              ),
                            ),

                            Text(
                              "No Ads ",
                              style: TextStyle(
                                  fontSize: scrWidth*0.038,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w400),
                            ),


                          ],
                        ),
                        SizedBox(height: 85,),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "You can manage your subscription or cancel anytime in your Google account settings",
                            style: TextStyle(
                                fontSize: scrWidth*0.03,
                                color: Colors.black45,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w200,),textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8,),

                        Container(
                            height: scrHeight*0.07,
                            width: scrWidth*0.68,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10,),
                                Text(
                                  "YEARLY PLAN",
                                  style: TextStyle(
                                      fontSize: scrWidth*0.038,
                                      color: Colors.white38,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "₹529.00/Year",
                                  style: TextStyle(
                                      fontSize: scrWidth*0.039,
                                      color: Colors.white38,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w800),
                                ),

                              ],
                            )
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20,),




              ],
            ),
          )



          ],
        )
        // Column(
        //   children: [
        //     SizedBox(height: 50,),
        //     Row(
        //       children: [
        //         SizedBox(width: 10,),
        //         InkWell(
        //           onTap: (){
        //             Navigator.pop(context);
        //           },
        //           child:Container(
        //               height: 20,
        //               width: 20,
        //               child: SvgPicture.asset("assets/icons/arrowmark.svg",)),
        //         ),
        //         SizedBox(width: scrWidth*0.04,),
        //         Text(
        //           "Subscription",
        //           style: TextStyle(
        //               fontSize: scrWidth*0.046,
        //               color: Colors.black,
        //               fontFamily: 'Urbanist',
        //               fontWeight: FontWeight.w600),
        //         ),
        //       ],
        //     ),
        //     SizedBox(height: 30,),
        //
        //     Container(
        //       height: scrHeight*0.56,
        //       width: scrWidth*0.9,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(12),
        //         border: Border.all(width: 1,color: Colors.green)
        //       ),
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: 70,
        //                   width: 70,
        //                   decoration: BoxDecoration(
        //                       color: Colors.green,
        //
        //                       borderRadius: BorderRadius.circular(20)
        //                   ),
        //
        //                 ),
        //               ),
        //               SizedBox(width: 30,),
        //               Column(
        //                 children: [
        //                   Text("Basic",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w700,
        //                       fontSize: 20,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                   SizedBox(height: 10,),
        //                   Text("₹100",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 20,
        //                       fontFamily: 'Urbanist'
        //                   ),)
        //                 ],
        //               ),
        //
        //             ],
        //           ),
        //           Column(
        //             children: [
        //               SizedBox(height: 10,),
        //             Row(
        //               children: [
        //                 SizedBox(width: 20,),
        //                 Container(
        //                   height: 40,
        //                     width: 40,
        //                   decoration: BoxDecoration(
        //                     image: DecorationImage(
        //                         image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                   ),
        //                 ),
        //                 SizedBox(width: 20,),
        //
        //                 Text("Choose Plan ",style: TextStyle(
        //                     color: Colors.black,
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 13,
        //                     fontFamily: 'Urbanist'
        //                 ),),
        //               ],
        //             )  ,
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               )
        //             ],
        //           ),
        //
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //               height: 70,
        //               width: 300,
        //               decoration: BoxDecoration(
        //                   color: Colors.green,
        //
        //                   borderRadius: BorderRadius.circular(20)
        //               ),
        //               child:  Center(
        //                 child: Text("Choose Plan",style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 20,
        //                     fontFamily: 'Urbanist'
        //                 ),),
        //               ),
        //
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(height: 30,),
        //
        //     Container(
        //       height: scrHeight*0.56,
        //       width: scrWidth*0.9,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           border: Border.all(width: 1,color: Colors.green)
        //       ),
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: 70,
        //                   width: 70,
        //                   decoration: BoxDecoration(
        //                       color: Colors.green,
        //
        //                       borderRadius: BorderRadius.circular(20)
        //                   ),
        //
        //                 ),
        //               ),
        //               SizedBox(width: 30,),
        //               Column(
        //                 children: [
        //                   Text("Basic",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w700,
        //                       fontSize: 20,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                   SizedBox(height: 10,),
        //                   Text("₹100",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 20,
        //                       fontFamily: 'Urbanist'
        //                   ),)
        //                 ],
        //               ),
        //
        //             ],
        //           ),
        //           Column(
        //             children: [
        //               SizedBox(height: 10,),
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               )  ,
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               )
        //             ],
        //           ),
        //
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //               height: 70,
        //               width: 300,
        //               decoration: BoxDecoration(
        //                   color: Colors.green,
        //
        //                   borderRadius: BorderRadius.circular(20)
        //               ),
        //               child:  Center(
        //                 child: Text("Buy Plan ",style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 20,
        //                     fontFamily: 'Urbanist'
        //                 ),),
        //               ),
        //
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(height: 30,),
        //     Container(
        //       height: scrHeight*0.56,
        //       width: scrWidth*0.9,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(12),
        //           border: Border.all(width: 1,color: Colors.green)
        //       ),
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                   height: 70,
        //                   width: 70,
        //                   decoration: BoxDecoration(
        //                       color: Colors.green,
        //
        //                       borderRadius: BorderRadius.circular(20)
        //                   ),
        //
        //                 ),
        //               ),
        //               SizedBox(width: 30,),
        //               Column(
        //                 children: [
        //                   Text("Basic",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w700,
        //                       fontSize: 20,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                   SizedBox(height: 10,),
        //                   Text("₹100",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 20,
        //                       fontFamily: 'Urbanist'
        //                   ),)
        //                 ],
        //               ),
        //
        //             ],
        //           ),
        //           Column(
        //             children: [
        //               SizedBox(height: 10,),
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               )  ,
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               ),
        //               SizedBox(height: 10,),
        //
        //               Row(
        //                 children: [
        //                   SizedBox(width: 20,),
        //                   Container(
        //                     height: 40,
        //                     width: 40,
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_3W284pix116r4JH0b8TWrPXxdTsHD4eoKg&usqp=CAU"))
        //                     ),
        //                   ),
        //                   SizedBox(width: 20,),
        //
        //                   Text("Choose Plan ",style: TextStyle(
        //                       color: Colors.black,
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 13,
        //                       fontFamily: 'Urbanist'
        //                   ),),
        //                 ],
        //               )
        //             ],
        //           ),
        //
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Container(
        //               height: 70,
        //               width: 300,
        //               decoration: BoxDecoration(
        //                   color: Colors.green,
        //
        //                   borderRadius: BorderRadius.circular(20)
        //               ),
        //               child:  Center(
        //                 child: Text("Buy Plan ",style: TextStyle(
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.w600,
        //                     fontSize: 20,
        //                     fontFamily: 'Urbanist'
        //                 ),),
        //               ),
        //
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     SizedBox(height: 20,),
        //
        //   ],
        // ),
      ) ,

    );
  }
}
