import 'package:dio/dio.dart';
import 'package:fioke/models/Produk.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.103.227.168/",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 6),
      headers: {"Accept": "application/json"},
    ),
  );

  static Dio get dio => _dio;


  // contoh GET
  Future<Response<Produk>> getProduk(String endpoint) async {
    return await _dio.get(endpoint);
  }
    Future<Response> getData(String endpoint) async {
    return await _dio.get(endpoint);
  }
  // contoh POST
  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(
     endpoint,
     data: data,
     options: Options(
      headers: {
        'Accept' : 'application/json',
      }
     ));
  }
   Future<Response<Produk>> searchdata(String endpoint, Map<String, dynamic> data) async {
    return await _dio.post(
     endpoint,
     data: data,
     options: Options(
      headers: {
        'Accept' : 'application/json',
      }
     ));
  }
}
