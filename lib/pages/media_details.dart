import 'package:flutter/material.dart';

class MediaDetailsPage extends StatefulWidget {
  const MediaDetailsPage({Key? key}) : super(key: key);

  @override
  State<MediaDetailsPage> createState() => _MediaDetailsPageState();
}

class _MediaDetailsPageState extends State<MediaDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(tag: 'poster1', child: Image.network("https://loremflickr.com/g/240/360/book")),
    );
  }
}
