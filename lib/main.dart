import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/utils/themes.dart';
import 'InviteLink/ChitInvite.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

String inviteLinkId = '';
String inviteLinkType = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    initDynamicLinks();
    super.initState();
  }

  final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(primaryColor: primarycolor),
    );
  }

  initDynamicLinks() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;

      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text(deepLink.path)));
      // Example of using the dynamic link to push the user to a different screen
      // Navigator.pushNamed(context, deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text(dynamicLinkData.link.path)));
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      // Handle errors
    });

    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('here');
      snackbarKey.currentState!
          .showSnackBar(SnackBar(content: Text(dynamicLinkData.link.path)));
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
      String link =
          'https://threems.page.link/chit_invite?chitId=Soh8aIjP91uHUGCSmNLV&refferalId=bs5Fg1reebM3LX9VO5QrkjSQqEA2';
      inviteLinkId = link.split('=')[1].split('&')[0];
      inviteLinkType =
          link.split('//')[1].split('/')[1].split('?')[0].split('_')[0];
      print('Linkkkkkkkkkkkkkkkkk');
      print(inviteLinkId);
      print(inviteLinkType);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
}
