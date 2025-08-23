import 'package:fioke/component/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:fioke/card/cardproduk.dart';
import 'package:fioke/data/dataproduk.dart';

class FiokeMain extends StatelessWidget {
  final String namauser;
  const FiokeMain({required this.namauser,super.key});
  
  @override
  Widget build(BuildContext context) {
    const int PrimaryColor = 0xFF1F4E78;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:   Column(
          children: [
            Container(
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(PrimaryColor),
                  borderRadius: BorderRadius.only(bottomLeft:Radius.circular(40),bottomRight: Radius.circular(40))
                ) ,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selamat Datang!",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    namauser,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.2),
                            iconColor: Colors.white,
                            hintText: "Teh botol Sosro",
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.notifications,color: Colors.white,),
                      SizedBox(width: 10),
                      Icon(Icons.shopping_bag,color: Colors.white,),
                    ],
                  ),
                ],
              
              )
            ),
          Container(
          height: 180,
          margin: EdgeInsets.fromLTRB(0, 40, 0,40),
          child: PageView.builder(
            itemCount: 4, // jumlah banner
            itemBuilder: (context, index) {
              return Image.asset('images/banner.png',width:350 ,fit: BoxFit.contain,);
            },
          ),
        ),
        // TERLARIS
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("TERLARIS", style: TextStyle(fontWeight: FontWeight.bold)),
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
              poin: produk.poin ,
            );
          },
        ),
      ],
    ),
  ), 
),
bottomNavigationBar:
   SafeArea(child: Bottomnav()
     ),
   );
  }
}