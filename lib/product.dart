class Product {
  int productId;
  String title;
  String productDescription;
  int price;
  String rating;

//  Product(this.productId, this.title, this.productDescription, this.price,
//      this.rating);
  Product({this.productId, this.title, this.price});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        productId: parsedJson['productId'],
        title: parsedJson['title'],
        price: parsedJson['price']);
  }
}
//  Product(this.productId, this.title, this.productDescription, this.price,
//      this.rating);
