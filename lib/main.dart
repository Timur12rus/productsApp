import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/product_api.dart';
import 'package:http/http.dart' as http;

Future<ProductApi> fetchProductApi() async {
  final response =
  await http.get('http://ostest.whitetigersoft.ru/api/common/product/list?appKey='
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
//

//class Product {
//  int productId;
//  String title;
//  int price;
//
//  Product({this.productId});
////  Product({this.productId, this.title, this.price});
//
//  factory Product.fromJson(Map<String, dynamic> json) {
//    var productsFromJson = json['data'];
//    List<Product> productsList = new List<Product>.from(productsFromJson);
//    return productsList[1] = Product(productId: json['productId']);
////      (
////      productId: json['productId'],
////      title: json['title'],
////      price: json['price'],
////    );
//  }
//}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<ProductApi> futureProductApi;

  @override
  void initState() {
    super.initState();
    futureProductApi = fetchProductApi();
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
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<ProductApi>(
            future: futureProductApi,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.products[0].title);
//                return Text(snapshot.data.products.toString());
//                return Text(snapshot.data.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}