import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:woodie/secret.dart';

import 'media.dart';

class MediaApi {
  static Future<List<Media>> getMedia(
      {required String path,
      String sortBy = 'popularity.desc',
      String query = ''}) async {
    final uri = Uri(
        scheme: 'http',
        host: 'api.themoviedb.org',
        path: path,
        queryParameters: {
          'include_adult': 'false',
          'include_video': 'true',
          'language': 'en-US',
          'page': '1',
          'sort_by': sortBy,
          'query': query.isEmpty ? null : query,
          'api_key': myAuthKey
        });
    print(uri);
    http.Response response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': myAccessToken
    });
    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['results']) {
      if (i['media_type'] != 'person') {
        _temp.add(i);
      }
    }
    print(_temp[0]);

    return Media.mediaFromSnapshot(_temp);
  }
}
