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
  late String image_url;

  bool isLoading = true;

  // List<Media> movies = Media();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPath();
  }

  Future<void> getPath() async {
    image_url = await Config.getImagePath();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 50,
        ),
        automaticallyImplyLeading: false,
        actions: [
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
          isLoading
              ? CircularProgressIndicator(
                  color: Colors.cyan,
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(demoMovies.length, (index) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: MediaCard(
                              movie: demoMovies[index],
                              image_url: image_url,
                            ));
                      }),
                      SizedBox(width: 10),
                    ],
                  ),
                )
        ],
      ),
      // bottomNavigationBar: MyBottomNav(),
    );
  }
}
