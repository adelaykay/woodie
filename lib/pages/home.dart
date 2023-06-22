import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo.png'),
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

            },
          ),
        ],
      ),
      body: Text('home'),
      // bottomNavigationBar: MyBottomNav(),
    );
  }
}
