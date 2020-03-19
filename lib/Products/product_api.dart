import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Products/product.dart';
import 'package:flutterapp/Products/productList.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static const String productsApiURL =
      'http://ostest.whitetigersoft.ru/api/common/product/list?appKey=phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';

  static List<Product> parseProducts(dataJson) {
    var productsJson = dataJson['data'] as List;

    List<Product> productList =
        productsJson.map((data) => Product.fromJson(data)).toList();
    return productList;
  }
}

  class Meta {
  bool success;
  String error;

  Meta({this.success, this.error});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(success: parsedJson['success'], error: parsedJson['error']);
  }
}
