import 'package:flutter/material.dart';

class Searchbarwidget extends StatefulWidget {
  const Searchbarwidget({super.key});
  @override
  State<StatefulWidget> createState() => _Searchbarwidget();
}

class _Searchbarwidget extends State<Searchbarwidget> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search), // icon di dalam TextField
          hintText: "Teh Botol Sosro",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29)),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 20,
          ), // biar text & icon rapi
        ),
      ),
    );
  }
}
