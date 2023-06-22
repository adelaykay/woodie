import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MediaDetailsPage extends StatefulWidget {
  const MediaDetailsPage({Key? key}) : super(key: key);

  @override
  State<MediaDetailsPage> createState() => _MediaDetailsPageState();
}

class _MediaDetailsPageState extends State<MediaDetailsPage> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = (data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map?)!;
    return Scaffold(
      body: Hero(
        tag: 'poster1',
        child: FadeInImage.memoryNetwork(
          fit: BoxFit.cover,
          image: data['backdrop'],
          placeholder: kTransparentImage,
          imageErrorBuilder: (context, error, stackTrace) =>
              Image.network("https://loremflickr.com/g/240/360/book"),
        ),
      ),
    );
  }
}
