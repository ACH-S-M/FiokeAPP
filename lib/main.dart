
import 'package:fioke/view/pages/get_started.dart';
import 'package:fioke/view/pages/keranjang.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fioke/view/pages/kategori.dart';
import 'package:fioke/view/pages/beranda.dart';
import 'package:fioke/view/pages/promo.dart';
import 'package:fioke/view/pages/login_page.dart';
import 'package:fioke/view/pages/register_page.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (_) => AnimatedSplashScreen(
                splash: Image.asset('images/logofioke.png'),
                nextScreen:GetStarted(),
                backgroundColor: Colors.white,
                splashTransition: SplashTransition.sizeTransition,
                pageTransitionType: PageTransitionType.fade,
                splashIconSize: 200,
                duration: 4000,
              ),
            );
          case '/login' : 
            return MaterialPageRoute(builder: (_) => LoginPage() );
          case '/register' : 
            return MaterialPageRoute(builder: (_) => RegisterPage() );
          case '/beranda':
            return MaterialPageRoute(builder: (_) => const FiokeMain());
          case '/kategori':
            return MaterialPageRoute(builder: (_) => Kategori());
          case'/keranjang':
            return MaterialPageRoute(builder: (_) => CartPage());
          case '/promo' :
            return MaterialPageRoute(builder: (_) => PromoPage());
        }
        return null;
      },
    );
  }
}
