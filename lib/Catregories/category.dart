import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'category_api.dart';

class Category {
  int categoryId;
  String title;
  String imageUrl;

  Category({
    this.categoryId,
    this.title,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> parsedJson) {
    return Category(
        categoryId: parsedJson['categoryId'],
        title: parsedJson['title'],
        imageUrl: parsedJson['imageUrl']);
  }
}
