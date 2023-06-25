import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:woodie/model/movie_details.dart';
import 'package:woodie/secret.dart';

class MovieDetailsApi {
  static Future<MovieDetails> getMovieDetails({required String path}) async {
    final uri = Uri(
        scheme: 'http',
        host: 'api.themoviedb.org',
        path: path,
        queryParameters: {
          'append_to_response': 'videos,similar,credits',
          'api_key': myAuthKey
        });
    print(uri);
    http.Response response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': myAccessToken
    });
    Map<String,dynamic> data = jsonDecode(response.body);

    return MovieDetails.mediaFromSnapshot(data);
  }
}
