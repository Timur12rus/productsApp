import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static const String productsApiURL =
      'http://ostest.whitetigersoft.ru/api/common/product/list?appKey='
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';
  List<Product> products;
  ProductApi({this.products});

  factory ProductApi.fromJson(Map<String, dynamic> parsedJson) {
    return ProductApi(products: parseProducts(parsedJson));
  }

  // Возвращает список продуктов
  static List<Product> parseProducts(productsJson) {
    var list = productsJson['data'] as List;
    List<Product> productList =
        list.map((data) => Product.fromJson(data)).toList();
    return productList;
  }
}

class Product {
  int productId;
  String title;
  String productDescription;
  int price;
  String rating;
  String imageUrl;

  Product({this.productId, this.title, this.price, this.imageUrl});

  factory Product.fromJson(Map<String, dynamic> parsedJson) {
    return Product(
        productId: parsedJson['productId'],
        title: parsedJson['title'],
        price: parsedJson['price'],
        imageUrl:parsedJson['imageUrl']);
  }
}

/** Виджет - список сущностей Product **/
class ListViewProducts extends StatelessWidget {
//  Future<ProductApi> futureProductApi;
//  futureProductApi = fetchProductApi();

//  List<Product> products;
  ListViewProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProductApi(),
      builder: (context, productSnap) {
        if (productSnap.hasData) {
          return ListView.builder(
            //TODO: нужно сделать так, чтобы itemCount = products.length(), сейчас выдает null, нужно исправить!!!!
            itemCount: 14,
            itemBuilder: (context, index) {
              ProductApi productApi = productSnap.data;
              List<Product> productList = productApi.products;
              return new ProductBox(
                  productList[index].title, productList[index].price, productList[index].imageUrl);
            },
          );

          return ListTile(
//
//                title: Text('${productList[index].title}'),
//                subtitle: Text('price: ${productList[index].price}'),
//                subtitle: Text('productId: ${productList[index].productId} \nprice: ${productList[index].price}'),
          );
        } else if (productSnap.hasError) {
          return Text("${productSnap.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

// метод для асинхронного получения данных, возвращает ProductApi()
Future<ProductApi> fetchProductApi() async {
  final response = await http.get(ProductApi.productsApiURL);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return ProductApi.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Products');
  }
}

class ProductBox extends StatelessWidget {
  final String _title;
//  final String _text;
  final int _price;
  String _imageUrl;

  ProductBox(this._title, this._price, this._imageUrl) {
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color:Colors.black12,
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        height: 100.0,
        child: new Row(children: [
          new Image.network(_imageUrl, width: 100.0, height: 100.0, fit: BoxFit.cover,),
          new Expanded(
              // используется для ограничения размеров дочерних виджетов,
              // без него виджет Column может иметь безграничные размеры и выходить за края экрана,
              // виджет Expanded обрежет все то что не войдет по высоте.
              child: new Container(
//              alignment:
                  padding: new EdgeInsets.all(5.0),
                  //со свойством padding создает внутри контейнера отступы,
                  // таким образом текст не будет впритык к изображению или краям экрана.
                  child: new Column(children: <Widget>[
                    new Text(
                      //для заголовка мы применили стиль с увеличенным размером
                      _title,
                      softWrap: true,
                      // мы применили перенос текста с помощью параметра softWrap,
                      style: new TextStyle(fontSize: 14.0),
//            textAlign: TextAlign.start, // добавили выравнивание текста по ширине, в случае слишком длинного текста,
                      overflow: TextOverflow
                          .ellipsis, // свойство overflow которое позволяет обрезать слишком длинный текст
                    ),
                    new Text(
                      'Price: $_price',
//                  textAlign: TextAlign.start,
                    ) //виджету текста
                  ]))
          )
        ]));
  }
}

class Meta {
  bool success;
  String error;

  Meta({this.success, this.error});

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(success: parsedJson['success'], error: parsedJson['error']);
  }
}
