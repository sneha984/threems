// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:threems/Authentication/phoneUpdate.dart';
// import 'package:threems/Authentication/root.dart';
//
// import '../layouts/screen_layout.dart';
// import '../pagess/getotppage.dart';
// import '../screens/splash_screen.dart';
//
// class CheckPhoneNumber extends StatefulWidget {
//   const CheckPhoneNumber({Key? key}) : super(key: key);
//
//   @override
//   State<CheckPhoneNumber> createState() => _CheckPhoneNumberState();
// }
//
// class _CheckPhoneNumberState extends State<CheckPhoneNumber> {
//   @override
//   Widget build(BuildContext context) {
//     scrHeight = MediaQuery.of(context).size.height;
//     scrWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(currentuserid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           var data = snapshot.data;
//           if (data) {
//           } else if (data!['phone'] == '') {
//             return AddPhone();
//           } else {
//             return ScreenLayout();
//           }
//         },
//       ),
//     );
//   }
// }
