import 'package:flutter/material.dart';
import 'package:flutterapp/product.dart';
import 'package:flutterapp/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: Strings.appTitle, home: ProductApp());
  }
}


class ProductApp extends StatefulWidget {
  @override
  State createState() => ProductAppState();
}

var _products = <Product>[];
var _data = []; // массив data в JSON-запросе

final _biggerFont = const TextStyle (fontSize: 18.0);

_loadData() async {
  String dataURL = "https://api.github.com/orgs/raywenderlich/members";
  http.Response response = await http.get(dataURL);
  /** Когда HTTP-вызов завершается, передаём обратный вызов setState(),
   * который выполняется синхронно в потоке пользовательского интерфейса
   * В нашем случае декодируем ответ JSON и присваеваем его списку _members
   */
  setState(() {
    _data = json.decode(response.body);
    _products = _data[1];
//    _products = _data[1];
  });
}

class ProductAppState extends State<ProductApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.appTitle),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int position) {
              return _buildRow(position);
            })
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  /**Возваращает виджет ListTile, который показывает значение «login»,
   *  проанализированное из JSON для i-го члена, а также использует текстовый стиль, который создали ранее.
   **/
  Widget _buildRow(int i) {
    return ListTile(
        title: Text("${_products[i]["productId"]}", style: _biggerFont));
  }
}
