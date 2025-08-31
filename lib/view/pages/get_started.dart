import 'package:flutter/material.dart';
import 'package:fioke/view/component/bg-carousel.dart';
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
              child: BgCarousel(images: [
                    'images/back.png',
                    'images/back2.png',
                    'images/back3.png',

              ])
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 200),
              child: Center(
                child: Image.asset('images/logofioke.png', width: 180),
              ),
            ),
            // ContainerStart di bawah
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    'images/containerstart.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 68),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/beranda');
                        },
                        child: Text(
                          "Get Started",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
