import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  List<Product> products;

  ProductApi({this.products});

  factory ProductApi.fromJson(Map<String, dynamic> parsedJson) {
    return ProductApi(products: parseProducts(parsedJson));
  }

  /** Возвращает список продуктов **/
  static List<Product> parseProducts(productsJson) {
    var list = productsJson['data'] as List;
    List<Product> productList =
        list.map((data) => Product.fromJson(data)).toList();
    return productList;
  }
}

class Product {
  int productId;
  String title;
  String productDescription;
  int price;
  String rating;

  Product({this.productId, this.title});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        productId: parsedJson['productId'], title: parsedJson['title']);
  }
}

Widget productListWidget() {
  Future<ProductApi> futureProductApi;
  futureProductApi = fetchProductApi();
  return FutureBuilder(
    future: futureProductApi,
    builder: (context, productSnap) {
      if (productSnap.connectionState == ConnectionState.none &&
          productSnap.hasData == null) {
        print('products snapshot data is: ${productSnap.data}');
        return Container();
      }
      return ListView.builder(
        itemCount: 1,
//          itemCount: productSnap.data.data.length,
        itemBuilder: (context, index) {
          ProductApi productApi = productSnap.data;
          List<Product> productList = productApi.products;
          print('products snapshot data is: ${productList[1].title}');
          return Column(
            children: <Widget>[],
//              children: <Widget>[],
          );
        },
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('ProductList')),
    body: productListWidget(),
  );
}

// метод для асинхронного получения данных, возвращает productApi
Future<ProductApi> fetchProductApi() async {
  final response = await http.get(
      'http://ostest.whitetigersoft.ru/api/common/product/list?appKey='
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF');
//  await http.get('https://jsonplaceholder.typicode.com/albums/1');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return ProductApi.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
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
