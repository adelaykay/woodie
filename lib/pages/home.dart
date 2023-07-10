import 'package:Woodie/components/nav_drawer.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Woodie/components/config.dart';
import 'package:Woodie/components/media_card.dart';
import 'package:Woodie/services/media_api.dart';

import '../components/bottom_nav.dart';
import '../model/media.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  Map<String, String> imageUrl = {};

  bool isLoading = true;
  late List<Media> _movies;
  late List<Media> _tv;
  late List<Media> _upcoming;
  late List<Media> _action;
  late List<Media> _comedy;
  late List<Media> _horror;
  late List<Media> _naija;

  final GlobalKey<RefreshIndicatorState> _freeRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late String posterPath = '';
  late String backdropPath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Future.wait([
      Config.getImagePath(),
      MediaApi.getMedia(path: '3/movie/upcoming', mediaType: 'movie'),
      MediaApi.getMedia(path: '/3/discover/movie', mediaType: 'movie'),
      MediaApi.getMedia(path: '3/tv/top_rated', mediaType: 'tv'),
      MediaApi.getMedia(path: '/3/discover/movie', mediaType: 'movie', genre: '28'),
      MediaApi.getMedia(path: '/3/discover/movie', mediaType: 'movie', genre: '35'),
      MediaApi.getMedia(path: '/3/discover/movie', mediaType: 'movie', genre: '27'),
      MediaApi.getMedia(path: '/3/discover/movie', mediaType: 'movie', country: 'NG'),
    ]).then((List response) {
      imageUrl = response[0];
      _upcoming = response[1];
      _movies = response[2];
      _tv = response[3];
      _action = response[4];
      _comedy = response[5];
      _horror = response[6];
      _naija = response[7];
      posterPath = imageUrl['posterPath']!;
      backdropPath = imageUrl['backdropPath']!;
      setState(() {
        isLoading = false;
      });
    }).catchError((e) => print(e));
  }

  DateTime timeBackPressed = DateTime.now();

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final difference = DateTime.now().difference(timeBackPressed);
          final isExitWarning = difference >= Duration(seconds: 2);

          timeBackPressed = DateTime.now();

          if (isExitWarning) {
            const message = 'Press back again to exit';
            Fluttertoast.showToast(msg: message, fontSize: 18);

            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          key: _key,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.blue[200]
              : Colors.black45,
          appBar: AppBar(
            toolbarOpacity: 0.8,
            forceMaterialTransparency: true,
            leading: IconButton(
              onPressed: () => _key.currentState?.openDrawer(),
              icon: const Icon(
                Icons.menu,
              ),
              color: Theme.of(context).primaryColorLight,
            ),
            backgroundColor: Colors.transparent,
            title: Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/black_home_logo.png'
                  : 'assets/cyan_home_logo.png',
              fit: BoxFit.fitHeight,
              height: 40,
            ),
            centerTitle: true,
            actions: [
              AnimSearchBar(
                color: Colors.transparent,
                searchIconColor: Theme.of(context).primaryColorLight,
                rtl: true,
                width: 200,
                textController: textController,
                onSuffixTap: () {
                  setState(() {
                    textController.clear();
                  });
                },
                onSubmitted: (String word) async {
                  showDialog(
                      context: context,
                      builder: (context) => Center(
                            child: CircularProgressIndicator(),
                          ));
                  List<Media> searchResponse;
                  searchResponse = await MediaApi.getMedia(
                      path: '3/search/multi', query: word, mediaType: '');
                  Navigator.of(context)
                      .popAndPushNamed('/search_results', arguments: {
                    'results': searchResponse,
                    'poster_path': posterPath,
                    'backdrop_path': backdropPath
                  });
                },
              ),
            ],
            automaticallyImplyLeading: false,
            toolbarHeight: 75,
          ),
          body: RefreshIndicator(
            key: _freeRefreshIndicatorKey,
            onRefresh: () async {
              return getData();
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isLoading
                        ? Text('')
                        : Text(
                            'Coming Soon',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    isLoading
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height *
                                    4 /
                                    11),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.cyan,
                              ),
                            ),
                          )
                        : CarouselSlider(
                            items: [
                                ...List.generate(
                                    _upcoming.length,
                                    (index) => MediaCard(
                                        movie: _upcoming[index],
                                        posterPath: posterPath,
                                        backdropPath: backdropPath,
                                      hideTitleAndRating: true
                                    ))
                              ],
                            options: CarouselOptions(
                                initialPage: 0,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 10),
                                viewportFraction: 0.5,
                                aspectRatio: 1.1,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.zoom,
                                enlargeFactor: 0.5,
                                padEnds: true,
                                clipBehavior: Clip.antiAliasWithSaveLayer)),
                    isLoading
                        ? Text('')
                        : Text(
                            'Trending Movies',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    isLoading
                        ? Text('')
                        : SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 2 / 7,
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider(
                                items: [
                                  ...List.generate(
                                      _movies.length,
                                      (index) => MediaCard(
                                          movie: _movies[index],
                                          posterPath: posterPath,
                                          backdropPath: backdropPath))
                                ],
                                options: CarouselOptions(
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    viewportFraction: 0.3,
                                    aspectRatio: 1.9,
                                    pageSnapping: false,
                                    padEnds: false)),
                          ),
                    isLoading
                        ? Text('')
                        : Text(
                            'TV Shows',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                    isLoading
                        ? Text('')
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 2 / 7,
                            width: MediaQuery.of(context).size.width,
                            child: CarouselSlider(
                                items: [
                                  ...List.generate(
                                      _tv.length,
                                      (index) => MediaCard(
                                          movie: _tv[index],
                                          posterPath: posterPath,
                                          backdropPath: backdropPath))
                                ],
                                options: CarouselOptions(
                                    initialPage: 0,
                                    enableInfiniteScroll: false,
                                    viewportFraction: 0.3,
                                    aspectRatio: 1.9,
                                    pageSnapping: false,
                                    padEnds: false)),
                          ),
                    isLoading
                        ? Text('')
                        : Text(
                      'Action',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    isLoading
                        ? Text('')
                        : SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 7,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                          items: [
                            ...List.generate(
                                _action.length,
                                    (index) => MediaCard(
                                    movie: _action[index],
                                    posterPath: posterPath,
                                    backdropPath: backdropPath))
                          ],
                          options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.3,
                              aspectRatio: 1.9,
                              pageSnapping: false,
                              padEnds: false)),
                    ),
                    isLoading
                        ? Text('')
                        : Text(
                      'Comedy',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    isLoading
                        ? Text('')
                        : SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 7,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                          items: [
                            ...List.generate(
                                _comedy.length,
                                    (index) => MediaCard(
                                    movie: _comedy[index],
                                    posterPath: posterPath,
                                    backdropPath: backdropPath))
                          ],
                          options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.3,
                              aspectRatio: 1.9,
                              pageSnapping: false,
                              padEnds: false)),
                    ),
                    isLoading
                        ? Text('')
                        : Text(
                      'Horror',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    isLoading
                        ? Text('')
                        : SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 7,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                          items: [
                            ...List.generate(
                                _horror.length,
                                    (index) => MediaCard(
                                    movie: _horror[index],
                                    posterPath: posterPath,
                                    backdropPath: backdropPath))
                          ],
                          options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.3,
                              aspectRatio: 1.9,
                              pageSnapping: false,
                              padEnds: false)),
                    ),
                    isLoading
                        ? Text('')
                        : Text(
                      'Naija',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    isLoading
                        ? Text('')
                        : SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 7,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                          items: [
                            ...List.generate(
                                _naija.length,
                                    (index) => MediaCard(
                                    movie: _naija[index],
                                    posterPath: posterPath,
                                    backdropPath: backdropPath))
                          ],
                          options: CarouselOptions(
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              viewportFraction: 0.3,
                              aspectRatio: 1.9,
                              pageSnapping: false,
                              padEnds: false)),
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: MyBottomNav(
            idx: 0,
          ),
          drawer: NavDrawer(),
          extendBody: true,
        ),
      );
}
