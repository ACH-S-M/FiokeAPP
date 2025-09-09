import 'package:fioke/view/component/Struktur/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:fioke/view/component/Produk/cardproduk.dart';
import 'package:fioke/viewmodel/produk_viewmodel.dart';
import 'package:fioke/view/component/Struktur/carousel.dart';
import 'package:fioke/view/component/Struktur/topNav.dart';
import 'package:fioke/models/Produk.dart';
import 'package:provider/provider.dart';


class FiokeMain extends StatefulWidget {
  const FiokeMain({super.key});

  @override
  State<FiokeMain> createState() => _FiokeMainState();
}

class _FiokeMainState extends State<FiokeMain> {
  @override
  void initState() {
    super.initState();
    // Load products when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProdukViewModel>().loadProducts();
    });
  }

  Future<void> _refresh() async {
    await context.read<ProdukViewModel>().refreshProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProdukViewModel>(
      builder: (context, produkViewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
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
                    if (produkViewModel.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (produkViewModel.hasError)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.error, size: 50, color: Colors.red),
                              const SizedBox(height: 16),
                              Text("Error: ${produkViewModel.errorMessage}"),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: _refresh,
                                child: const Text("Coba Lagi"),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (!produkViewModel.hasData)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(50),
                          child: Text("Tidak ada data produk"),
                        ),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: produkViewModel.produkList.length,
                        itemBuilder: (context, index) {
                          final produk = produkViewModel.produkList[index];

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
                      ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: const SafeArea(child: Bottomnav(currentIndex: 0)),
        );
      },
    );
  }
}

