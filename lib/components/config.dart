import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../secret.dart';

class Config {
  static Future<Map<String, String>> getImagePath(double screenWidth) async {
    int pw = screenWidth < 350 ? 2 : 3;
    int bw = screenWidth < 350 ? 3 : 4;
    String url =
        'https://api.themoviedb.org/3/configuration?api_key=$myAuthKey';
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    String base = data['images']['base_url'];
    String posterSize = data['images']['poster_sizes'][3];
    String backdropSize = data['images']['poster_sizes'][4];
    print('$base$posterSize');
    String posterPath = '$base$posterSize';
    String backdropPath = '$base$backdropSize';
    return {'backdropPath': backdropPath, 'posterPath': posterPath};
  }
}
