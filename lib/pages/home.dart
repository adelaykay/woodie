import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woodie/components/config.dart';
import 'package:woodie/components/media_card.dart';

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

  final GlobalKey<RefreshIndicatorState> _freeRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  late String? posterPath = '';
  late String? backdropPath = '';

  // List<Media> movies = Media();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPath();
  }

  Future<void> getPath() async {
    imageUrl = await Config.getImagePath();
    posterPath = imageUrl['posterPath']!;
    backdropPath = imageUrl['backdropPath']!;

    setState(() {
      isLoading = false;
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          key: _freeRefreshIndicatorKey,
          onRefresh: () async {
            return getPath();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          viewportFraction: 0.5,
                            aspectRatio: 1.3,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            enlargeFactor: 0.7,
                          padEnds: true,
                        )
                ),
              ),
              Text(
                'TV Shows',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.cyan,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(demoTV.length, (index) {
                              return MediaCard(
                                  movie: demoTV[index],
                                  posterPath: posterPath,
                                  backdropPath: backdropPath);
                            }),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNav(),
    );
  }
}
