import 'package:dio/dio.dart';
import 'package:fioke/models/Produk.dart';
import 'package:fioke/network/api_services.dart';
import 'package:flutter/material.dart';
class Servicesuser {
  Future <List<Produk>> user_Service() async {
    Response response;
    response = await ApiService.dio.get(
      'api/produk',
    );
    List<Produk> produk = (response.data['data'] as List)
        .map((json) => Produk.fromjson(json))
        .toList();
    return produk;
  }
}