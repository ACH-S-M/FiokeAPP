import 'package:fioke/view/component/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:fioke/view/component/cardproduk.dart';
import 'package:fioke/models/dataproduk.dart';
import 'package:fioke/view/component/carousel.dart';
import 'package:fioke/view/component/topNav.dart';

class FiokeMain extends StatelessWidget {
  const FiokeMain({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Topnav(),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(30, 20, 30, 50),
                child: BannerCarousel(
                  images: [
                    'images/fanta2.png',
                    'images/fullcream.png',
                    'images/kopi.png',
                  ],
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
      bottomNavigationBar: SafeArea(child: Bottomnav(currentIndex: 0)),
    );
  }
}

class tapTextfield extends StatefulWidget {
  const tapTextfield({super.key});
  @override
  State<StatefulWidget> createState() => _tapTextfield();
}

class _tapTextfield extends State<tapTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: TextField(
        readOnly: true,
        onTap: () => Navigator.pushNamed(context, '/search'),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search), // icon di dalam TextField
          hintText: "Teh Botol Sosro",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        ),
      ),
    );
  }
}
