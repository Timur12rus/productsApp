class ProductApi {
  List<Product> products;

  ProductApi({this.products});

  factory ProductApi.fromJson(Map<String, dynamic> parsedJson) {
    return ProductApi(
    products: parseProducts(parsedJson)
    );
  }

  static List<Product> parseProducts(productsJson) {
    var list = productsJson['data'] as List;
    List<Product> productsList = list.map((data) => Product.fromJson(data)).toList();
    return productsList;
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
class Meta {
  bool success;
  String error;

  Meta({this.success, this.error});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(success: parsedJson['success'], error: parsedJson['error']);
  }
}
