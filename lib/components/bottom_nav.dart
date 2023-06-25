import 'dart:ui';

import 'package:flutter/material.dart';

class MyBottomNav extends StatefulWidget {
  final int idx;
  const MyBottomNav({Key? key, this.idx = 0}) : super(key: key);

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {

  var _pageOptions = [
    '/', '/videos_page', '/favorites'
  ];


  void _onItemTapped(int index) {
    if(index != widget.idx) Navigator.pushNamed(context, _pageOptions[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(38, 0, 38, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: BottomNavigationBar(
            currentIndex: widget.idx,
            onTap: _onItemTapped,
              backgroundColor: Colors.lightBlue.shade200.withOpacity(0.5),
              selectedItemColor: Color(0XFF00AEEF),
              iconSize: 40,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: '',
                ),
                BottomNavigationBarItem(icon: Icon(Icons.play_circle), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: '')
              ]),
        ),
      ),
    );
  }
}
