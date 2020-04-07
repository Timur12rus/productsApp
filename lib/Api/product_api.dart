import 'package:flutterapp/Api/base_api.dart';
import 'package:flutterapp/Products/product.dart';

class ProductApi extends BaseApi{
  String productStringUrl = '/common/product/list?';
  String categoryIdString = '&categoryId=';

  // Возвращает список продуктов
  List<Product> parseProducts(productsJson) {
    var list = productsJson['data'] as List;
    List<Product> productList =
    list.map((data) => Product.fromJson(data)).toList();
    return productList;
  }
}
