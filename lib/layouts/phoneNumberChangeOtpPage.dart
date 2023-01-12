import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/screens/charity/verification_details.dart';

import '../Authentication/auth.dart';
import '../Authentication/root.dart';
import '../layouts/screen_layout.dart';
import '../model/usermodel.dart';
import '../pagess/detailspage.dart';
import '../pagess/getotppage.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';
import '../utils/themes.dart';
UpdateNumber(String userId, String phNo){
  FirebaseFirestore.instance.collection('users')
      .doc(userId)
      .update(
      {
        'phone':phNo,
      });
}
class PhoneChangeOtpPage extends StatefulWidget {
  final String verId;
  final String number;

  const PhoneChangeOtpPage({
    Key? key,
    required this.verId,
    required this.number,
  }) : super(key: key);

  @override
  State<PhoneChangeOtpPage> createState() => _PhoneChangeOtpPageState();
}

class _PhoneChangeOtpPageState extends State<PhoneChangeOtpPage> {
  final Authentication _authentication = Authentication();


  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController otp = TextEditingController();
  List phList=[];

  @override
  void initState() {
    // getPh();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await confirmQuitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // leading: GestureDetector(
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         top: scrHeight * 0.02,
          //         left: scrWidth * 0.07,
          //         bottom: scrHeight * 0.02,
          //         right: scrWidth * 0.05),
          //     child: SvgPicture.asset(
          //       "assets/icons/arrow.svg",
          //     ),
          //   ),
          // ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: scrWidth * 0.07),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: scrHeight * 0.008,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "We have send a 6 digit OTP on \n +91 ${widget.number}",
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w600,
                        fontSize: scrWidth * 0.05),
                  ),
                  SizedBox(
                    height: scrHeight * 0.008,
                  ),
                  Text(
                    "Enter the OTP below to verify your number",
                    style: TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w400,
                        fontSize: scrWidth * 0.035,
                        color: Color(0xff000000).withOpacity(0.5)),
                  ),
                ],
              ),
              SizedBox(
                height: scrHeight * 0.048,
              ),
              Padding(
                padding: EdgeInsets.only(left: scrWidth * 0.018),
                child: Pinput(
                  controller: otp,
                  defaultPinTheme: PinTheme(
                      height: scrHeight * 0.06,
                      width: scrWidth * 0.12,
                      decoration: BoxDecoration(
                          color: Color(0xffEEEEEE),
                          borderRadius: BorderRadius.circular(8))),
                  length: 6,
                ),
              ),
              SizedBox(
                height: scrHeight * 0.07,
              ),
              GestureDetector(
                onTap: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verId, smsCode: otp.text);


                  String cUserId=currentuserid;
                 await FirebaseFirestore.instance.collection('users')
                      .doc(cUserId)
                      .update(
                      {
                        'phone':widget.number,
                      });
                  await auth.signInWithCredential(credential).then((value) async {
                    // UpdateNumber(cUserId,widget.number);
                    print(value.user!.uid);


                      showUploadMessage(context, 'Phone number updated successfully');
                      Navigator.pop(context);

                    print(cUserId);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Rootingpage()), (route) => false);

                    print(cUserId);





                    // if (currentuserid == '') {
                    //
                    // }
                    // else {
                    //   try {
                    //     await FirebaseAuth.instance.signOut().then((value) {
                    //       FirebaseFirestore.instance
                    //           .collection('users')
                    //           .doc(currentuserid)
                    //           .update({
                    //         "phone": widget.number,
                    //       });
                    //     }).then((value) => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => Rootingpage())));
                    //   } catch (e) {
                    //     print(e.toString());
                    //   }
                    // }
                  }
                  ).catchError((e) {
                    FirebaseFirestore.instance.collection('users')
                        .doc(cUserId)
                        .update(
                        {
                          'phone':currentuser?.phone,
                        });
                    print(e);
                    showSnackbar(context, 'Wrong OTP!!');
                  });
                },
                child: Container(
                  height: scrHeight * 0.055,
                  width: scrWidth * 0.87,
                  decoration: BoxDecoration(
                    color: primarycolor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text("CONTINUE", style: style),
                  ),
                ),
              ),
              SizedBox(
                height: scrHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
