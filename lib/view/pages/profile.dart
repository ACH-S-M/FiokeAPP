import 'package:flutter/material.dart';
import 'package:fioke/view/component/Struktur/cardproses.dart';

class Profile extends StatefulWidget {
  Profile({super.key});
  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F4F4),
      body: SafeArea(
        child:cardProses(iconcard: Icons.abc, judul: "Ea")
      ),
    );
  }
}
