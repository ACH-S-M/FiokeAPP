import 'package:flutter/material.dart';
import 'package:fioke/view/component/ClickedBtn.dart';
import 'package:fioke/view/component/Produk/deskripsiLayout.dart';

class Detail extends StatelessWidget {
  final String nama;
  final String harga;
  final String gambar;
  final String deskripsi;
  final String judulDeskripsi;
  final List<String> poin;
  const Detail({
    required this.harga,
    required this.nama,
    super.key,
    required this.gambar,
    required this.deskripsi,
    required this.judulDeskripsi,
    required this.poin
  });

  @override
  Widget build(BuildContext context) {
    // Kalo gambar itu network image hasil dari API dia berawalan http atau https
    bool isNetworkImage = gambar.startsWith('http://') || gambar.startsWith('https://');
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(  // Agar tidak tertutup notch atau status bar 
        child: SingleChildScrollView(  // Agar bisa di scroll
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(  // Container untuk gambar atas dengan width penuh 
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(),
                child: isNetworkImage  //apakah gambar dari network atau asset
                  ? Image.network(  
                      gambar, //ambill dari parameter gambar yang dikirim dari card 
                      width: 440,
                      height: 440,
                      scale: 90,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {  // Jika gagal memuat gambar
                        return Container( 
                          width: 440,  //kasih placeholder saat gagal memuat gambar
                          height: 440,
                          color: Colors.grey[300],
                          child: Icon(Icons.error, size: 50, color: Colors.grey[600]),
                        );
                      },
                    )
                  : Image.asset(  //kalo gambar dari asset dia ambil gambar dari hardware 
                      gambar,
                      width: 440,
                      height: 440,
                      scale: 90,
                      fit: BoxFit.fill,
                    ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.fromLTRB(30, 30, 30, 0),  //padding kiri, atas, kanan, bawah
                child: Row( // Row untuk harga dan icon button
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rp. $harga', //harganya ini ambil dari parameter harga yang dikirim dari card
                      style: TextStyle(
                        fontFamily: 'Poppins-Semibold',
                        fontSize: 24,
                        color: Color(0xFFD23201),
                      ),
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.rtl,
                      textWidthBasis: TextWidthBasis.parent,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const ClickedBtn(), 
                      iconSize: 28,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.fromLTRB(30, 0, 30, 40),
                    child: Text(
                      nama, //nama produk diambil dari parameter nama yang dikirim dari card
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins-Semibold',
                      ),
                    ),
                  ),
                ],
              ),
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- List item dengan icon ---
              _buildListTile(Icons.local_shipping, "Estimasi pengiriman 2-3 hari"),
              const Divider(thickness: 2, indent: 22,endIndent: 22,),
              const SizedBox(height: 8),
              _buildListTile(Icons.check_circle_outline, "OkeOce pastikan dulu paket anda"),
                const Divider(thickness: 2, indent: 22,endIndent: 22,),
              const SizedBox(height: 8),
              _buildListTile(Icons.credit_card, "Pembayaran dengan cicilan 3x"),
                const Divider(thickness: 2, indent: 22,endIndent: 22,),
              const SizedBox(height: 16),

              // --- Bar biru ---
              Container(
                margin: EdgeInsets.all(24),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF174B73),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text(
                    "Pengiriman dari Jakarta Selatan",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // --- Row promo ---
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    // GRATIS ONGKIR
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "GRATIS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "ONGKIR",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // BIG DISCOUNT
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                      ),
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "BIG",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: "DISCOUNT",
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Pilih Expedisi
                    const Text(
                      "Pilih Expedisi",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                    DeskripsiComponent(deskripsi: deskripsi,judul: judulDeskripsi,poin: poin,)
                ],
              )
            ],
          ),
          
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          color: Colors.white, // background footer
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol chat
              Flexible(
                flex: 2,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      ClickedBtn();
                    },
                    icon: const Icon(Icons.message, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Tombol keranjang
              Flexible(
                flex: 2,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Tombol beli sekarang (paling panjang)
              Expanded(
                flex: 8,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Beli Sekarang",
                      style: TextStyle(color: Colors.white),
                    ),
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
  // --- Helper ListTile custom ---
  Widget _buildListTile(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }


