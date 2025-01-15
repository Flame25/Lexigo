import 'package:flutter/material.dart';
import '../utils/assets.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image using Image.asset
          Image.asset(
            AppAssets.landingPageImage,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Column(
            children: [
              AppBar(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/star-logo.png', // Path to your logo
                      height: 30, // Set height
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Lexigo',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFFEAAD49), // AppBar color
                elevation: 0, // Remove shadow
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                    children: [
                      Image.asset(
                        'assets/Anim_Landingpage.png', // Path to PNG image
                        height: 300, // Adjust size as needed
                      ),
                      const SizedBox(height: 20), // Space between image and text
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
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.5, // Line height for spacing
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/home'); // Navigate to home
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16), // Padding for the button
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16), // Rounded corners
                            color: const Color(0xFF58CC02), // Primary button color
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF58A700), // Bottom border color
                                offset: const Offset(0, 4), // Simulate bottom border by shadow
                                blurRadius: 0,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Text(
                            'START STUDY!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white, // Text color
                              fontSize: 15, // Font size
                              fontWeight: FontWeight.w700, // Bold font weight
                              letterSpacing: 0.8, // Letter spacing
                              fontFamily: 'din-round', // Use custom font if available
                            ),
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
