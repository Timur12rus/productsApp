import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Api/product_api.dart';
import 'package:flutterapp/Products/product.dart';

class ProductsScreen extends StatelessWidget {
  ProductApi productApi;
  final int categoryId;

  ProductsScreen({Key key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productApi = ProductApi();
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Center(
          child: ProductListView(productApi, categoryId)),
    );
  }
}

class ProductListView extends StatefulWidget {
  ProductApi productApi;
  int categoryId;

  ProductListView(this.productApi, this.categoryId, {Key key}) : super(key: key);
  @override
  _ProductListViewState createState() => _ProductListViewState(productApi, categoryId);
}

class _ProductListViewState extends State<ProductListView> {
  ProductApi productApi;
  int categoryId;

  _ProductListViewState(this.productApi, this.categoryId);

  @override
  Widget build(BuildContext context) {
    print('categoryId = ' + '${categoryId}');
    return FutureBuilder(
      future: productApi.loadJsonData(ProductApi.productStringUrl, ProductApi.categoryIdString + '${categoryId}'),
      builder: (context, productSnap) {
        if (productSnap.hasData) {
          List<Product> products = productApi.parseProducts(productSnap.data);
          return _productListViewBuilder(products);
        }
        if (productSnap.hasError) {
          return Text("${productSnap.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Widget _productListViewBuilder(List<Product> products) {
  return ListView.builder(
    itemCount: products?.length ?? 0,
    itemBuilder: (context, index) {
      var product = products[index];
      return _buildListItem(context, product);
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
