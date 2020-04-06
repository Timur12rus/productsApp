import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category.dart';

class CategoryListViewItem extends StatelessWidget {
  Category category;

  CategoryListViewItem(BuildContext context, this.category, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _CategoryItemWidget(context, category));
  }
}

class _CategoryItemWidget extends StatelessWidget {
  Category category;

  _CategoryItemWidget(BuildContext context, this.category);

  @override
  Widget build(BuildContext context) {
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
            child: Text(category.title,
                style: TextStyle(
                  fontSize: 16,
                )),
          )
        ],
      ),
    );
  }
}
