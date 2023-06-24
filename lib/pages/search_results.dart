import 'package:flutter/material.dart';
import 'package:woodie/model/media.dart';

import '../components/media_card.dart';

class SearchResults extends StatefulWidget {
  const SearchResults({Key? key}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late List<Media> _results;

  late Map data;

  @override
  Widget build(BuildContext context) {
    data = (ModalRoute.of(context)?.settings.arguments as Map);
    _results = data['results'];
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: orientation == Orientation.portrait ? 2:3), children: [
          ...List.generate(
              _results.length,
                  (index) => MediaCard(
                  movie: _results[index],
                  posterPath: data['poster_path'],
                  backdropPath: data['backdrop_path']))
        ],);
      }
    );
  }
}
