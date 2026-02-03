import 'package:flutter/material.dart';
import 'package:task_assignment/app/task_assignment.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'helper_functions/notification_service.dart';



final FlutterLocalNotificationsPlugin notificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> initNotification() async {
  const AndroidInitializationSettings androidInit =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
  InitializationSettings(android: androidInit);

  await notificationsPlugin.initialize(settings);
}



void main () async {
  WidgetsFlutterBinding.ensureInitialized();

  await initNotification();
  await InitializationSettings();
  /////
  final service = NotificationService();
  await service.initNotification();



  runApp(TaskAssignment());
}

