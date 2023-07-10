import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Woodie/secret.dart';

import '../model/media.dart';

class MediaApi {
  // Find movies using over 30 filters and sort options.
  // sortBy - popularity.desc, revenue.desc, primary_release_date.desc
  //          vote_average.desc, vote_count.desc
  static Future<List<Media>> getMedia(
      {required String path, required String mediaType,
      String sortBy = 'popularity.desc',
      String query = '', String genre = '', String country = ''}) async {
    final uri = Uri(
        scheme: 'http',
        host: 'api.themoviedb.org',
        path: path,

        queryParameters: {
          'include_adult': 'false',
          'include_video': 'false',
          'language': 'en-US',
          'page': '1',
          'sort_by': sortBy,
          'query': query.isEmpty ? null : query,
          'with_genres': genre.isEmpty ? null : genre,
          if(country.isNotEmpty) 'with_origin_country': country,
          'api_key': tmdbAuthKey
        });
    http.Response response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': tmdbAccessToken
    });
    Map data = jsonDecode(response.body);
    print(data);
    List _temp = [];

    for (var i in data['results']) {
      if (i['media_type'] != 'person') {
        _temp.add(i);
      }
    }

    return Media.mediaFromSnapshot(_temp, mediaType);
  }
}
