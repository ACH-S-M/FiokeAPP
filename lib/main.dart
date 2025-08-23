import 'package:fioke/view/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true
      ),
      home:  AnimatedSplashScreen(
      splash: Image.asset('images/logofioke.png'),
      nextScreen: Login(),
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.fade,
        splashIconSize: 200,
      )
    );
  }
}

