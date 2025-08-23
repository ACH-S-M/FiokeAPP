
import 'package:fioke/view/pages/detail.dart';
import 'package:flutter/material.dart';

class CardProduk extends StatelessWidget {
   final String nama;
   final String harga;
   final String gambar;
   final String deskripsi;
   final String judul;
   final List<String> poin;
   CardProduk({required this.nama,required this.harga,required this.gambar,super.key, required this.deskripsi,required this.judul,required this.poin});
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(context)  {
              return Detail(harga: harga, nama: nama,gambar:gambar,deskripsi: deskripsi,judulDeskripsi: judul,poin: poin);
          }));
        },
        child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(gambar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama, 
                  maxLines: 1, 
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  "Rp $harga", 
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
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