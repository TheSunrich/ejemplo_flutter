import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
import 'package:firebase_core/firebase_core.dart';

class PushNotificationService {

  static String? token;

  static Future initializeApp() async {

    await Firebase.initializeApp();
    await AwesomeNotificationsFcm().initialize(
        onFcmSilentDataHandle: mySilentDataHandle,
        onFcmTokenHandle: myFcmTokenHandle,
        onNativeTokenHandle: myNativeTokenHandle,
        debug: true);
    AwesomeNotifications().isNotificationAllowed().then(
            (isAllowed) {
          //It would be more appropriate if you can show your own dialog
          //to the user before requesting the notifications permissons.
          if (!isAllowed) {
            AwesomeNotifications().requestPermissionToSendNotifications(
              permissions: [
                NotificationPermission.Alert,
                NotificationPermission.Sound,
                NotificationPermission.Badge,
                NotificationPermission.Vibration,
                NotificationPermission.Light,
                NotificationPermission.FullScreenIntent,
              ],
            );
          }
        }
    );
    token = await getFirebaseMessagingToken();
    print(token);
  }

  @pragma("vm:entry-point")
  static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
    print('"SilentData": ${silentData.toString()}');

    if (silentData.createdLifeCycle != NotificationLifeCycle.Foreground) {
      print("bg");
    } else {
      print("FOREGROUND");
    }

    print("starting long task");
    await Future.delayed(Duration(seconds: 4));
    final url = Uri.parse("http://google.com");
    final re = await http.get(url);
    print(re.body);
    print("long task done");
  }

  /// Use this method to detect when a new fcm token is received
  @pragma("vm:entry-point")
  static Future<void> myFcmTokenHandle(String token) async {
    print('FCM Token:"$token"');
  }

  /// Use this method to detect when a new native token is received
  @pragma("vm:entry-point")
  static Future<void> myNativeTokenHandle(String token) async {
    print('Native Token:"$token"');
  }

  static Future<String> getFirebaseMessagingToken() async {
    String firebaseAppToken = '';
    if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
      try {
        firebaseAppToken = await AwesomeNotificationsFcm().requestFirebaseAppToken();
      }
      catch (exception){
        print('$exception');
      }
    } else {
      print('Firebase is not available on this project');
    }
    return firebaseAppToken;
  }
}