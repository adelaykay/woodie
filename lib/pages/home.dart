import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woodie/components/config.dart';
import 'package:woodie/components/media_card.dart';
import 'package:woodie/model/media_api.dart';

import '../components/bottom_nav.dart';
import '../model/media.dart';

class MyHomePage extends StatefulWidget {
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

  final GlobalKey<RefreshIndicatorState> _freeRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late String? posterPath = '';
  late String? backdropPath = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    Future.wait([
      Config.getImagePath(MediaQueryData().size.width),
      MediaApi.getMedia('movie'),
      MediaApi.getMedia('tv'),
    ]).then((List response) {
      imageUrl = response[0];
      _movies = response[1];
      _tv = response[2];
      posterPath = imageUrl['posterPath']!;
      backdropPath = imageUrl['backdropPath']!;
      setState(() {
        isLoading = false;
      });
    }).catchError((e) => print(e));
    // imageUrl = await Config.getImagePath();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).orientation);
    return Scaffold(
      key: _key,
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Image.asset(
          'assets/cyan_logo.png',
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimSearchBar(
              color: Colors.black54,
              searchIconColor: Colors.cyan,
              rtl: true,
              width: 200,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              onSubmitted: (String word) {
                // QuerySearch(word);
              },
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        toolbarHeight: 75,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            key: _freeRefreshIndicatorKey,
            onRefresh: () async {
              return getData();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coming Soon',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.cyan,
                          ),
                        )
                      : CarouselSlider(
                          items: [
                              ...List.generate(
                                  demoMovies.length,
                                  (index) => MediaCard(
                                      movie: demoMovies[index],
                                      posterPath: posterPath,
                                      backdropPath: backdropPath))
                            ],
                          options: CarouselOptions(
                            initialPage: 3,
                            viewportFraction: 0.5,
                            aspectRatio: 1.2,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            enlargeFactor: 0.7,
                            padEnds: true,
                          )),
                ),
                Text(
                  'Trending Movies',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.cyan,
                          ),
                        )
                      : Container(
                          // height: MediaQuery.of(context).size.height * 2 / 7,
                          //     width: MediaQuery.of(context).size.width,
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
                                initialPage: 1,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.3,
                                aspectRatio: 2,
                                pageSnapping: false,
                              )),
                        ),
                ),
                Text(
                  'TV Shows',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Colors.cyan,
                          ),
                        )
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
                                  initialPage: 1,
                                  enableInfiniteScroll: false,
                                  viewportFraction: 0.3,
                                  aspectRatio: 2,
                                  pageSnapping: false)),
                        ),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNav(),
      extendBody: true,
    );
  }
}
