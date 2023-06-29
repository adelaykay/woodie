import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Woodie/model/movie_details.dart';
import 'package:Woodie/model/tv_details.dart';
import 'package:Woodie/secret.dart';

class MovieDetailsApi {
  static Future<Object> getMovieDetails({required String mediaType, required String path}) async {
    final uri = Uri(
        scheme: 'http',
        host: 'api.themoviedb.org',
        path: path,
        queryParameters: {
          'append_to_response': 'videos,similar,credits',
          'api_key': tmdbAuthKey
        });
    http.Response response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': tmdbAccessToken
    });
    Map<String,dynamic> data = jsonDecode(response.body);

    if(mediaType=='movie'){
      return MovieDetails.mediaFromSnapshot(data, mediaType);
    } else if(mediaType=='tv'){
      return TvDetails.mediaFromSnapshot(data, mediaType);
    } else {
      return Exception('Unable to return tv or movie details');
    }
  }
}
