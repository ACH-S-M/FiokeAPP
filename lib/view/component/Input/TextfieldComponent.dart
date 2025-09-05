import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class MakeTextfield extends StatefulWidget {
  final String text;
  final Icon icon;
  final TextEditingController controller;
  final bool isPassword;

  const MakeTextfield({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.isPassword

  });

  @override
  State<MakeTextfield> createState() => _MakeTextfieldState();
}

class _MakeTextfieldState extends State<MakeTextfield> {
  @override
  Widget build(BuildContext context) {
    const PrimaryColor = Color(0xff035F79);

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword,
      style: const TextStyle(color: Colors.white), // text jadi putih
      decoration: InputDecoration(
        filled: true,
        fillColor: PrimaryColor,
        hintText: widget.text,
        hintStyle: const TextStyle(color: Colors.white70), // warna hint
        prefixIcon: Icon(widget.icon.icon, color: Colors.white), // icon putih
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // rounded corner
          borderSide: BorderSide.none, // tanpa border
        ),
      ),
    );
  }
}
