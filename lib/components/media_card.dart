import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/media.dart';
import '../pages/media_details.dart';
import 'config.dart';

class MediaCard extends StatefulWidget {
  final Media movie;
  final String image_url;

  const MediaCard({Key? key, required this.movie, required this.image_url})
      : super(key: key);

  @override
  State<MediaCard> createState() => _MediaCardState();
}

class _MediaCardState extends State<MediaCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MediaDetailsPage())),
        child: Card(
          child: Column(
            children: [
              Hero(
                tag: 'poster1',
                child: FadeInImage.memoryNetwork(
                  image: '${widget.image_url}${widget.movie.poster_path}',
                  placeholder: kTransparentImage,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.network("https://loremflickr.com/g/240/360/book"),
                ),
              ),
            ],
          ),
        ));
  }
}
