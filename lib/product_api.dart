class ProductApi {
//  Meta meta;
//  ProductList productList;
  List<Product> products;

  ProductApi({this.products});

//  ProductApi({this.productList});

  factory ProductApi.fromJson(Map<String, dynamic> parsedJson) {
//    var productsFromJson = parsedJson['data'];
//    List<Product> productsList = productsFromJson.cast<String>();
//    List<Product> productsList = productsFromJson.cast<String>();
    return ProductApi(
//      products: productsList,
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

//class ProductList {
//  List<Product> products;
//
//  ProductList({this.products});
//
//  factory ProductList.fromJson(Map<String, dynamic> parsedJson) {
//    List<Product> products = new List<Product>();
//    products = parsedJson.map((i) => Product.fromJson(i)).toList();
//
//    return new ProductList(products: products);
//  }
//}

class Meta {
  bool success;
  String error;

  Meta({this.success, this.error});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(success: parsedJson['success'], error: parsedJson['error']);
  }
}
