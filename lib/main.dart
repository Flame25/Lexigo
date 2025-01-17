import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lexigo/editprofile.dart';
import 'package:lexigo/homepage.dart';
import 'package:lexigo/listening.dart';
import 'package:lexigo/login.dart';
import 'package:lexigo/profile.dart';
import 'package:lexigo/reading.dart';
import 'package:lexigo/signup.dart';
import 'landingpage.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // global RouteObserver
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Baloo2'),
      initialRoute: '/splash',
      routes: {
        '/': (context) => LandingPage(),
        '/home': (context) => HomePage(),
        '/reading': (context) => ReadingQuizPage(),
        '/listening': (context) => ListeningQuizPage(),
        '/profile': (context) => ViewProfilePage(),
        '/editprofile': (context) => EditProfilePage(),
        '/splash': (context) => SplashScreenWithBackgroundChange(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage()
      },
    );
  }
}

class SplashScreenWithBackgroundChange extends StatefulWidget {
  @override
  _SplashScreenWithBackgroundChangeState createState() =>
      _SplashScreenWithBackgroundChangeState();
}

class _SplashScreenWithBackgroundChangeState
    extends State<SplashScreenWithBackgroundChange> {
  Color _backgroundColor = Colors.white; // Initial background color

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      // Change background color to blue after 7 seconds
      Future.delayed(const Duration(seconds: 7), () {
        setState(() {
          _backgroundColor = const Color(0xFF235390);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      // Directly show the landing page on the web
      return LandingPage();
    }

    return AnimatedContainer(
      duration: const Duration(seconds: 1), // Smooth background transition
      color: _backgroundColor, // Background color changes dynamically
      child: AnimatedSplashScreen(
        splash: SizedBox(
          width: 150.0, // GIF width
          height: 150.0, // GIF height
          child: Image.asset('assets/lexigo_splash.gif'),
        ),
        nextScreen: LandingPage(),
        splashIconSize: 500.0,
        centered: true,
        backgroundColor: Colors.transparent, // Transparent for parent control
        duration: 7000,
      ),
    );
  }
}

