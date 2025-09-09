import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fioke/models/Produk.dart';
import 'package:fioke/network/api_services.dart';
import 'package:dio/dio.dart';

class SearchViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  Timer? _debounceTimer;
  
  // State variables
  bool _isLoading = false;
  List<Produk> _searchResults = [];
  String _searchQuery = '';
  String _errorMessage = '';
  
  // Fungsi Pembantu untuk nambah http / di path gambar, sama seperti di ProdukViewModel
  static String getFullImageUrl(String imagePath) {
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath; // sudah dengan http 
    }
    
    // Kalo ini diawalai dengan / 
    if (imagePath.startsWith('/')) {
      return 'http://10.103.227.168$imagePath';
    } else {
      return 'http://10.103.227.168/$imagePath';
    }
  }
  
  // Getters
  bool get isLoading => _isLoading;
  List<Produk> get searchResults => _searchResults;
  String get searchQuery => _searchQuery;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get hasResults => _searchResults.isNotEmpty;
  
  // Search method with debouncing
  void searchProducts(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(query);
    });
  }
  
  // Perform actual search
  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      _setError('Masukkan kata kunci pencarian');
      return;
    }
    
    _setLoading(true);
    _clearError();
    _searchQuery = query.trim();
    
    try {
      Response response = await _apiService.postData(
        'api/search',
        {"value": _searchQuery},
      );
      
      if (response.statusCode == 200 && response.data != null) {
        List<Produk> produkList = (response.data['data'] as List)
            .map((item) {
              try {
                if (item['gambar_produk'] != null) {
                  item['gambar_produk'] = getFullImageUrl(item['gambar_produk']);
                }
                return Produk.fromjson(item);
              } catch (e) {
                print('Error parsing search item: $e');
                print('Item data: $item');
                rethrow;
              }
            })
            .toList();
        
        _searchResults = produkList;
        
        if (produkList.isEmpty) {
          _setError('Tidak ada produk yang ditemukan');
        }
      } else {
        _setError('Gagal mendapatkan data');
      }
    } on DioException catch (e) {
      String errorMessage = 'Terjadi kesalahan saat mencari';
      if (e.response?.statusCode == 404) {
        errorMessage = 'API tidak ditemukan';
      } else if (e.response?.statusCode == 500) {
        errorMessage = 'Server error';
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Koneksi timeout';
      }
      _setError(errorMessage);
    } catch (e) {
      _setError('Terjadi kesalahan: $e');
    } finally {
      _setLoading(false);
    }
  }
  
  // Clear search results
  void clearSearch() {
    _searchResults.clear();
    _searchQuery = '';
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
    _debounceTimer?.cancel();
    super.dispose();
  }
}
