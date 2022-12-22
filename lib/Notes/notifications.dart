// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../main.dart';
// import 'noti.dart';
//
// class NotificationPage extends StatefulWidget {
//   final Map not;
//   const NotificationPage({Key? key, required this.not}) : super(key: key);
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   @override
//   void initState(){
//     super.initState();
//     // Noti.initialize(flutterLocalNotificationsPlugin);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF3ac3cb), Color(0xFFf85187)])),
//       child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             backgroundColor: Colors.blue.withOpacity(0.5),
//
//           ),
//           body:
//           // widget.not['date']==DateTime.now()?Noti.showBigTextNotification(
//           //       title: widget.not['title'],
//           //       body: widget.not['time'],
//           //       fln: flutterLocalNotificationsPlugin,
//           //   )
//           Center(
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20)
//               ),
//               width: 200,
//               height: 80,
//               child: ElevatedButton(
//                 onPressed: (){
//                   // Noti.showBigTextNotification(
//                   //     title: widget.not['title'],
//                   //     body: widget.not['time'],
//                   //     fln: flutterLocalNotificationsPlugin,
//                   // );
//                 }, child: Text("click"),
//               ),
//             ),
//           )
//       ),
//     );
//   }
// }
