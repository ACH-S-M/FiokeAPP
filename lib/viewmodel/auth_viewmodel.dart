import 'package:flutter/material.dart';
import 'package:fioke/network/api_services.dart';
import 'package:dio/dio.dart';

class AuthViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  // State variables
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isLoggedIn = false;
  String? _userToken;
  String? _userEmail;
  String? _userName;
  
  // Getters
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isLoggedIn => _isLoggedIn;
  String? get userToken => _userToken;
  String? get userEmail => _userEmail;
  String? get userName => _userName;
  
  // Login method
  Future<bool> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      _setError('Email dan password tidak boleh kosong');
      return false;
    }
    
    if (!_isValidEmail(email)) {
      _setError('Format email tidak valid');
      return false;
    }
    
    _setLoading(true);
    _clearError();
    
    try {
      Response response = await _apiService.postData('api/login', {
        "email": email.trim(),
        "password": password.trim()
      });
      
      if (response.statusCode == 200) {
        // Simpan data user jika ada
        if (response.data != null) {
          _userToken = response.data['token'];
          _userEmail = email.trim();
          _userName = response.data['name'];
        }
        _isLoggedIn = true;
        _setLoading(false);
        return true;
      } else {
        _setError('Login gagal');
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = _handleAuthError(e);
      _setError(errorMessage);
      return false;
    } catch (e) {
      _setError('Terjadi kesalahan: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Register method
  Future<bool> register(String name, String email, String password) async {
    if (name.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      _setError('Semua field harus diisi');
      return false;
    }
    
    if (!_isValidEmail(email)) {
      _setError('Format email tidak valid');
      return false;
    }
    
    if (password.length < 6) {
      _setError('Password minimal 6 karakter');
      return false;
    }
    
    _setLoading(true);
    _clearError();
    
    try {
      Response response = await _apiService.postData('api/register', {
        "name": name.trim(),
        "email": email.trim(),
        "password": password.trim()
      });
      
      if (response.statusCode == 200) {
        // Simpan data user jika ada
        if (response.data != null) {
          _userToken = response.data['token'];
          _userEmail = email.trim();
          _userName = name.trim();
        }
        _isLoggedIn = true;
        _setLoading(false);
        return true;
      } else {
        _setError('Registrasi gagal');
        return false;
      }
    } on DioException catch (e) {
      String errorMessage = _handleAuthError(e);
      _setError(errorMessage);
      return false;
    } catch (e) {
      _setError('Terjadi kesalahan: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }
  
  // Logout method
  void logout() {
    _isLoggedIn = false;
    _userToken = null;
    _userEmail = null;
    _userName = null;
    _clearError();
    notifyListeners();
  }
  
  // Handle authentication errors
  String _handleAuthError(DioException e) {
    switch (e.response?.statusCode) {
      case 401:
        return 'Email atau password salah';
      case 402:
        return 'Data tidak boleh kosong atau tidak valid';
      case 422:
        return 'Format email salah, gunakan @mail.com';
      case 409:
        return 'Email sudah terdaftar';
      case 500:
        return 'Server error, coba lagi nanti';
      default:
        return 'Terjadi kesalahan saat mengakses server';
    }
  }
  
  // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
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
