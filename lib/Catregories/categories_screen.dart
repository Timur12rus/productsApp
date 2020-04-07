import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import '../Api/category_api.dart';
import 'category_list_view_item.dart';

class CategoriesScreen extends StatelessWidget {
  CategoryApi categoryApi;
  CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    categoryApi = CategoryApi();
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Center(child: CategoryListView(categoryApi)),
    );
  }
}

/** Виджет - список сущностей Category **/
class CategoryListView extends StatefulWidget {
  CategoryApi categoryApi;
  CategoryListView(this.categoryApi, {Key key}) : super(key: key);

  @override
  _CategoryListViewState createState() => _CategoryListViewState(categoryApi);
}

class _CategoryListViewState extends State<CategoryListView> {
  CategoryApi categoryApi;
  _CategoryListViewState(this.categoryApi);

  @override
  Widget build(BuildContext context) {
    print('build Category List');
    return FutureBuilder(
      future: categoryApi.loadJsonData(CategoryApi.categoryStringUrl, ''),
      builder: (context, categorySnap) {
        if (categorySnap.hasData) {
          List<Category> categories =
              categoryApi.parseCategories(categorySnap.data);
          return _categoryListViewBuilder(categories);
        }
        if (categorySnap.hasError) {
          return Text("${categorySnap.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

Widget _categoryListViewBuilder(List<Category> categories) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemCount: categories?.length ?? 0,
    itemBuilder: (context, index) {
      var category = categories[index];
      return CategoryListViewItem(context, category);
    },
  );
}
