class ScreenArguments {

  final int id;
  final double? rating;
  final String? title;
  final String? year;
  final String? overview;
  final String? backdrop;

  ScreenArguments(
      {required this.id,
      required this.rating,
      required this.title,
      required this.year,
      required this.overview,
      required this.backdrop});
}