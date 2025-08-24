import 'package:flutter/material.dart';
import 'package:fioke/view/component/bottomNav.dart';

class Kategori extends StatelessWidget {
 Kategori({super.key});
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: 
          Text("Haloi")
        ),
      bottomNavigationBar: Bottomnav(),
    );
  }
}