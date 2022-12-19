import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQuestions extends StatefulWidget {
  const FAQuestions({Key? key}) : super(key: key);

  @override
  State<FAQuestions> createState() => _FAQuestionsState();
}

class _FAQuestionsState extends State<FAQuestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("FAQ"),
      ),
    );
  }
}
