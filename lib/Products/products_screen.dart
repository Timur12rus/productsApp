import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Catregories/categories_list.dart';
import 'package:flutterapp/Products/product_list.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;

  /// добавил в коснтруктор экрана списка продуктов categoryId, чтобы потом передать его в список товаров(ListView),
  /// для отображения товаров выбранной категории
  ProductsScreen({Key key, @required this.categoryId}) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Products'),
          ),
          body:
//          ListViewCategories()
              ListViewProducts(widget.categoryId)),
    );
  }
}
