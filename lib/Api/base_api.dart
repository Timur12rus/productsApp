import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseApi {
  String responseUrl;

  static const String baseApiURL = 'http://ostest.whitetigersoft.ru/api';
  static const String appKeyString =
      'phynMLgDkiG06cECKA3LJATNiUZ1ijs-eNhTf0IGq4mSpJF3bD42MjPUjWwj7sqLuPy4_nBCOyX3-fRiUl6rnoCjQ0vYyKb-LR03x9kYGq53IBQ5SrN8G1jSQjUDplXF';

  Future<dynamic> sendGetResponse(
      String relativeUrl, Map<String, String> params) async {
    params ??= {};
    params['appKey'] = appKeyString;
    params['baseApiUrl'] = baseApiURL;

    //TODO: send request. User Uri.http && http.get
    responseUrl = params['baseApiUrl'] + relativeUrl + 'appKey=' + params['appKey'];
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

// TODO создать метод, к котром будет собираться ссылка и создаваться относительный url
// для вызова ф-ии sendGetResponse(....)
