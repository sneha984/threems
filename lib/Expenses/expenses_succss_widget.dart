import 'dart:async';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:threems/layouts/screen_layout.dart';
import 'package:threems/screens/splash_screen.dart';

import '../utils/themes.dart';
class ExpenseSuccesPage extends StatefulWidget {
  const ExpenseSuccesPage({Key? key}) : super(key: key);

  @override
  State<ExpenseSuccesPage> createState() => _ExpenseSuccesPageState();
}

class _ExpenseSuccesPageState extends State<ExpenseSuccesPage> {

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
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
              DottedBorder(
                borderType: BorderType.Rect,
                radius: Radius.circular(30),
                dashPattern: [3, 3],
                color: Colors.white,
                strokeWidth: 0.5,
                 child: ClipRRect(
               borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    height: scrWidth*0.4,
                    width: scrWidth*0.4,
                    child: Lottie.asset('assets/images/lf30_editor_jcnh7q01.json',repeat: false),
                  ),
                ),
              ),
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
