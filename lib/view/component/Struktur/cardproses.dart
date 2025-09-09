import 'package:flutter/material.dart';

class cardProses extends StatelessWidget {
  final IconData iconcard;
  final String judul;
  cardProses({super.key, required this.iconcard, required this.judul});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pesanan Anda : ",style:  TextStyle(color: Colors.grey,fontSize: 15),),
            GridView.count(
              crossAxisCount: 2, // 2 kolom
              mainAxisSpacing: 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio:
              4 / 2, // 1:1 = kotak, bisa coba 3/2 kalau mau lebih lebar
              children: [
                cardProses(iconcard: Icons.ac_unit_rounded, judul: "Tes 1"),
                cardProses(iconcard: Icons.ac_unit_rounded, judul: "Tes 2"),
                cardProses(iconcard: Icons.ac_unit_rounded, judul: "Tes 3"),
                cardProses(iconcard: Icons.ac_unit_rounded, judul: "Tes 4"),
                cardProses(iconcard: Icons.ac_unit_rounded, judul: "Tes 3"),
                cardProses(iconcard: Icons.ac_unit_rounded, judul: "Tes 4"),
              ],
            ),
          ],
        ),
      );
  }
  Widget Component(BuildContext context){
    final int cardColor = 0xff6A84F9;
    return Padding(
      padding: EdgeInsetsGeometry.all(4),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsetsGeometry.all(12),
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(color: Color(cardColor)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(iconcard,color: Colors.white,),
                Text(judul,style: TextStyle(color: Colors.white),)
              ]),
        ),
      ),
    );
  }
}
