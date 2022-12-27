import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:threems/layouts/screen_layout.dart';
import 'package:threems/model/usermodel.dart';
import 'package:threems/pagess/getotppage.dart';
import 'package:threems/pagess/loginpage.dart';
import 'package:threems/pagess/onboardingpage.dart';
import 'package:threems/screens/home_screen.dart';
import 'package:threems/screens/splash_screen.dart';

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

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        signedIn = false;
      } else {
        userdata = user;
        currentuserid = userdata.uid;
        getcurrentuser();

        signedIn = true;
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // signOut(context);
    getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    scrHeight = MediaQuery.of(context).size.height;
    scrWidth = MediaQuery.of(context).size.width;

    return signedIn == true ? CheckPhoneNumber() : OnBoarding();

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
}
