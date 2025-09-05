import 'package:dio/dio.dart';
import 'package:fioke/models/Produk.dart';
import 'package:fioke/network/api_services.dart';

class Produkviewmodel {
  // Fungsi Pembantu untuk nambah http / di path gambar, kalo ga make nanti bakal ambil data gambar.png aja 
  static String getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath; // sudah dengan http 
    }
    
    // Kalo ini diawalai dengan / 
    if (imagePath.startsWith('/')) {
      return 'http://10.103.227.82$imagePath';
    } else {
      return 'http://10.103.227.82/$imagePath';
    }
  }

  Future<List<Produk>> user_Service() async {
    try {
      Response response = await ApiService().getData('api/produk');
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      
      if (response.data['data'] == null) {
        throw Exception('Data field is null in response');
      }
      
      List<dynamic> dataList = response.data['data'] as List;
      
      List<Produk> produk = dataList
          .map((json) {
            try {
              if (json['gambar_produk'] != null) {
                json['gambar_produk'] = getFullImageUrl(json['gambar_produk']);
              }
              return Produk.fromjson(json);
            } catch (e) {
              print('Error parsing item , salahnya diii    : : : : $e');
              print('Item data   nyaa   : $json');
              rethrow;
            }
          })
          .toList();
      
      print('Successfully parsed ${produk.length} products ini panjangnyaa?> ' );
      return produk;
      
    } catch (e) {
      print('Error in user_Service: $e');
      rethrow;
    }
  }
}