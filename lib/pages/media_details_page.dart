import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:woodie/model/movie_details.dart';
import 'package:woodie/model/movie_details_api.dart';
import 'package:woodie/components/config.dart';

import '../components/media_card.dart';

class MediaDetailsPage extends StatefulWidget {
  static const routeName = '/media_details_page';

  final int id;
  final double? rating;
  final String? title;
  final String? year;
  final String? overview;
  final String? backdrop;

  const MediaDetailsPage(
      {Key? key,
      required this.id,
      required this.rating,
      required this.title,
      required this.year,
      required this.overview,
      required this.backdrop})
      : super(key: key);

  @override
  State<MediaDetailsPage> createState() => _MediaDetailsPageState();
}

class _MediaDetailsPageState extends State<MediaDetailsPage> {
  bool isLoading = true;
  late MovieDetails movieDetails;

  late Map<String, String> imageUrl;

  late String posterPath = '';
  late String backdropPath = '';

  //https://api.themoviedb.org/3/movie/157336
  // ?api_key=9d9bc48b3fbe46983542e1f3e3c878e5
  // &append_to_response=videos,similar
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Future.wait([
      Config.getImagePath(MediaQueryData().size.width),
      MovieDetailsApi.getMovieDetails(path: '3/movie/${widget.id}'),
    ]).then((List response) {
      imageUrl = response[0];
      movieDetails = response[1];
      posterPath = imageUrl['posterPath']!;
      backdropPath = imageUrl['backdropPath']!;
      setState(() {
        isLoading = false;
      });
    }).catchError((e) => print(e));
    movieDetails =
        await MovieDetailsApi.getMovieDetails(path: '3/movie/${widget.id}');
    setState(() {
      isLoading = false;
    });
    print(movieDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Hero(
                        tag: 'poster1',
                        child: FadeInImage.memoryNetwork(
                          fit: BoxFit.contain,
                          image: widget.backdrop!,
                          placeholder: kTransparentImage,
                          imageErrorBuilder: (context, error, stackTrace) =>
                              Image.network(
                                  "https://loremflickr.com/g/240/360/book"),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton.tonal(
                            onPressed: () {},
                            child: Text('${movieDetails.year}'),
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.black38,
                                minimumSize: Size(40, 15),
                                foregroundColor: Colors.white),
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
                            child: Text('18+'),
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
                            child: Text('${movieDetails.genre?[0]}'),
                          ),
                          if(movieDetails.genre!.length > 1) FilledButton.tonal(
                            onPressed: () {},
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.black38,
                                minimumSize: Size(40, 15),
                                foregroundColor: Colors.white),
                            child: Text('${movieDetails.genre?[1]}'),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${movieDetails.title}',
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
                              ' ${movieDetails.runtime} mins',
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
                              ' ${movieDetails.rating}',
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
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${movieDetails.overview}',
                          style: TextStyle(color: Colors.white60),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 25,
                    endIndent: 25,
                  ),
                  CarouselSlider(
                      items: [
                        ...List.generate(
                            movieDetails.similar!.length,
                            (index) => MediaCard(
                                movie: movieDetails.similar![index],
                                posterPath: posterPath,
                                backdropPath: backdropPath))
                      ],
                      options: CarouselOptions(
                        initialPage: 1,
                        viewportFraction: 0.3,
                        enableInfiniteScroll: false,
                        pageSnapping: false,
                        aspectRatio: 2,
                        padEnds: false,
                      )),
                ],
              ),
      ),
    );
  }
}
