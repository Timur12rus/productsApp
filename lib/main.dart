import 'package:flutter/material.dart';
import 'Catregories/category.dart';
import 'Catregories/category_list.dart';

void main() => runApp(MyApp());
class MyApp extends StatefulWidget {

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body:
        ListViewCategories()
//          ListViewProducts()
      ),
    );
  }
}
