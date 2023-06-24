import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:woodie/firebase_options.dart';
import 'package:woodie/pages/home.dart';
import 'package:woodie/pages/media_details.dart';
import 'package:woodie/pages/search_results.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Color(0X00AEEF),

        // Define the default font family.
        fontFamily: 'Candara',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Candara'),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        '/media_details': (context) => MediaDetailsPage(),
        '/search_results': (context) => SearchResults(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
