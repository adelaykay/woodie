class Media {
  final int id;
  final double? rating;
  final String mediaType;
  final String? title, poster, backdrop, year;

  Media(
      {required this.id,
      required this.rating,
      required this.title,
      required this.poster,
      required this.backdrop,
      required this.year,
      required this.mediaType});

  factory Media.fromJson(dynamic json, String mediaType) {
    return Media(
        id: json['id'] as int,
        rating: json['vote_average'] == null
            ? 0.0
            : double.parse(json['vote_average'].toDouble().toStringAsFixed(1)),
        title: getTitle(json),
        poster:
            json['poster_path'] == null ? '' : json['poster_path'].toString(),
        backdrop: json['backdrop_path'] == null
            ? ''
            : json['backdrop_path'].toString(),
        year: getYear(json),
      mediaType: getMediaType(json, mediaType),
    );
  }

  static getMediaType(dynamic json, String mediaType){
    if(mediaType == '') {
      return json['media_type'].toString();
    }
    return mediaType;
  }

  static String? getTitle(Map a) {
    if (a['title'] != null) {
      return a['title'].toString();
    } else if (a['name'] != null) {
      return a['name'].toString();
    } else {
      return '';
    }
  }

  static String? getYear(Map a){
    if(a['release_date'] != null){
      if(a['release_date'].isNotEmpty) return a['release_date'].toString().substring(0,4);
    } else if(a['first_air_date'] != null){
      if(a['first_air_date'].isNotEmpty) return a['first_air_date'].toString().substring(0,4);
    } else {
      return '';
    }
    return null;
  }

  static List<Media> mediaFromSnapshot(List snapshot, String mediaType) {
    return snapshot.map((data) {
      return Media.fromJson(data, mediaType);
    }).toList();
  }
}

// demo movies
// List<Media> demoMovies = [
//   Media(
//       id: 385687,
//       rating: 7.3,
//       title: 'Fast X',
//       overview:
//           "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.",
//
//       poster: "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg",
//       backdrop: "/6l1SV3CWkbbe0DcAK1lyOG8aZ4K.jpg",
//       year: '2023'),
//   Media(
//       id: 603692,
//       rating: 7.9,
//       title: 'John Wick: Chapter 4',
//       overview:
//           "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.",
//
//       poster: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg",
//       backdrop: "/1inZm0xxXrpRfN0LxwE2TXzyLN6.jpg",
//       year: '2023'),
//   Media(
//       id: 502356,
//       rating: 7.8,
//       title: "The Super Mario Bros. Movie",
//       overview:
//           "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
//
//       poster: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
//       backdrop: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg",
//       year: '2023'),
//   Media(
//       id: 569094,
//       rating: 8.7,
//       title: "Spider-Man: Across the Spider-Verse",
//       overview:
//           "After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.",
//
//       poster: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg",
//       backdrop: "/nGxUxi3PfXDRm7Vg95VBNgNM8yc.jpg",
//       year: '2023'),
//   Media(
//       id: 667538,
//       rating: 7.3,
//       title: "Transformers: Rise of the Beasts",
//       overview:
//           "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.",
//
//       poster: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg",
//       backdrop: "/9NgtktUFLm9cnFDFaekx2ROh84f.jpg",
//       year: '2023')
// ];
// // demo TV shows
// List<Media> demoTV = [
//   Media(
//       id: 217216,
//       rating: 10.0,
//       title: "Flor Sem Tempo",
//       overview: "",
//
//       poster: "/bclnfDXvx7UydFSk83B258vRRvI.jpg",
//       backdrop: "/5MkBAawsj7O9zitVtzMXagyrIBw.jpg",
//       year: '2023'),
//   Media(
//       id: 216390,
//       rating: 3.6,
//       title: "Woman in a Veil",
//       overview:
//           "Jung Gyul Wool loses her vision and ability to walk because of her materialistic husband and his mistress. Despite her shortcomings, she hatches a plot to seek revenge.",
//
//       poster: "/5ERr09UrnVm0hdXBeefNVtQMxI.jpg",
//       backdrop: "/lcSvkJ2Rob3ICIOCUJahw3kgSYZ.jpg",
//       year: '2023'),
//   Media(
//       id: 209117,
//       rating: 7.5,
//       title: "Never Give Up",
//       overview:
//           "Sol is a hardworking woman who has the chance to work as a backing vocalist for a funk singer and return to dancing, as she did in her youth. Torn between family pressure and passion for the stage, she must face the judgment of her church's members and conflicts with her family. The new chance will make her reconnect with her past in many ways, leading her to find her great youth love.",
//
//       poster: "/6QNohzb7YUJ6eWZkXAYU8KGIq.jpg",
//       backdrop: "/xYiI6QEZvx8Z4La1oHvApyZHpOU.jpg",
//       year: '2023')
// ];
