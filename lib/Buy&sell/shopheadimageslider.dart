import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
import '../utils/themes.dart';

class ImageSlide extends StatefulWidget {
  final String type;
  const ImageSlide({Key? key, required this.type}) : super(key: key);

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  List utilityImages = [];
  getUtiltyImages() {
    FirebaseFirestore.instance
        .collection('ads')
        .where('type', isEqualTo: widget.type)
        .snapshots()
        .listen((event) {
      utilityImages = [];
      for (var doc in event.docs) {
        utilityImages.add(doc['image']);
      }
      if (mounted) {
        setState(() {});
      }
    });
  }

  PageController pageController = PageController(viewportFraction: 1);
  var _currentPageValue = 0.0;

  @override
  void initState() {
    getUtiltyImages();
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // color: Colors.red,
          height: scrWidth * 0.3,
          width: scrWidth * 1,
          // width: 334,
          // height: 125,
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: pageController,
            itemCount: carouselImage.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: scrWidth * 0.005),

                height: scrWidth * 0.3,
                width: scrWidth * 0.91,
                // width : 326,
                // height: 125,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(scrWidth * 0.04),
                  // image: DecorationImage(
                  //   fit: BoxFit.fill,
                  //   image: NetworkImage(
                  //     carouselImages[index],
                  //   ),
                  // ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(scrWidth * 0.04),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: utilityImages.isEmpty ? '' : utilityImages[index],
                  ),
                ),
              );
            },
          ),
        ),
        DotsIndicator(
          dotsCount: utilityImages.isEmpty ? 1 : utilityImages.length,
          position: _currentPageValue,
          decorator: DotsDecorator(
            spacing: EdgeInsets.all(scrWidth * 0.01),
            activeColor: dotIndicatorColor,
            color: dotIndicatorColor,
            size: Size(
                // 6,
                // 4,
                scrWidth * 0.017,
                scrWidth * 0.011),
            activeSize: Size(
                // 61,
                //4,
                scrWidth * 0.168,
                scrWidth * 0.011),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scrWidth * 0.011),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(scrWidth * 0.011),
            ),
          ),
        ),
      ],
    );
  }
}
