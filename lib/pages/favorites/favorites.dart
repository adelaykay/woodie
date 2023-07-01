import 'package:Woodie/components/nav_drawer.dart';
import 'package:Woodie/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Woodie/components/bottom_nav.dart';
import 'package:Woodie/pages/favorites/body.dart';
import 'package:Woodie/pages/sign_in/sign_in_screen.dart';

import '../sign_up/sign_up_screen.dart';

class MyFavoritesPage extends StatefulWidget {
  static const routeName = '/favorites';

  const MyFavoritesPage({Key? key}) : super(key: key);

  @override
  State<MyFavoritesPage> createState() => _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  final user = FirebaseAuth.instance.currentUser;

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
      drawer: NavDrawer(),
      body: user == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(getProportionateScreenWidth(300),
                            getProportionateScreenHeight(40))),
                    child: Text('Sign in', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(getProportionateScreenWidth(300),
                            getProportionateScreenHeight(40))),
                    child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.routeName);
                    },
                  ),
                ],
              ),
            )
          : Body(),
      bottomNavigationBar: MyBottomNav(
        idx: 2,
      ),
    );
  }
}
