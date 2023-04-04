import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';

class PushNotificationService {
  static String? token;

  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initializeApp() async {
    await Firebase.initializeApp();
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings()
    );
    notificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onBackgroundMessage(backgroundMessage);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("New notification");
      }
    });
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print("OnMessage");
        print(message.notification!.title);
        print(message.notification!.body);
        createNotification(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        print("OnMessageOpenedApp");
        print(message.notification!.title);
        print(message.notification!.body);
        createNotification(message);
      }
    });
  }

  static Future<void> backgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      print("BackgroundMessage");
      print(message.notification!.title);
      print(message.notification!.body);
      createNotification(message);
    }
  }
  static void createNotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "pushnotification",
        "pushnotificationchannel",
        importance: Importance.max,
        priority: Priority.high,
        actions: const [
          AndroidNotificationAction('action_one', 'Action One'),
          AndroidNotificationAction('action_two', 'Action Two')
        ],
        sound: const UriAndroidNotificationSound('https://www.myinstants.com/media/sounds/beeper_emergency_call.mp3'),
        fullScreenIntent: true,
        autoCancel: false,
        ongoing: true,
        playSound: true,
        showWhen: true,
        onlyAlertOnce: false,
        vibrationPattern: Int64List.fromList([1000, 1500, 500, 2000]),
        enableVibration: true,
        category: AndroidNotificationCategory.alarm,

      ));
      await notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: 'action_one',
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
