import 'package:flutterapp/Api/base_api.dart';
import 'package:flutterapp/Products/product.dart';

class ProductApi extends BaseApi {
  static const String productRelativeUrl = '/common/product/list?';
  List<Product> productList;

  // Возвращает список продуктов
  Future<List<Product>> loadProducts(int categoryId) async {
    //TODO: make params
    // var params = {};
    Map<String, String> params = {};
    if (categoryId != null) {
      params["categoryId"] = categoryId.toString();
    }
    // TODO нужно исправить передаваеммые данные!
    var result = await sendGetResponse(productRelativeUrl + "categoryId=" + params["categoryId"] + "&", params);
    return parseProducts(result);
  }

  // Возвращает список продуктов
  List<Product> parseProducts(productsJson) {
    var list = productsJson['data'] as List;
    productList = list.map((data) => Product.fromJson(data)).toList();
    return productList;
  }
}
