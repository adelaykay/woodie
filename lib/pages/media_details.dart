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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Hero(
                tag: 'poster1',
                child: FadeInImage.memoryNetwork(
                  fit: BoxFit.contain,
                  image: data['backdrop'],
                  placeholder: kTransparentImage,
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.network("https://loremflickr.com/g/240/360/book"),
                ),
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.tonal(
                    onPressed: () {},
                    child: Text(data['year']),
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.black38,
                        minimumSize: Size(40, 15),
                        foregroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('|'),
                  SizedBox(
                    width: 10,
                  ),
                  FilledButton.tonal(
                    onPressed: () {},
                    child: Text('18+'),
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.black38,
                        minimumSize: Size(40, 15),
                        foregroundColor: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('|'),
                  SizedBox(
                    width: 10,
                  ),
                  FilledButton.tonal(
                    onPressed: () {},
                    child: Text('Adventure'),
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.black38,
                        minimumSize: Size(40, 15),
                        foregroundColor: Colors.white),
                  ),
                  FilledButton.tonal(
                    onPressed: () {},
                    child: Text('Action'),
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.black38,
                        minimumSize: Size(40, 15),
                        foregroundColor: Colors.white),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'],
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(height: 10,),
                Text(data['overview'],style: TextStyle(color: Colors.white60),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
