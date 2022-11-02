import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class CharitySlider extends StatefulWidget {
  String image;
  String title;
  double valueAmount;
  double collectedAmount;
  double progressPercentage;
  CharitySlider(
      {Key? key,
      required this.title,
      required this.image,
      required this.valueAmount,
      required this.collectedAmount,
      required this.progressPercentage})
      : super(key: key);

  @override
  State<CharitySlider> createState() => _CharitySliderState();
}

class _CharitySliderState extends State<CharitySlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return Container(
          height: scrWidth * 0.28,
          width: scrWidth,
          // width: 326,
          // height: 100,

          decoration: BoxDecoration(
            color: primarycolor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.teal,
                  width: scrWidth * 0.57,
                  height: scrWidth * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: scrWidth * 0.21,
                        height: scrWidth * 0.21,
                        // width: 73,
                        // height: 73,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.image,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: scrWidth * 0.03,
                      ),
                      Column(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize13,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(children: [
                            Text(
                              "Value : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize10,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              width: scrWidth * .19,
                              // color: Colors.black,
                              child: Text(
                                NumberFormat.currency(
                                  symbol: '₹ ',
                                  locale: "HI",
                                  decimalDigits: 0,
                                ).format(widget.valueAmount).toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.green[300],
                                  fontSize: FontSize14,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ]),
                          Text(
                            "Total Collected",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize8,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            width: scrWidth * .25,
                            // color: Colors.black,
                            child: Text(
                              NumberFormat.currency(
                                symbol: '₹ ',
                                locale: "HI",
                                decimalDigits: 0,
                              ).format(widget.collectedAmount).toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize14,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: scrWidth * 0.19,
                  height: scrWidth * 0.2,
                  // color: Colors.cyan,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            // color: Colors.amber,
                            width: scrWidth * 0.04,
                            height: scrWidth * 0.04,
                          ),
                          CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.square,
                            progressColor: primarycolor.withOpacity(.6),
                            backgroundColor: Colors.white,
                            percent: widget.progressPercentage,
                            radius: 15,
                            lineWidth: 3.0,
                          ),
                        ],
                      ),
                      Container(
                        width: scrWidth * 0.21,
                        height: scrWidth * 0.07,
                        // width: 72,
                        // height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            "PAY",
                            style: TextStyle(
                              color: primarycolor,
                              fontFamily: 'Urbanist',
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize16,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
      options: CarouselOptions(
        aspectRatio: 3.0,
        height: scrWidth * 1.5,
        viewportFraction: 0.85,
        enlargeCenterPage: true,
      ),
    );
  }
}
