import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApi {
  static const String baseApiURL = 'http://ostest.whitetigersoft.ru/api';
  static const String apiKey =
      'appKey=phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';

// Future для получения Json
  Future loadJsonData(String stringUrl, String param) async {
    String responseUrl = baseApiURL + stringUrl + apiKey + param;
    final response = await http.get(responseUrl);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load Products');
    }
  }
}



