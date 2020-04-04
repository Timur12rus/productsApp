import 'package:flutter/material.dart';
import 'package:flutterapp/Catregories/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProductsApp',
      home: CategoriesScreen(),
    );
  }
}