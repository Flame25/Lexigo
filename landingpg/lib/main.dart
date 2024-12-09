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
                      Text(
                        'Welcome to My App!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Ensure visibility on background
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'This is a simple landing page.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[300], // Lighter text color for contrast
                        ),
                      ),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Button Clicked!')),
                          );
                        },
                        child: Text('Get Started'),
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
