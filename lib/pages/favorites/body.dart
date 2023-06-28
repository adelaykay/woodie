import 'package:flutter/material.dart';
import 'package:Woodie/components/config.dart';
import 'package:Woodie/components/media_card.dart';

import '../../model/media.dart';
import '../../services/favorites_service.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = true;
  late List<dynamic> _favorites = [];
  var imageUrl;
  var posterPath;
  var backdropPath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavorites();
  }

  Future<void> getFavorites () async {
    Future.wait([FavoritesService.getData(), Config.getImagePath()]).then((List response) {
      _favorites = response[0];
      imageUrl = response[1];
      posterPath = imageUrl['posterPath'];
      setState(() {
        _isLoading = false;
      });
      print(_favorites[0]);
    }).catchError((e)=> print(e));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
      child: CircularProgressIndicator()
    )
        : _favorites.isNotEmpty ? OrientationBuilder(builder: (context, orientation) {
      return GridView(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
        children: _favorites.map((e) => MediaCard(movie: e, posterPath: e.poster, backdropPath: '')).toList()
        );
    }) : Center(child: Text('You currently have no favorites, add content to favorites to view them here'),);
  }
}
