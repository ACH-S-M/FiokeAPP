import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.103.227.107/",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 6),
      headers: {"Accept": "application/json"},
    ),
  );

  static Dio get dio => _dio;


  // contoh GET
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
}
