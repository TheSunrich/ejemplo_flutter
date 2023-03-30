import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ejemplo_flutter/MyApp.dart';
import 'package:flutter/material.dart';
import 'package:ejemplo_flutter/components/SimpleDialogItem/SimpleDialogItem.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io' show Platform;

class MainView extends StatefulWidget {
  const MainView({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late FToast fToast;

  XFile? _image;

  Future getImage(bool isCamera) async {
    final ImagePicker picker = ImagePicker();
    XFile? image;
    if (isCamera) {
      image = await picker.pickImage(source: ImageSource.camera);
    } else {
      image = await picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(navigatorKey.currentContext!);
  }

  void send() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: -1,
        channelKey: 'channel_key',
        //Same as above in initilize,
        title: 'title',
        body: 'body',
        wakeUpScreen: true,
        fullScreenIntent: true,
        criticalAlert: true,
        actionType: ActionType.KeepOnTop,
        autoDismissible: false,
        displayOnBackground: true,
        displayOnForeground: true,
        locked: true,
        category: NotificationCategory.Alarm,

        //Other parameters
      ),
      actionButtons: <NotificationActionButton>[
        NotificationActionButton(key: 'accept', label: 'Accept'),
        NotificationActionButton(key: 'reject', label: 'Reject'),
      ],

    );
    AwesomeNotifications().setListeners(onActionReceivedMethod: (receivedAction) async {
      print(receivedAction.buttonKeyPressed);
    });
    if (Platform.isAndroid) {
      const AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: 'https://play.google.com/store/apps/details?'
            'id=com.google.android.apps.myapp',
      );
      await intent.launch();
    }
  }

  void showToast(String text, {required Color color, IconData? icon}) {
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(
              width: 12.0,
            ),
            Text(text),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }

  ImageProvider setImageInCircle() {
    if (_image != null) return FileImage(File(_image!.path));
    return const NetworkImage(
        'https://cdn2.melodijolola.com/media/files/styles/nota_imagen/public/field/image/banff-4331689_1920.jpg');
  }

  Future openDialog(String text) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(text),
            children: [
              SimpleDialogItem(
                icon: Icons.looks_one_rounded,
                color: Colors.orange,
                text: 'Opción 1',
                onPressed: () {
                  showToast('Se ha seleccionado la opción 1', color: Colors.greenAccent);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogItem(
                icon: Icons.looks_two_rounded,
                color: Colors.green,
                text: 'Opción 2',
                onPressed: () {
                  showToast('Se ha seleccionado la opción 2', color: Colors.greenAccent);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogItem(
                icon: Icons.looks_3_rounded,
                color: Colors.grey,
                text: 'Opción 3',
                onPressed: () {
                  showToast('Se ha seleccionado la opción 3', color: Colors.greenAccent);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogItem(
                icon: Icons.cancel_rounded,
                color: Colors.redAccent,
                text: 'Cancelar',
                onPressed: () {
                  showToast('Se ha cancelado la selección',
                      color: Colors.redAccent, icon: Icons.close_rounded);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );

  Future<void> _getRequest() async {
    Map<String, String> headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      "Origin": "",
    };
    var url = Uri.https('yoenvio.synology.me', 'clarios/sdk/check/', {'check': ''});
    var response = await get(url, headers: headers);
    showToast(response.body.toString(), color: Colors.indigo);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Container(
            margin: const EdgeInsets.only(
              top: 25,
            ),
            child: Center(
              child: Column(
                children: [
                  PopupMenuButton(
                    position: PopupMenuPosition.under,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    onSelected: (value) => {getImage(value == 'camera')},
                    itemBuilder: (BuildContext context) {
                      return const [
                        PopupMenuItem(
                          value: 'camera',
                          child: ListTile(
                            leading: Icon(Icons.camera_alt_rounded),
                            title: Text('Abrir Cámara'),
                          ),
                        ),
                        PopupMenuItem(
                          value: 'galery',
                          child: ListTile(
                            leading: Icon(Icons.photo_library_rounded),
                            title: Text('Abrir Galería'),
                          ),
                        ),
                      ];
                    },
                    icon: Material(
                      elevation: 5,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Ink.image(
                        height: 200,
                        width: 200,
                        image: setImageInCircle(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Ricardo Ramirez',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: screenWidth,
                    height: screenHeight * .5,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () => openDialog('Ejemplo de Selección'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.list_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button1)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/skeleton').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.reorder_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button2)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            send();
                            _getRequest();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.wifi_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button3)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/swipe').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.swipe_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button4)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/chip').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.toggle_off_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button5)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/signature').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.border_color_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button6)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/zoom').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.zoom_out_map_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button7)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/loader').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.refresh_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button8)
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.pushNamed(context, '/calendar').then((result) {
                              setState(() {
                                fToast = FToast();
                                fToast.init(navigatorKey.currentContext!);
                              });
                            })
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.blue),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                size: 40,
                              ),
                              Text(AppLocalizations.of(context)!.button9)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
