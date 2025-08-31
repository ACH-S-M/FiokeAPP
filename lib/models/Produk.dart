class Produk {
  final int ID_Produk;
  final String nama_produk;
  final int harga_produk;
  final int stok;
  final String gambar_produk;
  final String deskripsi_produk;
  final int barang_terjual;
  Produk({
    required this.ID_Produk,
    required this.nama_produk,
    required this.harga_produk,
    required this.stok,
    required this.gambar_produk,
    required this.deskripsi_produk,
    required this.barang_terjual,
  });

  factory Produk.fromjson(Map<String, dynamic> json) {
    return Produk(
      ID_Produk: json['ID_Produk'],
      nama_produk: json['nama_produk'],
      harga_produk: json['harga_produk'],
      stok: json['stok'],
      gambar_produk: json['gambar_produk'],
      deskripsi_produk: json['deskripsi_produk'],
      barang_terjual: json['barang_terjual'],
    );
  }
}
