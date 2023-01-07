import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';


class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService= FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String> onNotificationClick = BehaviorSubject();




  Future<void> intialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/launcher_icon");

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: null,
    );

    await  _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

  }
  Future<NotificationDetails> _notificationDetails()async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'descriptipn',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    return  const NotificationDetails(
      android: androidNotificationDetails,
    );
  }


  Future<void> showNotificationWithPayload(
      {required int id,
        required String title,
        required String body,
        required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }


  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      onNotificationClick.add(payload!);

    }

  }
}