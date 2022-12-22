// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
//
// class Noti{
//   static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
//     var iOSInitialize = new DarwinInitializationSettings();
//     var initializationsSettings = new InitializationSettings(android: androidInitialize,
//         iOS: iOSInitialize);
//     await flutterLocalNotificationsPlugin.initialize(initializationsSettings );
//   }
//
//   static Future showBigTextNotification({var id =0,
//     required String title,
//     required String body,
//     var payload,
//
//     required FlutterLocalNotificationsPlugin fln
//   } ) async {
//     AndroidNotificationDetails androidPlatformChannelSpecifics =
//     new AndroidNotificationDetails(
//       'you_can_name_it_whatever1',
//       'channel_name',
//       playSound: true,
//      // sound: RawResourceAndroidNotificationSound('notification'),
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     var not= NotificationDetails(android: androidPlatformChannelSpecifics,
//         iOS: const DarwinNotificationDetails()
//     );
//     await fln.show(0, title, body,not);
//   }
//
// }
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotifications extends StatefulWidget {
  static String routeName = '/notif';

  @override
  State<LocalNotifications> createState() => _LocalNotifications();
}

class _LocalNotifications extends State<LocalNotifications> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();

  final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();

  DateTime dateTime = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/ic_launcher");
    const DarwinInitializationSettings iosInitializationSettings =DarwinInitializationSettings();
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
  }

  showNotification() {
    if (_title.text.isEmpty || _desc.text.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );

    const DarwinNotificationDetails iosNotificationDetails =DarwinNotificationDetails();
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );



    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);
    flutterLocalNotificationsPlugin.zonedSchedule(
        01, _title.text, _desc.text, scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: 'Ths is the data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('Local Notification'),

      ),

      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  label: Text("Notification Title"),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _desc,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  label: Text("Notification Description"),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _date,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: InkWell(
                      child: Icon(Icons.date_range),
                      onTap: () async {
                        final DateTime? newlySelectedDate =
                        await showDatePicker(
                          context: context,
                          initialDate: dateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2095),
                        );

                        if (newlySelectedDate == null) {
                          return;
                        }

                        setState(() {
                          dateTime = newlySelectedDate;
                           _date.text =
                           "${dateTime.year}/${dateTime.month}/${dateTime.day}";
                        });
                      },
                    ),
                    label: Text("Date")),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextField(
                controller: _time,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: InkWell(
                      child: const Icon(
                        Icons.timer_outlined,
                      ),
                      onTap: () async {
                        final TimeOfDay? slectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now()
                        );

                        if (slectedTime == null) {
                          return;
                        }

                        _time.text =
                        "${slectedTime.hour}:${slectedTime.minute}:${slectedTime.period.toString()}";

                        DateTime newDT = DateTime(
                          dateTime.year,
                          dateTime.month,
                          dateTime.day,
                          slectedTime.hour,
                          slectedTime.minute,
                        );
                        setState(() {
                          dateTime = newDT;
                        });
                      },
                    ),
                    label: Text("Time")),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55),
                  ),
                  onPressed: showNotification,
                  child: Text("Show Notification")),
            ],

          ),

        ),

      ),
    );

  }
}