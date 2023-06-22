

import 'dart:convert';

import 'package:http/http.dart';

import '../secret.dart';

class Config {
  static Future<String> getImagePath () async {
    String url = 'https://api.themoviedb.org/3/configuration?api_key=$myAuthKey';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    String base = data['images']['base_url'];
    String poster_size = data['images']['poster_sizes'][2];
    print('$base$poster_size');
    String path = '$base$poster_size';
    return path;
  }
}