import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:threems/Authentication/phoneUpdate.dart';
import 'package:threems/Authentication/root.dart';

import '../layouts/screen_layout.dart';
import '../pagess/getotppage.dart';
import '../screens/splash_screen.dart';

class CheckPhoneNumber extends StatefulWidget {
  const CheckPhoneNumber({Key? key}) : super(key: key);

  @override
  State<CheckPhoneNumber> createState() => _CheckPhoneNumberState();
}

class _CheckPhoneNumberState extends State<CheckPhoneNumber> {
  String phone = '';
  bool loading = true;
  getData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .snapshots()
        .listen((event) {
      if (event.exists) {
        loading = false;
      }
      phone = event['phone'];

      print(phone);
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print('as');
    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;
    return loading == true
        ? Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: CircularProgressIndicator()))
        : phone == ''
            ? AddPhone(id: currentuserid)
            : ScreenLayout();
  }
}
