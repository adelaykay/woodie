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
      body: user == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('Sign in'),
                    onPressed: () {
                      Navigator.pushNamed(context, SignInScreen.routeName);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: Text('Sign up'),
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
      floatingActionButton: FloatingActionButton(onPressed: (){
        FirebaseAuth.instance.signOut();
      }, child: Icon(Icons.logout),),
    );
  }
}
