import 'package:flutter/material.dart';
import 'package:fioke/services/user_services.dart';

String rupiah(int value) {
  // formatter sederhana (tanpa intl) – cukup buat demo
  final s = value.toString();
  final buf = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final idxFromRight = s.length - i;
    buf.write(s[i]);
    if (idxFromRight > 1 && idxFromRight % 3 == 1) {
      buf.write('.'); // kalo lebih dari 99 ribu bakan ada . misal 100.000
    }
  }
  return 'Rp. ${buf.toString()}';
}

class Rekomendasi extends StatelessWidget {
  const Rekomendasi({super.key});

  @override
  Widget build(BuildContext context) {
    {
      final api = Servicesuser();
      return FutureBuilder(
        future: api.user_Service(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError) {
              return const Center(
                child: Text("Error: inasu  "),
              );
          }
          if (!snapshot.hasData && snapshot.data!.isEmpty){
              return const Center(
                child: Text("No data"),
              );
          }
          final Photo = snapshot.data!;

          return GridView.builder(
            itemCount: Photo.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, i) {
              final p = Photo[i];
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    // future: navigate to detail
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // image
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Ink.image(
                          image: NetworkImage(p.gambar_produk),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // text
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
                        child: Text(
                          p.nama_produk,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 2,
                        ),
                        child: Text(
                          rupiah(p.harga_produk),
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
