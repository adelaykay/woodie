import 'media.dart';

class TvDetails {
  final int? id, cznCount;
  final double? rating;
  final String? title, overview, language, year;
  final List<String>? genre;
  final List<Person>? cast;
  final List<Media>? similar;
  final List<String> videosList;

  TvDetails({
    required this.id,
    this.similar,
    this.rating,
    this.title,
    this.overview,
    this.language,
    this.year,
    this.genre,
    this.cast,
    this.cznCount,
    required this.videosList
  });

  factory TvDetails.fromJson(Map<String, dynamic> json, String mediaType) {
    return TvDetails(
        rating: json['vote_average'] == null
            ? 0.0
            : double.parse(json['vote_average'].toDouble().toStringAsFixed(1)),
        title: getTitle(json),
        overview: json['overview'] == null ? '' : json['overview'].toString(),
        year: getYear(json),
        id: json['id'] == null ? 0 : json['id'] as int,
        genre: json['genres'] == null ? [] : getGenre(json['genres']),
        cast: json['credits'] == null ? [] : getCast(json['credits']['cast']),
        similar: json['similar'] == null
            ? []
            : getSimilar(json['similar']['results'], mediaType),
      cznCount: json['number_of_seasons'] as int,
      videosList: getVideosList(json['videos']['results'] as List)
    );
  }

  static String? getTitle(Map data) {
    if (data['name'] != null) {
      return data['name'].toString();
    } else {
      return '';
    }
  }

  static List<String> getVideosList(List<dynamic> list){
    List<String> vList = [];
    if(list.isNotEmpty) {
      for (var video in list) {
        vList.add(video['key'] as String);
      }
    }
    print(vList);
    return vList;
  }

  static List<String>? getGenre(List<dynamic> g) {
    List<String> gens = [];

    for (var i in g) {
      gens.add(i['name'] as String);
    }
    return gens;
  }

  static String? getYear(Map a) {
    if (a['release_date'] != null) {
      if (a['release_date'].isNotEmpty) {
        return a['release_date'].toString().substring(0, 4);
      }
    } else if (a['first_air_date'] != null) {
      return a['first_air_date'].toString().substring(0, 4);
    } else {
      return '';
    }
    return null;
  }

  static List<Person> getCast(List<dynamic> c) {
    List<Person> cast = [];

    for (var e in c) {
      Person person = Person(e['name'], e['profile_path'], e['character']);
      cast.add(person);
    }
    return cast;
  }

  static List<Media>? getSimilar(List<dynamic> s, String mediaType) {
    List<Media>? sim = [];

    String? getYear(Map a) {
      if (a['release_date'] != null) {
        if (a['release_date'].isNotEmpty)
          return a['release_date'].toString().substring(0, 4);
      } else if (a['first_air_date'] != null) {
        if (a['first_air_date'].isNotEmpty)
          return a['first_air_date'].toString().substring(0, 4);
      } else {
        return '';
      }
      return null;
    }

    for (var e in s) {
      Media media = Media(
          id: e['id'] == null ? 0 : e['id'] as int,
          rating: e['vote_average'] ?? 0.0,
          title: e['title'] ?? '',
          poster: e['poster_path'] ?? '',
          backdrop: e['backdrop_path'] ?? '',
          year: getYear(e),
          mediaType: mediaType);
      sim.add(media);
    }

    return sim;
  }

  static TvDetails mediaFromSnapshot(
      Map<String, dynamic> snapshot, String mediaType) {
    return TvDetails.fromJson(snapshot, mediaType);
  }
}

class Person {
  final String? name;
  final String? profile_pic;
  final String? character;

  Person(this.name, this.profile_pic, this.character);
}
