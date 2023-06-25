import 'package:flutter/material.dart';
import 'package:woodie/components/bottom_nav.dart';

class MyFavoritesPage extends StatelessWidget {
  static const routeName = '/favorites';

  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites'),),
      body: Center(child: Text('My Favorites'),),
      bottomNavigationBar: MyBottomNav(idx: 2,),
    );
  }
}
