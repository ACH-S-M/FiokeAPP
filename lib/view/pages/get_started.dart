import 'package:flutter/material.dart';
import 'package:fioke/view/pages/login_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});
  @override
  State<StatefulWidget> createState() => _Getstarted();
}

class _Getstarted extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Positioned.fill(
              child: Image.asset('images/back.png', fit: BoxFit.cover),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 200),
              child: Center(
                child: Image.asset('images/logofioke.png', width: 150),
              ),
            ),
            // ContainerStart di bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'images/containerstart.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  ElevatedButton(onPressed: () {
                     Navigator.pushReplacementNamed(context, '/beranda');
                  }, child: Text("Get Started"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
