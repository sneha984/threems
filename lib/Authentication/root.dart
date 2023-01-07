import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threems/layouts/screen_layout.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/pagess/getotppage.dart';
import 'package:threems/pagess/loginpage.dart';
import 'package:threems/pagess/onboardingpage.dart';
import 'package:threems/screens/home_screen.dart';
import 'package:threems/screens/splash_screen.dart';

import '../Notes/no.dart';
import '../Notes/notes.dart';
import 'checkPhoneAuth.dart';

var userdata;
var currentuserid;

class Rootingpage extends StatefulWidget {
  const Rootingpage({Key? key}) : super(key: key);

  @override
  State<Rootingpage> createState() => _RootingpageState();
}

class _RootingpageState extends State<Rootingpage> {
  bool signedIn = false;

  getLoginStatus() {
    // FirebaseAuth.instance.authStateChanges().listen((event) {
    //   if (event.connectionState == ConnectionState.waiting) {
    //     return CircularProgressIndicator();
    //   } else if (snapshot.hasData) {
    //     userdata = snapshot.data!;
    //     currentuserid = userdata.uid;
    //     getcurrentuser();
    //     return CheckPhoneNumber();
    //   } else if (snapshot.hasError) {
    //     return Center(
    //       child: Text("something went wrong"),
    //     );
    //   } else {
    //     return OnBoarding();
    //   }
    // });

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        signedIn = false;
      } else {

        userdata = user;
        currentuserid = userdata.uid;
        print("root pageee");
        print(user.phoneNumber);
        try {
          QuerySnapshot usrs = await FirebaseFirestore.instance
              .collection('users')
              .where('phone', whereIn: [
            user.phoneNumber,
            "+91${user.phoneNumber}",
            "+91 ${user.phoneNumber}",
            user.phoneNumber?.substring(3),
         user.phoneNumber?.substring(4),
          ])
              .get();
          if (usrs.docs.length > 0) {
            currentuserid = usrs.docs[0].id;
            while (usrs.docs[0].get('userEmail') == "") {
              await Future.delayed(Duration(seconds: 1));
            }
            getcurrentuser();
            signedIn = true;
          } else {
            print(currentuserid);
            getcurrentuser();
            signedIn = true;
          }
        }
        catch(e){
          getcurrentuser();
          signedIn = true;
        }

      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  bool viewed = false;
  getViewedData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('viewed');
    print('!1');
    print(prefs.containsKey('viewed'));

    if (prefs.containsKey('viewed')) {
      viewed = true;
      // prefs.remove('viewed');
    }
    setState(() {});
  }


  @override
  void initState() {

    super.initState();
    // signOut(context);
    getLoginStatus();
    getViewedData();

  }

  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;

    return signedIn == true
        ? CheckPhoneNumber()
        : viewed
            ? GetOtpPage()
            : OnBoarding();

    //   Scaffold(
    //   body: StreamBuilder(
    //     stream: FirebaseAuth.instance.authStateChanges(),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return CircularProgressIndicator();
    //       } else if (snapshot.hasData) {
    //         userdata = snapshot.data!;
    //         currentuserid = userdata.uid;
    //         getcurrentuser();
    //         return CheckPhoneNumber();
    //       } else if (snapshot.hasError) {
    //         return Center(
    //           child: Text("something went wrong"),
    //         );
    //       } else {
    //         return OnBoarding();
    //       }
    //     },
    //   ),
    // );
  }

  // signOut(BuildContext context) async {
  //   GoogleSignIn().disconnect();
  //   await FirebaseAuth.instance
  //       .signOut()
  //       .then((value) => Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => OnBoarding(),
  //           ),
  //           (route) => false));
  // }
}
