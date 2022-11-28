import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';

class SuccesfullyAdded extends StatefulWidget {
  final dynamic data;

  const SuccesfullyAdded({Key? key, required this.data}) : super(key: key);

  @override
  State<SuccesfullyAdded> createState() => _SuccesfullyAddedState();
}

class _SuccesfullyAddedState extends State<SuccesfullyAdded> {
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(context, MaterialPageRoute
        (builder: (context)=>StoreDetailsFill2(data: widget.data)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff02B558),
      body: Center(
        child: Text(
          "Product succesfully \nadded",textAlign: TextAlign.center,style: TextStyle(
          color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700,fontFamily: 'Urbanist'
        ),
        ),
      ),
    );
  }
}
