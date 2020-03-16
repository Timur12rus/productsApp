import 'package:flutter/material.dart';
import 'package:flutterapp/product_api.dart';

import 'category_api.dart';

//void main() => runApp(new MaterialApp(
//  home: new Scaffold(
//  appBar: new AppBar(),
//    body:new ProductBox('Урок по Flutter', 10)
//  ))
//);

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
        ListViewCategories()
//          ListViewProducts()
      ),
    );
  }
}
