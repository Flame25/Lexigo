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
                          horizontal: MediaQuery.of(context).size.width * 0.07, // 10% of screen width
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
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Button Clicked!')),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 16), // Padding for the button
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16), // Rounded corners
                            color: Color(0xFF58CC02), // Primary button color
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF58A700), // Bottom border color
                                offset: Offset(0, 4), // Simulate bottom border by shadow
                                blurRadius: 0,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.center, // Center-align text
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 4, // Create the effect of a solid bottom border
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF58CC02),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              Text(
                                'Start Study!'.toUpperCase(), // Text with uppercase
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize: 15, // Font size
                                  fontWeight: FontWeight.w700, // Bold font weight
                                  letterSpacing: 0.8, // Letter spacing
                                  fontFamily: 'din-round', // Use custom font if available
                                ),
                              ),
                            ],
                          ),
                        ),
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
