import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Api/product_api.dart';
import 'package:flutterapp/Products/product.dart';
import 'package:flutterapp/Products/product_list_view_item.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryTitle;

  ProductsScreen({
    Key key,
    this.categoryTitle,
    this.categoryId,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final ProductApi productApi = ProductApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: buildListView(context),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.categoryTitle),
    );
  }

  Widget buildListView(BuildContext context) {
    return FutureBuilder(
      future: productApi.loadProducts(widget.categoryId),
      builder: (context, productSnap) {
        if (productSnap.hasData) {
          return _buildListView(productSnap.data);
        }
        if (productSnap.hasError) {
          return Text("${productSnap.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget _buildListView(List<Product> products) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemCount: products?.length ?? 0,
    itemBuilder: (context, index) {
      var product = products[index];
      return ProductListViewItem(product);
    },
  );
}
