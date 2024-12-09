import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image using Image.asset
          Image.asset(
            'assets/Landingpage.png', // Path to the background PNG
            fit: BoxFit.cover, // Cover the entire screen
            width: MediaQuery.of(context).size.width, // Full screen width
            height: MediaQuery.of(context).size.height, // Full screen height
          ),
          Column(
            children: [
              AppBar(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/star-logo.gif', // Path to your logo
                      height: 30, // Set height
                    ),
                    SizedBox(width: 10),
                    Text('Lexigo'),
                  ],
                ),
                backgroundColor: Color(0xFFEAAD49), // Make AppBar transparent
                elevation: 0, // Remove shadow
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    children: [
                      Positioned(
                        top: -100.0, // Adjust Y-axis position
                        left: MediaQuery.of(context).size.width / 2 - 150, // Center horizontally
                        child: Image.asset(
                          'assets/Anim_Landingpage.png', // Path to PNG image
                          height: 300, // Adjust size as needed
                        ),
                      ),
                      SizedBox(height: 20), // Space between image and text
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05, // 10% of screen width
                        ),
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            double fontSize = constraints.maxWidth * 0.1; // Scale font size based on screen width
                            return Text(
                              'Easy and Economic Way to Sharpen Your English Skills!',
                              textAlign: TextAlign.center, // Center-align text
                              style: TextStyle(
                                fontSize: fontSize, // Dynamic font size
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.5, // Line height for spacing
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('START STUDY!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF58A700), // Background color
                          foregroundColor: Colors.white, // Text color
                          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16), // Padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // Rounded corners
                          ),
                          textStyle: TextStyle(
                            fontFamily: 'din-round', // Font family (custom font should be added to assets if not default)
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8, // Letter spacing
                            textBaseline: TextBaseline.alphabetic,
                          ),
                          elevation: 4, // Simulates the border effect in the CSS
                        ),
                        child: Text('START STUDY!'.toUpperCase()), // Transform text to uppercase
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
