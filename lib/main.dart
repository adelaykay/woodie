import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:woodie/firebase_options.dart';
import 'package:woodie/model/screen_arguments.dart';
import 'package:woodie/pages/home.dart';
import 'package:woodie/pages/media_details_page.dart';
import 'package:woodie/pages/search_results_page.dart';

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
      // routes: {
      //   '/': (context) => MyHomePage(),
      //   '/media_details': (context) => MediaDetailsPage(),
      //   '/search_results': (context) => SearchResultsPage(),
      // },
      routes: {
        MyHomePage.routeName: (context) =>
        const MyHomePage(),
        // MediaDetailsPage.routeName: (context) => const MediaDetailsPage(),
        SearchResultsPage.routeName: (context) => SearchResultsPage()
      },
      // Provide a function to handle named routes.
      // Use this function to identify the named
      // route being pushed, and create the correct
      // Screen.
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == MediaDetailsPage.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as ScreenArguments;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return MediaDetailsPage(
                  id: args.id,
                  title: args.title,
                  year: args.year,
                  overview: args.overview,
                  rating: args.rating,
                  backdrop: args.backdrop,
              );
            },
          );
        }
        // The code only supports
        // PassArgumentsScreen.routeName right now.
        // Other values need to be implemented if we
        // add them. The assertion here will help remind
        // us of that higher up in the call stack, since
        // this assertion would otherwise fire somewhere
        // in the framework.
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
