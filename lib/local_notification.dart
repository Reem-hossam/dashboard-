
import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings =
  InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(initSettings);
}
Future<void> showNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Background Notifications',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformDetails =
  NotificationDetails(android: androidDetails);
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformDetails,
  );
log("j");
}