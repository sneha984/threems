import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../layouts/screen_layout.dart';
import '../../screens/splash_screen.dart';
import '../../utils/themes.dart';
class IncomeSuccessPage extends StatefulWidget {
  const IncomeSuccessPage({Key? key}) : super(key: key);

  @override
  State<IncomeSuccessPage> createState() => _IncomeSuccessPageState();

}

class _IncomeSuccessPageState extends State<IncomeSuccessPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
        ..pop()
        ..pop();
    });
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => ScreenLayout(index: 2,),), (route) => false);
      },
      child: Scaffold(
        backgroundColor: tabBarColor,
        body: Container(

          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: scrWidth*0.7,
                width: scrWidth*0.6,
                child: Lottie.asset('assets/images/lf30_editor_ir8omejz.json',reverse: true),
              ),
              // DottedBorder(
              //   borderType: BorderType.Rect,
              //   radius: Radius.circular(30),
              //   dashPattern: [3, 3],
              //   color: Colors.white,
              //   strokeWidth: 0.5,
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.all(Radius.circular(12)),
              //     child:
              //   ),
              // ),
              SizedBox(height: 15,),
              Center(
                child: Text(
                  'Your expense is successfully\n added',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                  ),textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
