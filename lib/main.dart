import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/utils/themes.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

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
      home: Rootingpage(),
      theme: ThemeData(primaryColor: primarycolor),
    );
  }

  Future<void> initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('here');
      snackbarKey.currentState!.showSnackBar(
          SnackBar(content: Text('${dynamicLinkData.link.data}')));
      // Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }
}
