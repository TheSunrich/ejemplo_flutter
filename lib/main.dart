import 'package:ejemplo_flutter/services/push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_flutter/MyApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}

/*
c13H8mtkQ3mtoo8oAWO2B8:APA91bGvquM511-984oOZSToSbNGcwMwNTijd7M4aMlHjFdNQx2AHvYvqYTW4kZQlxZCtfcy9QhpN-gL4VybSMlcBbToi6lsge9pPXRS1Bjqv_8A3My161u8qRal5oy-c1QWsGOD7fob
*/
