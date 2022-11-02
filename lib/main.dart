import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/utils/themes.dart';
import 'screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Rootingpage(),
      theme: ThemeData(
          primaryColor: primarycolor
      ),
    );
  }
}
