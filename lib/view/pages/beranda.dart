import 'package:fioke/view/component/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:fioke/view/component/cardproduk.dart';
import 'package:fioke/models/dataproduk.dart';
import 'package:fioke/view/component/searchbar.dart';
import 'package:fioke/view/component/carousel.dart';

class FiokeMain extends StatelessWidget {
  const FiokeMain({super.key});

  @override
  Widget build(BuildContext context) {
    const int PrimaryColor = 0xFF1F4E78;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(30, 12, 30, 20),
              child:  Row(
                children: [
                   Searchbarwidget(),
                   IconButton(onPressed: () {

                   }, icon: Icon(Icons.notifications_outlined),
                   iconSize: 32,),
                     IconButton(onPressed: () {

                   }, icon: Icon(Icons.shopping_bag_outlined),
                   iconSize: 32,),

              ]
              )
            ),
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(30, 20, 30, 50),
              child: BannerCarousel(
                images: [
                  'images/fanta2.png',
                  'images/fullcream.png',
                  'images/kopi.png'
                ]),),
              // TERLARIS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "TERLARIS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.7,
                ),
                itemCount: dataproduk.length,
                itemBuilder: (context, index) {
                  final produk = dataproduk[index];
                  return CardProduk(
                    nama: produk.nama,
                    harga: produk.harga,
                    gambar: produk.gambar,
                    deskripsi: produk.deskripsi,
                    judul: produk.juduldeskripsi,
                    poin: produk.poin,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: Bottomnav()),
    );
  }
}
