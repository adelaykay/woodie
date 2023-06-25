import 'dart:io';

import 'package:flutter/material.dart';
import 'package:woodie/components/bottom_nav.dart';
import 'package:woodie/pages/sign_in/sign_in_screen.dart';

class MyFavoritesPage extends StatefulWidget {
  static const routeName = '/favorites';

  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  State<MyFavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in'),
          onPressed: () {
            Navigator.pushNamed(context, SignInScreen.routeName);
          },
        ),
      ),
      bottomNavigationBar: MyBottomNav(
        idx: 2,
      ),
    );
  }
}
