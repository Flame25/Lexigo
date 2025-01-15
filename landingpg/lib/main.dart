import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/reading_quiz_page.dart';
import 'pages/listening_quiz_page.dart';
import 'pages/view_profile.dart';
import 'pages/edit_profile.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/landing', // Set landing page as initial route
      routes: {
        '/': (context) => const LandingPage(),
        '/home': (context) => const HomePage(),
        '/readingQuiz': (context) => const ReadingQuizPage(),
        '/listeningQuiz': (context) => const ListeningQuizPage(),
        '/viewProfile': (context) => ViewProfilePage(
          userData: ModalRoute.of(context)!.settings.arguments as Map<String, String>,
        ),
        '/editProfile': (context) => const EditProfilePage(),
      },
    );
  }
}
