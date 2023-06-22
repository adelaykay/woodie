import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/media.dart';
import '../pages/media_details.dart';
import 'config.dart';

class MediaCard extends StatefulWidget {
  final double height;
  final Media movie;
  final String? posterPath;
  final String? backdropPath;

  const MediaCard(
      {Key? key,
      this.height = 200,
      required this.movie,
      required this.posterPath,
      required this.backdropPath})
      : super(key: key);

  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () =>
            Navigator.of(context).pushNamed('/media_details', arguments: {
              'title': widget.movie.title,
              'year': '${widget.movie.title}(${widget.movie.year})',
              'overview': widget.movie.overview,
              'rating': widget.movie.rating,
              'backdrop':
                  '${widget.backdropPath}${widget.movie.poster}',
            }),
        child: Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Column(
            children: [
              Hero(
                tag: 'poster1',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.fitHeight,
                    image:
                        '${widget.posterPath}${widget.movie.poster}',
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.network("https://loremflickr.com/g/240/360/book"),
                  ),
                ),
              ),
              Text(
                '${widget.movie.title}(${widget.movie.year})',
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.5),
              )
            ],
          ),
        ));
  }
}
