import 'package:flutter/material.dart';
import 'package:fioke/view/component/Struktur/bottomNav.dart';
import 'package:fioke/view/component/Struktur/topNav.dart';
import 'package:fioke/view/component/Produk/promocard.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Topnav(),
              ),
              SizedBox(
                width: MediaQuery.of(
                  context,
                ).size.width, //ini masih ada sisa sedikit gap nya
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset('images/fanta2.png', fit: BoxFit.fill),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(color: Colors.grey.shade200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Text(
                        "Serba Rp 10.000",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Text(
                        "Lihat selengkapnya",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsetsGeometry.fromLTRB(0, 12, 20, 12),
                  child: Row(
                    children: [
                      Promocard(
                        gambar: 'images/fanta2.png',
                        nama: 'Fanta',
                        harga: 'Rp 10.000',
                      ),
                      Promocard(
                        gambar: 'images/fullcream.png',
                        nama: 'Susu Full Cream',
                        harga: 'Rp 10.000',
                      ),
                      Promocard(
                        gambar: 'images/kopi.png',
                        nama: 'Kopi Kapal Api',
                        harga: 'Rp 10.000',
                      ),
                      Promocard(
                        gambar: 'images/fanta2.png',
                        nama: 'Fanta',
                        harga: 'Rp 10.000',
                      ),
                      Promocard(
                        gambar: 'images/fullcream.png',
                        nama: 'Susu Full Cream',
                        harga: 'Rp 10.000',
                      ),
                      Promocard(
                        gambar: 'images/kopi.png',
                        nama: 'Kopi Kapal Api',
                        harga: 'Rp 10.000',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Bottomnav(currentIndex: 2),
    );
  }
}
