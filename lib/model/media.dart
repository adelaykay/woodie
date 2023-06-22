class Media {
  final int id;
  final double rating;
  final String title, overview, language, poster_path, backdrop_path, year;

  Media(
      {required this.id,
      required this.rating,
      required this.title,
      required this.overview,
      required this.language,
      required this.poster_path,
      required this.backdrop_path,
      required this.year});

}
// demo movies
List<Media> demoMovies = [
  Media(id: 385687, rating: 7.3, title: 'Fast X', overview: "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.", language: 'en', poster_path: "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg", backdrop_path: "/6l1SV3CWkbbe0DcAK1lyOG8aZ4K.jpg", year: '2023'),
  Media(id: 603692, rating: 7.9, title: 'John Wick: Chapter 4', overview: "With the price on his head ever increasing, John Wick uncovers a path to defeating The High Table. But before he can earn his freedom, Wick must face off against a new enemy with powerful alliances across the globe and forces that turn old friends into foes.", language: 'en', poster_path: "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg", backdrop_path: "/1inZm0xxXrpRfN0LxwE2TXzyLN6.jpg", year: '2023'),
  Media(id: 502356, rating: 7.8, title: "The Super Mario Bros. Movie", overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.", language: 'en', poster_path: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg", backdrop_path: "/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg", year: '2023'),
  Media(id: 569094, rating: 8.7, title: "Spider-Man: Across the Spider-Verse", overview: "After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.", language: 'en', poster_path: "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg", backdrop_path: "/nGxUxi3PfXDRm7Vg95VBNgNM8yc.jpg", year: '2023'),
  Media(id: 667538, rating: 7.3, title: "Transformers: Rise of the Beasts", overview: "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth.", language: 'en', poster_path: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg", backdrop_path: "/9NgtktUFLm9cnFDFaekx2ROh84f.jpg", year: '2023')
];
