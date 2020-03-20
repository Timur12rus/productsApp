import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'categories_list.dart';

class CategoriesScreen extends StatefulWidget {

  CategoriesScreen({Key key}) : super(key: key);

  @override
  _categoriesScreenState createState() => _categoriesScreenState();
}

class _categoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Categories Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Categories'),
          ),
          body:
          ListViewCategories()
//          ListViewProducts()
      ),
    );
  }
}