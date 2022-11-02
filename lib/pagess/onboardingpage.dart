import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threems/pagess/sliderpage.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'getotppage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentpage=0;
  PageController _controller=PageController();
  List<Widget> pages=[
    SliderPage(
        title: "Manage Chits & Kuri",
        image:"assets/icons/managechit.svg",
        description: "the feature which helps simplifies the chit and kuri \nbusiness and mainly focused for our local."
    ),
    SliderPage(
        title: "Donate & Fundraise",
        image: "assets/icons/donate.svg",
        description: "trusted donate & fundraise feature.send money \ndirectly to people those want helping hands from our \nside."
    ),
    SliderPage(
        title: "Buy & Sell",
        image: "assets/icons/buy.svg",
        description: "the feature is perfect online marketplace to buy and \nsell locally .No"
            " need to visit the flea market to find \nthe best deals on pre owned items."),
    SliderPage(
        title: "Expence Calculation",
        image: "assets/icons/slide1.svg",
        description: "this feature allows you to record your expenceeasily.\nOptionally you can assign a category to you expence \nin order to get dettailed statics."
    ),
  ];

  Onchange(int index){
    setState(() {
      _currentpage=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
              controller: _controller,
              onPageChanged: Onchange,
              itemCount: pages.length,

              itemBuilder: (context,int index){
              return pages[index];
              },

          ),


          Column(
             mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(pages.length, ( int index) =>
                    AnimatedContainer(duration: Duration(milliseconds: 300),
                      height: scrHeight*0.007,
                      width: (index==_currentpage)?scrWidth*0.16:scrWidth*0.016,
                      margin: EdgeInsets.symmetric(horizontal: scrWidth*0.009,vertical: scrHeight*0.03),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: carousaldotcolor,),
                    )),
              ),
              SizedBox(height: scrHeight*0.14,),


              GestureDetector(
                onTap: (){
                  setState(() {
                    _currentpage==pages.length-1?
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GetOtpPage())):
                    null;

                  });
                },
                child: Container(
                  height: scrHeight*0.052,
                  width: scrWidth*0.75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color:(_currentpage==(pages.length-1))?primarycolor:signupcolor,

                  ),
                  child: Center(
                    child:  Text(
                      "SIGN UP",
                      style:style,
                    ),
                  ),
                ),
              ),
              SizedBox(height: scrHeight*0.007,),

              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: TextStyle(
                        fontSize: scrWidth*0.03,color: Color(0xff000000).withOpacity(0.3),fontFamily: 'Outfit',fontWeight: FontWeight.w400
                    ),
                  children:  <TextSpan>[
                    TextSpan(text: 'Login',  style: TextStyle(
                                fontSize: scrWidth*0.03,color: primarycolor,fontFamily: 'Outfit',fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
                SizedBox(height: scrHeight*0.05,),

            ],
          )
        ],
      ),


    );
  }
}
