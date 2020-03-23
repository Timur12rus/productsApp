class Product {
  int productId;
  String title;
  String productDescription;
  int price;
  String rating;
  String imageUrl;
  int categoryId;

  Product({this.productId, this.title, this.price, this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        productId: parsedJson['productId'],
        title: parsedJson['title'],
        price: parsedJson['price'],
        imageUrl: parsedJson['imageUrl']);
  }
}
