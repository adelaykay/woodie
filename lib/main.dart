import 'package:Woodie/pages/videos/videos_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Woodie/firebase_options.dart';
import 'package:Woodie/model/screen_arguments.dart';
import 'package:Woodie/pages/favorites/favorites.dart';
import 'package:Woodie/pages/forgot_password/forgot_password_screen.dart';
import 'package:Woodie/pages/home.dart';
import 'package:Woodie/pages/media_details_page.dart';
import 'package:Woodie/pages/search_results_page.dart';
import 'package:Woodie/pages/sign_in/sign_in_screen.dart';
import 'package:Woodie/pages/sign_up/sign_up_screen.dart';
import 'package:Woodie/pages/videos/videos_page.dart';

import 'components/utils.dart';

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
      scaffoldMessengerKey: Utils.messengerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.blue,

        // Define the default font family.
        fontFamily: 'Candara',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 28, fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Candara'),
        ),
      ),
      initialRoute: '/',
      routes: {
        MyHomePage.routeName: (context) =>
        const MyHomePage(),
        SearchResultsPage.routeName: (context) => SearchResultsPage(),
        MyFavoritesPage.routeName: (context) => MyFavoritesPage(),
        SignInScreen.routeName: (context) => SignInScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen()
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
                  mediaType: args.mediaType,
                  backdrop: args.backdrop,
              );
            },
          );
        }
        if (settings.name == VideosPage.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as Map;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              // print('main${args['videosList']}');
              return VideosPage(
                  videosList: args['videosList']
              );
            },
          );
        }
        if (settings.name == VideoList.routeName) {
          // Cast the arguments to the correct
          // type: ScreenArguments.
          final args = settings.arguments as Map;

          // Then, extract the required data from
          // the arguments and pass the data to the
          // correct screen.
          return MaterialPageRoute(
            builder: (context) {
              // print('main${args['videosList']}');
              return VideoList(
                  videosList: args['videosList']
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
