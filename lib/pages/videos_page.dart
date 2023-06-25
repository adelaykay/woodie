import 'package:flutter/material.dart';
import 'package:woodie/components/bottom_nav.dart';

class VideosPage extends StatelessWidget {
  static const routeName = '/videos_page';

  const VideosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trailers'),),
      body: Center(child: Text('Trailers'),),
      bottomNavigationBar: MyBottomNav(idx: 1,),
    );
  }
}
