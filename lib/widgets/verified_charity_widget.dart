import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:threems/model/charitymodel.dart';
import 'package:threems/screens/charity/basic_details.dart';
import 'package:threems/screens/splash_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'package:threems/utils/dummy.dart';
import '../model/usermodel.dart';
import '../screens/home_screen.dart';
import '../utils/themes.dart';

class VerifiedCharityWidget extends StatefulWidget {

  const VerifiedCharityWidget({super.key,});

  @override
  State<VerifiedCharityWidget> createState() => _VerifiedCharityWidgetState();
}

class _VerifiedCharityWidgetState extends State<VerifiedCharityWidget> {
  @override
  void initState() {
          print("hiiiiiiiiiiiiiiiiiiii");
          print(verifiedcharity);
    super.initState();

  }
    var currencyConvert = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹ ',
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 277,
      height: scrWidth * .68,
      width: scrWidth,
      // color: Colors.pink,
      // margin: EdgeInsets.symmetric(
      //     vertical: scrWidth * 0.02, horizontal: scrWidth * 0.0),
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        primary: true,
        scrollDirection: Axis.horizontal,
          itemCount: verifiedcharity?.length??0,
        itemBuilder: (context, index) {
          final vcharity=verifiedcharity[index];
          print(verifiedcharity[0].charityDetailes);
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: scrWidth * 0.045, vertical: scrWidth * 0.04),
            child: Container(
              height: scrWidth * .745,
              // height: 277,
              // width: 188,
              width: scrWidth * .522,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    offset: const Offset(0, 4),
                    spreadRadius: 3,
                    blurRadius: 20,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(scrWidth * 0.07),
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: scrWidth * 0.3,
                    width: scrWidth * .522,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(scrWidth * 0.07),
                            topLeft: Radius.circular(scrWidth * 0.07))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(scrWidth * 0.07),
                        topLeft: Radius.circular(scrWidth * 0.07),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: vcharity?.image??'',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.green,
                    height: scrWidth * 0.28,
                    width: scrWidth * .522,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: scrWidth * 0.035),
                          child: Text(
                            vcharity?.charityDetailes??'',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: FontSize13,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding:
                        //   EdgeInsets.symmetric(horizontal: scrWidth * 0.005),
                        //   child: LinearPercentIndicator(
                        //     //leaner progress bar
                        //     animation: true,
                        //     animationDuration: 1000,
                        //     lineHeight: 3,
                        //     width: 182,
                        //     percent: verifiedCharities[index]['percetage'],
                        //     alignment: MainAxisAlignment.start,
                        //     barRadius: Radius.circular(1.5),
                        //
                        //     progressColor: Color(0xff343434),
                        //     backgroundColor: Color(0xffE9F6FF),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5,bottom: 6),
                          child: LinearPercentIndicator(
                            //leaner progress bar
                            animation: true,
                            animationDuration: 1000,
                            lineHeight: 3,
                            width: 181,
                            percent: vcharity.totalReceived!/vcharity.valueAmount!,
                            alignment: MainAxisAlignment.start,
                            barRadius: Radius.circular(1.5),

                            progressColor: Color(0xff343434),
                            backgroundColor: Color(0xffE9F6FF),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: scrWidth * 0.035),
                            child: Text(
                              currencyConvert.format(
                                vcharity?.valueAmount??0,
                              ).toString(),
                              style: TextStyle(
                                color: primarycolor,
                                fontWeight: FontWeight.w600,
                                fontSize: FontSize14,
                                fontFamily: 'Urbanist',
                              ),
                            ),),],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

