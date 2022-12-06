import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/products/productListWidget.dart';
import '../screens/splash_screen.dart';
import 'const.dart';
import 'dummyData.dart';

class ProductWidget extends StatefulWidget {
  final int index;
  const ProductWidget({super.key, required this.index});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool showProduct = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(scrWidth * 0.055),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 15,
              color: Colors.black.withOpacity(0.15),
            )
          ]),
      width: scrWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              showProduct = !showProduct;
              setState(() {});
            },
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: scrWidth * 0.055, vertical: scrWidth * 0.065),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/edit_cat.svg'),
                      SizedBox(
                        width: scrWidth * 0.039,
                      ),
                      Text(yourPro[widget.index]['title']),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    width: scrWidth * 0.065,
                    height: scrWidth * 0.065,
                    child: SvgPicture.asset(showProduct
                        ? 'assets/svg/arrow_up.svg'
                        : 'assets/svg/arrow_down.svg'),
                  ),
                ],
              ),
            ),
          ),
          showProduct
              ? Column(
                  children: [
                    const Divider(
                      endIndent: 5,
                      indent: 5,
                      thickness: 1.5,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: scrWidth * 0.039),
                      itemCount: yourPro[widget.index]['pro'].length,
                      itemBuilder: (context, index) {
                        var prodLis = yourPro[widget.index]['pro'][index];
                        return ProductListWidget(
                          proLis: prodLis,
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: scrWidth * 0.026,
                      ),
                    ),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
