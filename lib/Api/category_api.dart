import 'package:flutterapp/Api/base_api.dart';
import '../Catregories/category.dart';

class CategoryApi extends BaseApi {
  static const String categoryRelativeUrl = '/common/category/list?';
  List<Category> categoryList;

// возвращает список категорий
  Future<List<Category>> loadCatrgories() async {
    // ?? нужно объявить и задать тип Map<String, String> params
    // var params = {};
    Map<String, String> params = {};
    // ??? нужно ли передавать params, если он пустой, или лучше создать глобальную переменную
    // params в BaseApi, в которую будем добавлять записи (ключ-> значение)
    var result = await sendGetResponse(categoryRelativeUrl, params);   
    return parseCategories(result);
  }

   List<Category> parseCategories(parsedJson) {
    var data = parsedJson['data'];
    var list = data['categories'] as List;
    List<Category> categoryList =
        list.map((data) => Category.fromJson(data)).toList();
    return categoryList;
  }
}
