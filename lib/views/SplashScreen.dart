import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ejemplo_flutter/views/MainView.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset(
        'assets/animations/splashscreen.json',
        frameRate: FrameRate.max, //Sin esta linea de código la animación corre de manera lenta
      ),
      backgroundColor: Colors.indigoAccent,
      splashIconSize: 250,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      nextScreen: const MainView(),
    );
  }
}
