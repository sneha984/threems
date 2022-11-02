import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';
import '../utils/dummy.dart';

class CharityWidget extends StatefulWidget {
  CharityWidget({Key? key}) : super(key: key);

  @override
  State<CharityWidget> createState() => _CharityWidgetState();
}

class _CharityWidgetState extends State<CharityWidget> {
  PageController pageController = PageController(viewportFraction: .9);
  var _currentPageValue = 0.0;

  @override
  void initState() {
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
    return Container(
      height: scrHeight * .17,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        itemCount: carouselImages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: scrWidth * .9,
            height: scrHeight * .2,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  carouselImages[index],
                ),
              ),
            ),
            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(12),
            //   child: CachedNetworkImage(
            //     fit: BoxFit.fill,
            //     imageUrl: carouselImages[index],
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
