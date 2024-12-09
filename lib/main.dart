import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'landingpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Baloo2'),
      home: SplashScreenWithBackgroundChange(),
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

    // Change background color to blue after 15 seconds
    Future.delayed(const Duration(seconds: 7), () {
      setState(() {
        _backgroundColor = const Color(0xFF235390);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
