import 'package:ejemplo_flutter/views/LoaderView.dart';
import 'package:ejemplo_flutter/views/CalendarView.dart';
import 'package:ejemplo_flutter/views/SignatureView.dart';
import 'package:ejemplo_flutter/views/SkeletonView.dart';
import 'package:ejemplo_flutter/views/SplashScreen.dart';
import 'package:ejemplo_flutter/views/SwipeView.dart';
import 'package:ejemplo_flutter/views/ChipView.dart';
import 'package:ejemplo_flutter/views/ZoomView.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr')
      ],
      routes: {
        '/': (context) => const SplashScreen(),
        '/skeleton': (context) => const SkeletonView(),
        '/swipe': (context) => const SwipeView(),
        '/chip': (context) => const ChipView(),
        '/signature': (context) => const SignatureView(),
        '/zoom': (context) => const ZoomView(),
        '/loader': (context) => const LoaderView(),
        '/calendar': (context) => const CalendarView(),
      },
      builder: FToastBuilder(),
      navigatorKey: navigatorKey,
    );
  }
}



