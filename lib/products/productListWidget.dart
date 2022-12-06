import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/splash_screen.dart';
import 'const.dart';

class ProductListWidget extends StatefulWidget {
  final dynamic proLis;
  const ProductListWidget({super.key, required this.proLis});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  bool inStock = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.055),
      child: Container(
        width: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: scrWidth * 0.2,
              width: scrWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(scrWidth * 0.025),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: CachedNetworkImage(imageUrl: widget.proLis['img']),
              ),
            ),
            SizedBox(
              width: scrWidth * 0.03,
            ),
            Container(
              width:20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.proLis['name'],
                            style: GoogleFonts.urbanist(
                                fontSize: scrWidth * 0.039, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.proLis['qty'],
                            style: GoogleFonts.urbanist(
                                fontSize: scrWidth * 0.03,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff818181)),
                          )
                        ],
                      ),

                      // Container(
                      //   padding: const EdgeInsets.all(6),
                      //   width: size24,
                      //   height: size24,
                      //   child: SvgPicture.asset('assets/svg/more_ver.svg'),
                      // ),

                      PopupMenuButton<MenuItem>(
                        constraints: BoxConstraints(
                            maxWidth: 100,
                            minWidth: 100,
                            maxHeight: 200,
                            minHeight: 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        position: PopupMenuPosition.under,
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            height: 30,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: scrWidth * 0.065,
                                  ),
                                  Text(
                                    "Edit",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: scrWidth * 0.035,
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            height: 30,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: scrWidth * 0.065,
                                  ),
                                  Text(
                                    "Delete ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: scrWidth * 0.035,
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.proLis['price'],
                        style: GoogleFonts.urbanist(
                            fontSize: scrWidth * 0.03,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ),
                      Row(
                        children: [
                          Text(
                            inStock ? "(in stock)" : "(out of stock)",
                            style: GoogleFonts.urbanist(
                                fontSize: scrWidth * 0.025, fontWeight: FontWeight.w600),
                          ),
                          Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              thumbColor: inStock
                                  ? Color(0xff02B558)
                                  : Color(0xffE54D3C),
                              activeColor: Color(0xffD9D9D9),
                              trackColor: Color(0xffD9D9D9),
                              value: inStock,
                              onChanged: (value) {
                                setState(() {
                                  inStock = !inStock;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
