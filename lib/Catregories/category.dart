import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category_api.dart';

class Category {
  int categoryId;
  String title;
  String imageUrl;

  Category({
    this.categoryId,
    this.title,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
        categoryId: parsedJson['categoryId'],
        title: parsedJson['title'],
        imageUrl: parsedJson['imageUrl']);
  }

  // Возвращает список категорий
  static List<Category> parseCategories(parsedJson) {
    var data = parsedJson['data'];
    var list = data['categories'] as List;

    List<Category> categoryList =
        list.map((data) => Category.fromJson(data)).toList();
    return categoryList;
  }
}

Future<List<Category>> loadCategoryList() async {
  final response = await http.get(CategoryApi.categoryApiURL);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Category.parseCategories(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Products');
  }
}

/** Виджет - список сущностей Category **/
class ListViewCategories extends StatelessWidget {
  ListViewCategories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadCategoryList(),
      builder: (context, categorySnap) {
        if (categorySnap.hasData) {
          List<Category> categories = categorySnap.data;
          return ListView.builder(
            //TODO: нужно сделать так, чтобы itemCount = products.length(), сейчас выдает null, нужно исправить!!!!
            itemCount: categories?.length ?? 0,
            itemBuilder: (context, index) {
              var category = categorySnap.data[index];
              return _buildListItem(context, category);
            },
          );
        } else if (categorySnap.hasError) {
          return Text("${categorySnap.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildListItem(BuildContext context, Category category) {
    return ListTile(
      leading: Image.network(
        category.imageUrl,
        width: 100.0,
        height: 100.0,
        fit: BoxFit.cover,
      ),
      title: Text('${category.title}'),
      subtitle: Text('categoryId: ${category.categoryId}'),
    );
  }
}
