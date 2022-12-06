import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threems/products/product_widget.dart';

import '../screens/splash_screen.dart';
import 'const.dart';
import 'dummyData.dart';

class YourProducts extends StatefulWidget {
  const YourProducts({Key? key}) : super(key: key);

  @override
  State<YourProducts> createState() => _YourProductsState();
}

class _YourProductsState extends State<YourProducts> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0xff008036),
            width: scrWidth,
            height: scrHeight * 0.07,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: scrWidth * 0.055),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/back.svg'),
                      SizedBox(
                        width: scrWidth * 0.039,
                      ),
                      Text(
                        "Your Products",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: scrWidth * 0.045,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    width: scrWidth * 0.28,
                    height: scrWidth * 0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scrWidth * 0.045),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        color: Colors.white),
                    child: Center(
                      child: Text(
                        "+ Add new",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: scrWidth * 0.045,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:  scrWidth * 0.052),
            child: Container(
              width: scrWidth,
              height: scrHeight * 0.895,
              // color: Colors.red,
              child: ListView.separated(
                padding: EdgeInsets.only(top: scrWidth * 0.055),
                itemCount: yourPro.length,
                itemBuilder: (context, index) => ProductWidget(
                  index: index,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: scrWidth * 0.055,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
