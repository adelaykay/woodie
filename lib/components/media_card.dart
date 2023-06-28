import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:Woodie/model/screen_arguments.dart';

import '../model/media.dart';
import '../pages/media_details_page.dart';

class MediaCard extends StatefulWidget {
  final double height;
  final Media movie;
  final String? posterPath;
  final String? backdropPath;

  const MediaCard(
      {Key? key,
      this.height = 300,
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
            Navigator.pushNamed(context, MediaDetailsPage.routeName, arguments: ScreenArguments(
              id: widget.movie.id,
              backdrop: (MediaQuery.of(context).size.width < 500)
                  ? '${widget.backdropPath}${widget.movie.poster}'
                  : '${widget.backdropPath}${widget.movie.backdrop}',
              mediaType: widget.movie.mediaType
            )),
        child: Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Hero(
                  tag: '${widget.movie.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.fitHeight,
                      image: '${widget.posterPath}${widget.movie.poster}',
                      placeholder: kTransparentImage,
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.network(
                        "https://loremflickr.com/g/240/360/book",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    '${widget.movie.title}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBarIndicator(
                          rating: widget.movie.rating! / 2.0,
                          itemCount: 5,
                          itemSize: 10,
                          itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                            size: 5,
                              )),
                      Text(
                        '${widget.movie.year}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
