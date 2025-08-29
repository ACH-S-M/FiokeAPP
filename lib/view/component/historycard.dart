import 'package:flutter/material.dart';

class historycard extends StatelessWidget{
  //nanti disini kasih sesuai yg dia cari aja, kasih parameter atau atribut apa kek 
  const historycard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey,
        ),
        child: Row(
          children: [
              Image.asset('images/spritee.png',width: 75,),
              Text("Sprite 250 ML",style: TextStyle(decoration: TextDecoration.underline))
          ],


        ),
    );
  }

}
