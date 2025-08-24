import 'package:flutter/material.dart';

class Bottomnav extends StatelessWidget {
  Bottomnav({super.key});
  @override
  Widget build(BuildContext context) {
   const int PrimaryColor = 0xFF1F4E78;
    return Container(
      padding: EdgeInsets.fromLTRB(0,12, 0,12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(PrimaryColor)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
               Navigator.pushNamed(context, '/beranda');
            },
            icon: Icon(Icons.home_outlined,color: Colors.white,),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/kategori');
            },
            icon: Icon(Icons.grid_view_outlined,color: Colors.white,),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person_2_outlined,color: Colors.white,),
            iconSize: 32,
          ),
        ],
      ),
    );
  }
}
