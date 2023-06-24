import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:woodie/secret.dart';

import 'media.dart';

class MediaApi {

  static Future<List<Media>> getMedia(String type) async {
    final uri = Uri(
      scheme: 'http',
      host: 'api.themoviedb.org',
      path: '/3/discover/$type',
      queryParameters: {
        'include_adult': 'false',
        'include_video': 'false',
        'language': 'en-US',
        'page': '1',
        'sort_by': 'popularity.desc',
        'api_key': myAuthKey
      }
    );
    print(uri);
    http.Response response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': myAccessToken
    });
    Map data = jsonDecode(response.body);
    List _temp = [];

    for(var i in data['results']){
      _temp.add(i);
    }
    print(_temp[0]);

    return Media.mediaFromSnapshot(_temp);
  }
}