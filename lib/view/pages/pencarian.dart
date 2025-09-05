import 'package:flutter/material.dart';
import 'package:fioke/view/component/Input/searchbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchbarWidget(),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Riwayat Pencarian Anda",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.6,
                          children: const [
                            ProductCard(title: "Nescafe Kaleng"),
                            ProductCard(title: "Teh Pucuk 1000ml"),
                            ProductCard(title: "Kopikap 200ml"),
                            ProductCard(title: "Susu Ultra Milk 200ml"),
                            ProductCard(title: "Kopi Goodday Freeze botol"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  const ProductCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            color: Colors.black45, // placeholder gambar
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
