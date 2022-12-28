import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Notes/notesdetailspage.dart';
import 'package:threems/layouts/screen_layout.dart';
import 'package:threems/screens/home_screen.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List getAllNotes = [];

  getNotes() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuserid)
        .collection('notes')
        .snapshots()
        .listen((event) {
      getAllNotes = [];
      for (DocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
        getAllNotes.add(doc.data()!);
        if (doc['remainder'] == true) {
          showNotification(doc.data()!);
        }
      }
      if (mounted) {
        setState(() {
          print(getAllNotes.length);
        });
      }
    });
  }

  DateTime dateTime = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (dataYouNeedToUseWhenNotificationIsClicked) {},
    );
    getNotes();
    // TODO: implement initState
    super.initState();
  }

  showNotification(Map notes) {
    String s = notes['remainderTime'];
    var t = notes['rDate'].toDate();

    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(s.split(":")[0]), minute: int.parse(s.split(":")[1]));
    dateTime = DateTime(
      t.year,
      t.month,
      t.day,
      _startTime.hour,
      _startTime.minute,
    );
    print(
        "************************************************${dateTime.toString()}");

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );
    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);
    flutterLocalNotificationsPlugin.zonedSchedule(
        01, notes['title'], notes['content'], scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: 'Ths is the data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: scrHeight * 0.158,
            width: scrWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ScreenLayout()),
                            (route) => false);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: scrHeight * 0.1,
                        left: scrWidth * 0.07,
                        // bottom: scrHeight*0.02,
                        right: scrWidth * 0.03),
                    child: Container(
                      height: scrHeight * 0.02,
                      width: scrWidth * 0.06,
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: scrHeight * 0.1,
                  ),
                  child: Text(
                    "Your Notes",
                    style: TextStyle(
                        fontSize: scrWidth * 0.045,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  width: scrWidth * 0.35,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: scrHeight * 0.1,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotesDetailPage(
                                    update: false,
                                  )));
                    },
                    child: Container(
                      height: scrHeight * 0.035,
                      width: scrWidth * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(scrWidth * 0.03),
                        color: primarycolor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            size: 11,
                            color: Colors.white,
                          ),
                          Text(
                            "Create New",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: CreateChitFont,
                                fontFamily: 'Urbanist',
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: getAllNotes.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: scrWidth * 0.02,
                        right: scrWidth * 0.02,
                        bottom: scrWidth * 0.02),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesDetailPage(
                                      notes: getAllNotes[index],
                                      update: true,
                                    )));
                      },
                      child: Container(
                        height: scrHeight * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(scrWidth * 0.02),
                          color: Colors.grey.withOpacity(0.1),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: scrWidth * 0.035,
                            ),
                            Container(
                              height: scrHeight * 0.085,
                              width: scrWidth * 0.16,
                              color: Colors.grey.withOpacity(0.4),
                              child: Column(
                                children: [
                                  Container(
                                    height: scrHeight * 0.02,
                                    width: scrWidth * 0.16,
                                    color: Color(0xff02B558),
                                    child: Center(
                                        child: Text(
                                      DateFormat('MMM').format(
                                          getAllNotes[index]['date'].toDate()),
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.002,
                                  ),
                                  Text(
                                    DateFormat('dd').format(
                                        getAllNotes[index]['date'].toDate()),
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat('yyyy').format(
                                        getAllNotes[index]['date'].toDate()),
                                    style: TextStyle(
                                        fontFamily: 'Urbanist',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: scrWidth * 0.04,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: scrWidth * 0.076),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Container(
                                      width: scrWidth * 0.2,
                                      child: Text(
                                        getAllNotes[index]['title'],
                                        style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: scrWidth * 0.045,
                                            color: Colors.black,
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: scrHeight * 0.01,
                                  ),
                                  Flexible(
                                    child: Container(
                                        width: scrWidth * 0.55,
                                        child: Text(
                                          getAllNotes[index]['content'],
                                          style: TextStyle(
                                              fontSize: scrWidth * 0.03,
                                              color: Colors.black,
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      content: const Text(
                                          "Do You Want to Delete this Note"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: const Text("No"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            setState(() {});
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(currentuserid)
                                                .collection('notes')
                                                .doc(getAllNotes[index]
                                                    ['noteId'])
                                                .delete();
                                          },
                                          child: const Text(
                                            "Yes",
                                            style:
                                                TextStyle(color: primarycolor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 20,
                                )),
                            // Row(
                            //   mainAxisSize:MainAxisSize.min,
                            //   children: [
                            //     IconButton(onPressed: (){
                            //       showDialog(
                            //         context: context,
                            //         builder: (ctx) => AlertDialog(
                            //           content: const Text("Do You Want to Delete this Note"),
                            //           actions: <Widget>[
                            //             TextButton(
                            //               onPressed: () {
                            //                 Navigator.of(ctx).pop();
                            //
                            //               },
                            //               child: const Text("No"),
                            //             ),
                            //             TextButton(
                            //               onPressed: () {
                            //                 Navigator.of(ctx).pop();
                            //                 setState(() {
                            //                 });
                            //                 FirebaseFirestore.instance
                            //                     .collection('users')
                            //                     .doc(currentuserid)
                            //                     .collection('notes')
                            //                     .doc(getAllNotes[index]['noteId'])
                            //                     .delete();
                            //
                            //               },
                            //               child: const Text(
                            //                 "Yes",
                            //                 style: TextStyle(color: primarycolor),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //
                            //
                            //     }, icon:Icon(Icons.delete,color: Colors.grey,size: 20,)),
                            //     // IconButton(onPressed: (){}, icon:Icon(Icons.edit,color: Colors.grey,size: 20,))
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
