import 'package:flutter/material.dart';

class MyBottomNav extends StatelessWidget {
  const MyBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BottomNavigationBar(
            backgroundColor: Colors.grey[900],
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
    );
  }
}
