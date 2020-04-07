import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Products/product.dart';

class ProductListViewItem extends StatelessWidget {
  Product product;
  int categoryId;

  ProductListViewItem(BuildContext context, this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _itemWidget(product),
    );
  }
}

Widget _itemWidget(Product product) {
  return Center(
    child: Column(
      children: <Widget>[
        Image.network(
          product.imageUrl,
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          color: Colors.blueGrey,
          child: Text(product.title,
              style: TextStyle(
                fontSize: 16,
              )),
        )
      ],
    ),
  );
}