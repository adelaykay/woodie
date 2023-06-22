import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:woodie/components/config.dart';
import 'package:woodie/components/media_card.dart';

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
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 50,
            ),
            AnimSearchBar(
              color: Colors.black54,
              searchIconColor: Colors.white,
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
                'Trending',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              isLoading
                  ? CircularProgressIndicator(
                      color: Colors.cyan,
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ...List.generate(demoMovies.length, (index) {
                            return MediaCard(
                              movie: demoMovies[index],
                              posterPath: posterPath,
                              backdropPath: backdropPath
                            );
                          }),
                          SizedBox(width: 10),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: MyBottomNav(),
    );
  }
}
