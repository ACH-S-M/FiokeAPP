import 'package:fioke/view/component/Struktur/topNav.dart';
import 'package:flutter/material.dart';
import 'package:fioke/view/component/Struktur/bottomNav.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Kategori extends StatelessWidget {
  const Kategori({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔎 Search bar + icon notification & cart
              Topnav(),

              const Divider(height: 1),

              // 🏷️ Kategori Kemasan
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Kategori Kemasan",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 3,
                children: [
                  kategoriItem("Kemasan Kaleng"),
                  kategoriItem("Kemasan Botol PET"),
                  kategoriItem("Kemasan Cup"),
                  kategoriItem("Kemasan Botol Kaca"),
                  kategoriItem("Kemasan Standing Pouch"),
                  kategoriItem("Kemasan Tetra Pak"),
                ],
              ),

              // 🥤 Jenis Minuman
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Jenis Minuman",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 0.8,
                children: [
                  jenisItem("Minuman Berkarbonasi"),
                  jenisItem("Minuman Kafein"),
                  jenisItem("Minuman Teh"),
                  jenisItem("Minuman Isotonik"),
                  jenisItem("Air Mineral"),
                  jenisItem("Susu dan Olahannya"),
                ],
              ),
            ],
          ),
        ),
      ),

      // ⬇️ Bottom Navigation Custom
      bottomNavigationBar: SafeArea(child: Bottomnav(currentIndex: 1)),
    );
  }

  // 🔹 Widget kategori
  static Widget kategoriItem(String title) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(width: 40, height: 40, color: Colors.black26),
          const SizedBox(width: 8),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // 🔹 Widget jenis minuman
  static Widget jenisItem(String title) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  // 🔹 Widget nav item
  static Widget navItem(String iconPath, String label, bool active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          color: active ? Colors.lightBlue : Colors.grey,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: active ? Colors.lightBlue : Colors.grey,
          ),
        ),
      ],
    );
  }
}
