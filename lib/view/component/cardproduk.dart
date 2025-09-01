
import 'package:fioke/view/pages/detail.dart';
import 'package:flutter/material.dart';

class CardProduk extends StatelessWidget {
   final String nama;
   final String harga;
   final String gambar;
   final String deskripsi;
   final String judul;
   final List<String> poin;
   
   const CardProduk({
     required this.nama,
     required this.harga,
     required this.gambar,
     super.key, 
     required this.deskripsi,
     required this.judul,
     required this.poin
   });
  
  @override
  Widget build(BuildContext context) {
    // Check if gambar is a network URL or asset path
    bool isNetworkImage = gambar.startsWith('http://') || gambar.startsWith('https://');
   
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder:(context)  {
          return Detail(
            harga: harga, 
            nama: nama,
            gambar: gambar,
            deskripsi: deskripsi,
            judulDeskripsi: judul,
            poin: poin
          );
        }));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: isNetworkImage
                    ? Image.network(
                       gambar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Gagal mengambil gambar : $error');
                          print('stacknya masuk ke  : $stackTrace');
                          print(gambar);
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 40, color: Colors.grey[600]),
                                SizedBox(height: 8),
                                Text(
                                  'Gambar tidak tersedia',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / 
                                      loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                      )
                    : Image.asset(
                        gambar,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading asset image: $error');
                          // Fallback to default image
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 40, color: Colors.grey[600]),
                                SizedBox(height: 8),
                                Text(
                                  'Gambar tidak tersedia',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nama, 
                    maxLines: 1, 
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Rp $harga", 
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}