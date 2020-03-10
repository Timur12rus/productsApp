import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/product_api.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
//  List<Product> productsList;

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  Future<ProductApi> futureProductApi;    // объект Future(), для асинхронного получения данных

  @override
  void initState() {
    super.initState();
//    futureProductApi = fetchProductApi();   // получаем ProductApi
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body:
          productListWidget()
      ),
    );
  }

  // метод для асинхронного получения данных, возвращает productApi
//  Future<ProductApi> fetchProductApi() async {
//    final response = await http.get(
//        'http://ostest.whitetigersoft.ru/api/common/product/list?appKey='
//        'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF');
////  await http.get('https://jsonplaceholder.typicode.com/albums/1');
//
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response, then parse the JSON.
//      return ProductApi.fromJson(json.decode(response.body));
//    } else {
//      // If the server did not return a 200 OK response, then throw an exception.
//      throw Exception('Failed to load album');
//    }
//  }
}
