import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static const String categoryApiURL =
      'http://ostest.whitetigersoft.ru/api/common/category/list?appKey='
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';

  Data data;
  CategoryApi({this.data});

//  factory CategoryApi.fromJson(Map<String, dynamic> parsedJson) {
//      return CategoryApi(data: parseData(parsedJson));
//  }
//


//  //TODO нужно исправить чтобы парсить объект дата со списком категорий !!!!!
//  static List<Category> parseData(dataJson) {
////    var list = categoriesJson['categories'];
//
//    var list = dataJson['data'] as List;
//    List<Category> categoriesList =
//    list.map((data) => Category.fromJson(data)).toList();
//    return categoriesList;
//  }
}

class Data{
  List<Category> categories;

  Data({this.categories});

//  factory Data.fromJson(List<dynamic> parsedJson) {
  factory Data.fromJson(Map<String, dynamic> parsedJson) {
//    var list = parsedJson['categories'] as List;

      List<Category> categoriesList = new List<Category>();

    var list = parsedJson['categories'] as List;
//    print(list.runtimeType); //returns List<dynamic>

//    List<Category> categoriesList = list.map((data) => Category.fromJson(data)).toList();

    categoriesList = list.map((data) => Category.fromJson(data)).toList();

//    List<Category> categories = new List<Category>();
    return Data(categories: categoriesList);
  }
}

class Category {
  int categoryId;
  String title;
  String imageUrl;
  String fullName;

  Category({this.categoryId, this.title, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
        categoryId: parsedJson['categoryId'],
        title: parsedJson['title'],
        imageUrl: parsedJson['imageUrl']);
  }
}

/** Виджет - список сущностей Product **/
class ListViewCategories extends StatelessWidget {
  ListViewCategories({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
//      future: fetchCategoryApi(),
      builder: (context, categorySnap) {
        if (categorySnap.hasData) {
          return ListView.builder(
            //TODO: нужно сделать так, чтобы itemCount = products.length(), сейчас выдает null, нужно исправить!!!!
            itemCount: 3,
            itemBuilder: (context, index) {
              Data data = categorySnap.data;
              List<Category> categoriesList = data.categories;
              return new CategoryBox(
                  categoriesList[index].categoryId, categoriesList[index].title,
                  categoriesList[index].imageUrl);
            },
          );
        } else if (categorySnap.hasError) {
          return Text("${categorySnap.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

// метод для асинхронного получения данных, возвращает ProductApi()
Future<Data> fetchData() async {
//Future<Data> fetchData() async {
//Future<CategoryApi> fetchCategoryApi() async {
  final response = await http.get(CategoryApi.categoryApiURL);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Data.fromJson(json.decode(response.body));
//    return CategoryApi.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Products');
  }
}

class CategoryBox extends StatelessWidget {
  final int _categoryId;
  final String _title;
  String _imageUrl;

  CategoryBox(this._categoryId, this._title, this._imageUrl);


  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.black12,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        height: 100.0,
        child: new Row(children: [
          new Image.network(
            _imageUrl, width: 100.0, height: 100.0, fit: BoxFit.cover,),
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
                      'Id: $_categoryId',
//                  textAlign: TextAlign.start,
                    ) //виджету текста
                  ]))
          )
        ]));
  }
}
