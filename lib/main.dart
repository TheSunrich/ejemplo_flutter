import 'package:ejemplo_flutter/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_flutter/MyApp.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'channel_group_key',
            channelKey: 'channel_key',
            channelName: 'channel_name',
            channelDescription: 'channel_description',
            defaultColor: const Color(0xFFC02222),
            ledColor: Colors.white)
      ],
      debug: true);
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

/*
c13H8mtkQ3mtoo8oAWO2B8:APA91bGvquM511-984oOZSToSbNGcwMwNTijd7M4aMlHjFdNQx2AHvYvqYTW4kZQlxZCtfcy9QhpN-gL4VybSMlcBbToi6lsge9pPXRS1Bjqv_8A3My161u8qRal5oy-c1QWsGOD7fob
*/
