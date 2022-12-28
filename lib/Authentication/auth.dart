import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/pagess/onboardingpage.dart';

var userName;
var userImage;
var userEmail;
var phone;
String? userDoc;
Timestamp? dateTime;

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print('1');
    userName = userCredential.user?.displayName;
    print('2');

    userImage = userCredential.user?.photoURL;
    print('3');

    userEmail = userCredential.user?.email;
    print('4');

    userDoc = userCredential.user?.uid;
    print('5');

    currentuserid = userCredential.user?.uid;
    print('6');

    phone = userCredential.user?.phoneNumber ?? '';
    print('7');

    // dateTime=DateTime.now() as Timestamp?;

    try {
      print('HERE TRY ');
      FirebaseFirestore.instance
          .collection('users')
          .doc(userDoc)
          .update({
            "userId": userDoc,
            "userName": userName,
            "userEmail": userEmail,
            "userImage": userImage,
            // "phone": '',
            "dateTime": DateTime.now(),
          })
          .onError((error, stackTrace) =>
              FirebaseFirestore.instance.collection('users').doc(userDoc).set({
                "userId": userDoc,
                "userName": userName,
                "userEmail": userEmail,
                "userImage": userImage,
                "phone": '',
                "dateTime": DateTime.now(),
              }))
          .whenComplete(() {
            print('COMPLETED');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Rootingpage(),
                ),
                (route) => false);
          });
    } catch (err) {
      FirebaseFirestore.instance.collection('users').doc(userDoc).set({
        "userId": userDoc,
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "phone": '',
        "dateTime": DateTime.now(),
      }).whenComplete(() {
        print('COMPLETED');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Rootingpage(),
            ),
            (route) => false);
      });
    }

    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Rootingpage(),
    //     ),
    //     (route) => false);
    //     .then((value) {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const PhoneVerify(),
    //       ));
    // })
  }

  // Future<void> verifyPhoneNumber(BuildContext context) async {
  //   await FirebaseAuth.instance.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     timeout: const Duration(seconds: 15),
  //     verificationCompleted: (AuthCredential authCredential) {
  //       setState(() {
  //         authStatus = "Your account is successfully verified";
  //       });
  //     },
  //     verificationFailed: (AuthException authException) {
  //       setState(() {
  //         authStatus = "Authentication failed";
  //       });
  //     },
  //     codeSent: (String verId, [int forceCodeResent]) {
  //       verificationId = verId;
  //       setState(() {
  //         authStatus = "OTP has been successfully send";
  //       });
  //       otpDialogBox(context).then((value) {});
  //     },
  //     codeAutoRetrievalTimeout: (String verId) {
  //       verificationId = verId;
  //       setState(() {
  //         authStatus = "TIMEOUT";
  //       });
  //     },
  //   );
  // }

  //SIGN OUT
  // signOut() {
  //   _auth.signOut();
  //   // .then((value) => Navigator.pushAndRemoveUntil(
  //   // context,
  //   // MaterialPageRoute(
  //   //   builder: (context) => const Routing(),
  //   // ),
  //   // (route) => false));
  // }
  //
  // googleSignOut() {
  //   GoogleSignIn().signOut();
  // }
  signOut(BuildContext context) async {
    GoogleSignIn().disconnect();
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoarding(),
            ),
            (route) => false));
  }
}
