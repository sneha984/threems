import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:threems/products/product_widget.dart';

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
    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;
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
              padding: EdgeInsets.symmetric(horizontal: size20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/back.svg'),
                      SizedBox(
                        width: size15,
                      ),
                      Text(
                        "Your Products",
                        style: GoogleFonts.urbanist(
                            fontWeight: FontWeight.w500,
                            fontSize: fontSize16,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  Container(
                    width: scrWidth * 0.28,
                    height: size40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size16),
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
                            fontSize: fontSize16,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size17),
            child: Container(
              width: scrWidth,
              height: scrHeight * 0.895,
              // color: Colors.red,
              child: ListView.separated(
                padding: EdgeInsets.only(top: size20),
                itemCount: yourPro.length,
                itemBuilder: (context, index) => ProductWidget(
                  index: index,
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: size20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
