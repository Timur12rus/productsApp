import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/category_api.dart';
import 'category.dart';
import 'category_list_view_item.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoriesScreen> {
  final CategoryApi categoryApi = CategoryApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: buildListView(context),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text('Categories'),
    );
  }

  Widget buildListView(BuildContext context) {
    return FutureBuilder(
      future: categoryApi.loadCatrgories(),
      builder: (context, categorySnap) {
        if (categorySnap.hasData) {
          return _buildListView(context, categorySnap.data);
        }
        if (categorySnap.hasError) {
          return Text("${categorySnap.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

Widget _buildListView(BuildContext context, List<Category> categories) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemCount: categories?.length ?? 0,
    itemBuilder: (context, index) {
      var category = categories[index];
      return CategoryListViewItem(category);
    },
  );
}
