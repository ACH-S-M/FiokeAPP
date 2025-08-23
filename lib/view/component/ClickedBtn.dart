import 'package:flutter/material.dart';

class ClickedBtn extends StatefulWidget {
  const ClickedBtn({super.key});
  @override
  State<StatefulWidget> createState() => _ClickedBtn();
}

class _ClickedBtn extends State<ClickedBtn> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
           isClick = !isClick;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isClick
              ? Colors.red
              : Colors.transparent, // penuh merah kalau diklik
          border: Border.all(
            color: Colors.red,
            width: 2,
          ), // selalu ada border merah
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.favorite,
          color: isClick ? Colors.white : Colors.red, // ikon putih saat aktif
        ),
      ),
    );
  }
}
