import 'package:dio/dio.dart';
import 'package:fioke/models/Produk.dart';
import 'package:fioke/network/api_services.dart';

class Servicesuser {
  // Helper function to construct full image URL
  static String getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath; // Already a full URL
    }
    
    // If it's a relative path, construct full URL
    if (imagePath.startsWith('/')) {
      return 'http://10.103.227.87:8000$imagePath';
    } else {
      return 'http://10.103.227.87:8000/$imagePath';
    }
  }

  Future<List<Produk>> user_Service() async {
    try {
      Response response = await ApiService.dio.get('api/produk');
      
      // Debug: print response data
      print('API Response: ${response.data}');
      
      if (response.data == null) {
        throw Exception('Response data is null');
      }
      
      if (response.data['data'] == null) {
        throw Exception('Data field is null in response');
      }
      
      List<dynamic> dataList = response.data['data'] as List;
      print('Data list length: ${dataList.length}');
      
      if (dataList.isNotEmpty) {
        print('First item: ${dataList.first}');
      }
      
      List<Produk> produk = dataList
          .map((json) {
            try {
              print('Parsing item hasilnya adalah : $json');
              // Convert image path to full URL
              if (json['gambar_produk'] != null) {
                json['gambar_produk'] = getFullImageUrl(json['gambar_produk']);
                print('Converted image URL: ${json['gambar_produk']}');
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