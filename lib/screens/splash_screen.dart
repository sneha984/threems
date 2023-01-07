import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:threems/Authentication/root.dart';

import 'package:threems/layouts/screen_layout.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Notes/no.dart';
import '../Notes/notes.dart';
import '../pagess/onboardingpage.dart';
import '../utils/themes.dart';

var scrHeight;
var scrWidth;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final _localNotificationService= FlutterLocalNotificationsPlugin();
  // late final LocalNotificationService service;

  @override
  void initState() {
    // service=LocalNotificationService();
    // service.intialize();

    super.initState();
    // listenToNotification();


    Timer(const Duration(seconds: 3), () {
      // service.showNotificationWithPayload(
      //     id: 0,
      //     title: 'Notification Title',
      //     body: 'Some body',
      //     payload: 'payload navigation');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Rootingpage(),
            // ScreenLayout(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff07380B),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: scrHeight * 0.062),
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/splashScreenIcon.png",
                    height: scrHeight * 0.25,
                    width: scrWidth * 0.7,
                  ),
                  CircularProgressIndicator(color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // void listenToNotification() =>
  //     service.onNotificationClick.stream.listen(onNoticationListener);
  //
  // void onNoticationListener(String? payload) {
  //   print('Hereeeeee');
  //
  //   if (payload != null && payload.isNotEmpty) {
  //     print('payload $payload');
  //
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: ((context) => const NotesPage())));
  //   }
  //}

}
