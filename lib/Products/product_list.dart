import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Products/product.dart';
import 'package:flutterapp/Products/product_api.dart';
import 'package:http/http.dart' as http;

class ProductList {
  // Возвращает список продуктов
  static List<Product> parseProducts(productsJson) {
    var list = productsJson['data'] as List;
    List<Product> productList =
        list.map((data) => Product.fromJson(data)).toList();
    return productList;
  }
}

Future<List<Product>> loadProductList() async {
  final response = await http.get(ProductApi.productsApiURL);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return ProductList.parseProducts(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Products');
  }
}

/** Виджет - список сущностей Product **/
class ListViewProducts extends StatelessWidget {
  ListViewProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadProductList(),
      builder: (context, productSnap) {
        if (productSnap.hasData) {
          List<Product> products = productSnap.data;
          return ListView.builder(
            itemCount: products?.length ?? 0,
            itemBuilder: (context, index) {
              var product = productSnap.data[index];
              return _buildListItem(context, product);
            },
          );
        } else if (productSnap.hasError) {
          return Text("${productSnap.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildListItem(BuildContext context, Product product) {
    return ListTile(
      leading: Image.network(
        product.imageUrl,
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      title: Text('${product.title}'),
      subtitle:
          Text('productId: ${product.productId} \nprice: ${product.price}'),
    );
  }
}
