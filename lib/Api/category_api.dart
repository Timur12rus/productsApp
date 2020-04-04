import 'package:flutterapp/Api/base_api.dart';
import '../Catregories/category.dart';

class CategoryApi extends BaseApi {
  static const String categoryStringUrl = '/common/category/list?';

  List<Category> parseCategories(parsedJson) {
    var data = parsedJson['data'];
    var list = data['categories'] as List;
    List<Category> categoryList =
        list.map((data) => Category.fromJson(data)).toList();
    return categoryList;
  }
}
