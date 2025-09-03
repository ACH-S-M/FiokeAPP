import 'package:fioke/view/component/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:fioke/view/component/cardproduk.dart';
import 'package:fioke/viewmodel/ProdukViewModel.dart';
import 'package:fioke/view/component/carousel.dart';
import 'package:fioke/view/component/topNav.dart';
import 'package:fioke/models/Produk.dart';


class FiokeMain extends StatefulWidget {
  const FiokeMain({super.key});

  @override
  State<FiokeMain> createState() => _FiokeMainState();
}

class _FiokeMainState extends State<FiokeMain> {
  late Future<List<Produk>> _futureProduk;

  @override
  void initState() {
    super.initState();
    _futureProduk = Produkviewmodel().user_Service();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureProduk = Produkviewmodel().user_Service();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // wajib biar bisa tarik
            child: Column(
              children: [
                Topnav(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 50),
                  child: BannerCarousel(
                    images: [
                      'images/fanta2.png',
                      'images/fullcream.png',
                      'images/kopi.png',
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _futureProduk,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error, size: 50, color: Colors.red),
                            const SizedBox(height: 16),
                            Text("Error: ${snapshot.error}"),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _refresh,
                              child: const Text("Coba Lagi"),
                            ),
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Tidak ada data produk"),
                      );
                    }

                    final produkList = snapshot.data!;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: produkList.length,
                      itemBuilder: (context, index) {
                        final produk = produkList[index];

                        return CardProduk(
                          nama: produk.nama_produk,
                          harga: produk.harga_produk.toString(),
                          gambar: produk.gambar_produk,
                          deskripsi: produk.deskripsi_produk,
                          judul: produk.nama_produk,
                          poin: [
                            "Stok: ${produk.stok}",
                            "Terjual: ${produk.barang_terjual}",
                            "ID: ${produk.ID_Produk}",
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SafeArea(child: Bottomnav(currentIndex: 0)),
    );
  }
}

