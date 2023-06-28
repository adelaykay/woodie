import 'package:Woodie/pages/videos/videos_page.dart';
import 'package:Woodie/size_config.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:Woodie/model/movie_details.dart';
import 'package:Woodie/services/favorites_service.dart';
import 'package:Woodie/services/media_details_api.dart';
import 'package:Woodie/components/config.dart';

import '../components/media_card.dart';
import '../model/tv_details.dart';

class MediaDetailsPage extends StatefulWidget {
  static const routeName = '/media_details_page';

  final int id;
  final String? backdrop;
  final String mediaType;

  const MediaDetailsPage(
      {Key? key,
      required this.id,
      required this.backdrop,
      required this.mediaType})
      : super(key: key);

  @override
  State<MediaDetailsPage> createState() => _MediaDetailsPageState();
}

class _MediaDetailsPageState extends State<MediaDetailsPage> {
  final user = FirebaseAuth.instance.currentUser;
  bool isLoading = true;
  late MovieDetails movieDetails;
  late TvDetails tvDetails;
  late List<String> videosList;
  late Map<String, String> imageUrl;

  late String posterPath = '';
  late String backdropPath = '';
  late String profilePath = '';

  final addedToFaves = SnackBar(
    content: Text('Added Movie to Favorites'),
    duration: Duration(seconds: 3),
    elevation: 10,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20))),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Future.wait([
      Config.getImagePath(),
      MovieDetailsApi.getMovieDetails(
          path: '3/${widget.mediaType}/${widget.id}',
          mediaType: widget.mediaType),
    ]).then((List response) {
      imageUrl = response[0];
      if (widget.mediaType == 'tv') {
        tvDetails = response[1];
        videosList = tvDetails.videosList;
      } else if (widget.mediaType == 'movie') {
        movieDetails = response[1];
        videosList = movieDetails.videosList;
      }
      posterPath = imageUrl['posterPath']!;
      backdropPath = imageUrl['backdropPath']!;
      profilePath = imageUrl['profilePath']!;
      setState(() {
        isLoading = false;
      });
    }).catchError((e) => print(e));
  }

  Widget? capMediaType() {
    if (widget.mediaType == 'movie') {
      return Text('Movie');
    } else if (widget.mediaType == 'tv') {
      return Text('TV');
    } else {
      return Text(widget.mediaType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Hero(
                  tag: '${widget.id}',
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.contain,
                    image: widget.backdrop!,
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.network("https://loremflickr.com/g/240/360/book"),
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black])),
                ),
                isLoading
                    ? Text('')
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.black38,
                                minimumSize: Size(40, 15),
                                foregroundColor: Colors.white),
                            child: Text(widget.mediaType == 'movie'
                                ? '${movieDetails.year}'
                                : '${tvDetails.year}'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 10,
                          ),
                          FilledButton.tonal(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.black38,
                                minimumSize: Size(40, 15),
                                foregroundColor: Colors.white),
                            child: capMediaType(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('|'),
                          SizedBox(
                            width: 10,
                          ),
                          FilledButton.tonal(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.black38,
                                minimumSize: Size(40, 15),
                                foregroundColor: Colors.white),
                            child: Text(widget.mediaType == 'movie'
                                ? movieDetails.genre![0]
                                : tvDetails.genre![0]),
                          ),
                          widget.mediaType == 'movie'
                              ? (movieDetails.genre!.length > 1
                                  ? FilledButton.tonal(
                                      onPressed: () {},
                                      style: FilledButton.styleFrom(
                                          backgroundColor: Colors.black38,
                                          minimumSize: Size(40, 15),
                                          foregroundColor: Colors.white),
                                      child: Text(movieDetails.genre![1]),
                                    )
                                  : Text(''))
                              : tvDetails.genre!.length > 1
                                  ? FilledButton.tonal(
                                      onPressed: () {},
                                      style: FilledButton.styleFrom(
                                          backgroundColor: Colors.black38,
                                          minimumSize: Size(40, 15),
                                          foregroundColor: Colors.white),
                                      child: Text(tvDetails.genre![1]),
                                    )
                                  : Text('')
                        ],
                      ),
                isLoading
                    ? Text('')
                    : videosList.isEmpty ? Text('') : Positioned(
                        top: getProportionateScreenHeight(300),
                        child: IconButton(
                          splashColor: Colors.white,
                          splashRadius: 50,
                          onPressed: () {
                            Navigator.pushNamed(context, VideosPage.routeName,
                                arguments: {
                                  'videosList': widget.mediaType == 'movie'
                                      ? movieDetails.videosList
                                      : tvDetails.videosList
                                });
                          },
                          icon: Icon(Icons.play_arrow),
                          iconSize: 100,
                        ))
              ],
            ),
            isLoading
                ? CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.mediaType == 'movie'
                                  ? '${movieDetails.title}'
                                  : '${tvDetails.title}',
                              style: TextStyle(fontSize: 28),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white60,
                                  size: 15,
                                ),
                                Text(
                                  widget.mediaType == 'movie'
                                      ? ' ${movieDetails.runtime} mins'
                                      : '${tvDetails.cznCount} seasons',
                                  style: TextStyle(color: Colors.white60),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                Text(
                                  widget.mediaType == 'movie'
                                      ? ' ${movieDetails.rating}'
                                      : '${tvDetails.rating}',
                                  style: TextStyle(color: Colors.white60),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [],
                            ),
                            Divider(),
                            Text(
                              'Cast',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            widget.mediaType == 'movie'
                                ? CarouselSlider(
                                    items: [
                                        ...List.generate(
                                            movieDetails.cast!.length,
                                            (index) => CircleAvatar(
                                                  radius: 30,
                                                  foregroundImage: NetworkImage(
                                                      '$profilePath${movieDetails.cast?[index].profile_pic}'),
                                                ))
                                      ],
                                    options: CarouselOptions(
                                      initialPage: 0,
                                      viewportFraction: 0.2,
                                      enableInfiniteScroll: false,
                                      pageSnapping: false,
                                      aspectRatio: 6,
                                      padEnds: false,
                                    ))
                                : CarouselSlider(
                                    items: [
                                        ...List.generate(
                                            tvDetails.cast!.length,
                                            (index) => CircleAvatar(
                                                  radius: 30,
                                                  foregroundImage: NetworkImage(
                                                      '$profilePath${tvDetails.cast?[index].profile_pic}'),
                                                ))
                                      ],
                                    options: CarouselOptions(
                                      initialPage: 0,
                                      viewportFraction: 0.2,
                                      enableInfiniteScroll: false,
                                      pageSnapping: false,
                                      aspectRatio: 6,
                                      padEnds: false,
                                    )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Synopsis',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              widget.mediaType == 'movie'
                                  ? '${movieDetails.overview}'
                                  : '${tvDetails.overview}',
                              style: TextStyle(color: Colors.white60),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        indent: 25,
                        endIndent: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 26.0, bottom: 10, top: 8),
                        child: Text(
                          'Similar',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      widget.mediaType == 'movie'
                          ? CarouselSlider(
                              items: [
                                  ...List.generate(
                                      movieDetails.similar!.length,
                                      (index) => MediaCard(
                                          movie: movieDetails.similar![index],
                                          posterPath: posterPath,
                                          backdropPath: backdropPath))
                                ],
                              options: CarouselOptions(
                                initialPage: 0,
                                viewportFraction: 0.3,
                                enableInfiniteScroll: false,
                                pageSnapping: false,
                                aspectRatio: 2,
                                padEnds: false,
                              ))
                          : CarouselSlider(
                              items: [
                                  ...List.generate(
                                      tvDetails.similar!.length,
                                      (index) => MediaCard(
                                          movie: tvDetails.similar![index],
                                          posterPath: posterPath,
                                          backdropPath: backdropPath))
                                ],
                              options: CarouselOptions(
                                initialPage: 0,
                                viewportFraction: 0.3,
                                enableInfiniteScroll: false,
                                pageSnapping: false,
                                aspectRatio: 2,
                                padEnds: false,
                              )),
                    ],
                  )
          ],
        ),
      ),
      floatingActionButton: user == null
          ? Text('')
          : FloatingActionButton(
              onPressed: () {
                widget.mediaType == 'movie'
                    ? FavoritesService.updateUser(
                        movieDetails.title,
                        movieDetails.rating,
                        movieDetails.id,
                        movieDetails.year,
                        widget.backdrop,
                        backdropPath,
                        widget.mediaType)
                    : FavoritesService.updateUser(
                        tvDetails.title,
                        tvDetails.rating,
                        tvDetails.id,
                        tvDetails.year,
                        widget.backdrop,
                        backdropPath,
                        widget.mediaType);
                ScaffoldMessenger.of(context).showSnackBar(addedToFaves);
              },
              child: Icon(Icons.favorite),
            ),
    );
  }
}
