import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class SliderPage extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  const SliderPage({Key? key, required this.title, 
    required this.image,
    required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
           SizedBox(height: scrHeight*0.27,),
          SvgPicture.asset(image,width: scrWidth*0.8,),
          SizedBox(height: scrHeight*0.05,),
          Text(title,style:onboardingtitle,),
          SizedBox(height: scrHeight*0.02,),
          Text(description,textAlign: TextAlign.center,style: onboardingdesc,),
        ],
      ),
    );
  }
}
