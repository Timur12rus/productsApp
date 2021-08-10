import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Products/products_screen.dart';

import 'category.dart';

class CategoryListViewItem extends StatelessWidget {
  final Category category;

  CategoryListViewItem(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _CategoryItemWidget(context, category),
    );
  }

  Widget _CategoryItemWidget(BuildContext context, Category category) {
    return GestureDetector(
      onTap: () {
        var productCategoryId = category.categoryId;
        Navigator.push(
          context,
          MaterialPageRoute(
            // возможно нужно передать в конструктор объект category
              builder: (context) => ProductsScreen(
                    categoryTitle: category.title,
                    categoryId: productCategoryId,
                  )),
        );
      },
      child: _buildItem(category),
    );
  }

  Widget _buildItem(Category category) {
    return Center(
      child: Column(
        children: <Widget>[
          Image.network(
            category.imageUrl,
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            color: Colors.blueGrey,
            child: Text(
              category.title,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
