import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:threems/pagess/onboardingpage.dart';
var userName;
var userImage;
var userEmail;
String? userDoc;
class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken);
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);
    userName = userCredential.user?.displayName;
    userImage = userCredential.user?.photoURL;
    userEmail = userCredential.user?.email;
    userDoc = userCredential.user?.uid;
    print("chugfg ggggggg$userDoc");

    FirebaseFirestore.instance.collection('users').doc(userDoc).set({
      "userId": userDoc,
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
    });

    //     .then((value) {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => const PhoneVerify(),
    //       ));
    // })
  }

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
