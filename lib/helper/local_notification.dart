// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class LocalNotification {
//   static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//  static Future<void> intialization() async {
//     WidgetsFlutterBinding.ensureInitialized();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('amulogo');
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String payload) async {
//       if (payload != null) {
//         debugPrint('notification payload: $payload');
//       }
//     });
//   }

//   static Future<void> showNotificationWithDefaultSound(
//       String id, String title, String body) async {
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.max, priority: Priority.high);
//     var platformChannelSpecifics =
//         new NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }
// }
