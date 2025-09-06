import 'package:flutter/material.dart';
import 'package:fioke/view/component/Struktur/topNav.dart';
import 'package:fioke/viewmodel/search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:fioke/models/Produk.dart';
import 'package:fioke/view/component/Produk/cardproduk.dart';

class Hasilpencarian extends StatefulWidget {
  const Hasilpencarian({super.key});
  @override
  State<StatefulWidget> createState() => _Hasilpencarian();
}

class _Hasilpencarian extends State<Hasilpencarian> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Topnav(),
                Expanded(
                  child: searchViewModel.searchResults.isEmpty
                      ? _buildEmptyState()
                      : _buildProductList(searchViewModel),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            'Tidak ada produk ditemukan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Coba kata kunci lain',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(SearchViewModel searchViewModel) {
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
      itemCount: searchViewModel.searchResults.length,
      itemBuilder: (context, index) {
        final produk = searchViewModel.searchResults[index];
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
  }

}
