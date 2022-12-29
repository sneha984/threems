import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';

class FAQuestions extends StatefulWidget {
  const FAQuestions({Key? key}) : super(key: key);

  @override
  State<FAQuestions> createState() => _FAQuestionsState();
}

class _FAQuestionsState extends State<FAQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.02,
                left: scrWidth * 0.05,
                // bottom: scrHeight * 0.02,
                right: scrWidth * 0.04),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
      ),

      body: Center(
        child: Text("FAQ"),
      ),
    );
  }
}
