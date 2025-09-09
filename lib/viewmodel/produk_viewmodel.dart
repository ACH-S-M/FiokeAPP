import 'package:flutter/material.dart';
import 'package:fioke/models/Produk.dart';
import 'package:fioke/network/api_services.dart';
import 'package:dio/dio.dart';

class ProdukViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  // State variables
  bool _isLoading = false;
  List<Produk> _produkList = [];
  String _errorMessage = '';
  DateTime? _lastFetchTime;
  static const Duration _cacheTimeout = Duration(minutes: 5); // Cache for 5 minutes
  
  // Getters
  bool get isLoading => _isLoading;
  List<Produk> get produkList => _produkList;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get hasData => _produkList.isNotEmpty;
  bool get isCacheValid => _lastFetchTime != null && 
      DateTime.now().difference(_lastFetchTime!) < _cacheTimeout;
  
  // Fungsi Pembantu untuk nambah http / di path gambar
  static String getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath; // sudah dengan http 
    }
    
    // Kalo ini diawalai dengan / 
    if (imagePath.startsWith('/')) {
      return 'http://10.103.227.202$imagePath';
    } else {
      return 'http://10.103.227.202/$imagePath';
    }
  }
  
  // Load products with caching
  Future<void> loadProducts({bool forceRefresh = false}) async {
    // Return cached data if valid and not forcing refresh
    if (!forceRefresh && isCacheValid && _produkList.isNotEmpty) {
      return;
    }
    
    _setLoading(true);
    _clearError();
    
    try {
      Response response = await _apiService.getData('api/produk');
      
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
              print('Error parsing item: $e');
              print('Item data: $json');
              rethrow;
            }
          })
          .toList();
      
      _produkList = produk;
      _lastFetchTime = DateTime.now();
      
      print('Successfully loaded ${produk.length} products');
      
    } catch (e) {
      print('Error in loadProducts: $e');
      _setError('Gagal memuat data produk: $e');
    } finally {
      _setLoading(false);
    }
  }
  
  // Refresh products (force reload)
  Future<void> refreshProducts() async {
    await loadProducts(forceRefresh: true);
  }
  
  // Get product by ID
  Produk? getProductById(int id) {
    try {
      return _produkList.firstWhere((produk) => produk.ID_Produk == id);
    } catch (e) {
      return null;
    }
  }
  
  // Search products locally
  List<Produk> searchProductsLocally(String query) {
    if (query.trim().isEmpty) return _produkList;
    
    return _produkList.where((produk) {
      return produk.nama_produk.toLowerCase().contains(query.toLowerCase()) ||
             produk.deskripsi_produk.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
  
  // Clear cache
  void clearCache() {
    _produkList.clear();
    _lastFetchTime = null;
    _clearError();
    notifyListeners();
  }
  
  // Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  void _clearError() {
    _errorMessage = '';
    notifyListeners();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
}
