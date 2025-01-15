import 'package:flutter/material.dart';
import '../components/feature_card.dart';
import '../components/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Header(
              title: 'Hi, Jihan!',
              profileIcon: 'assets/small_profile_icon.svg',
              onProfileTap: () {
                Navigator.pushNamed(
                  context,
                  '/viewProfile',
                  arguments: {
                    'username': 'Jihan Aurelia',
                    'email': 'jihan@gmail.com',
                    'password': '************',
                    'dateOfBirth': '23/05/1995',
                  },
                );
              },
            ),
            const SizedBox(height: 20),

            // Reading Card
            FeatureCard(
              title: 'Read',
              description: 'Boost your English reading skills with fun!',
              imagePath: 'assets/reading_img.svg',
              backgroundColor: const Color(0xFF58CC02),
              onStart: () {
                print("Start Reading clicked!");
              },
            ),
            const SizedBox(height: 20),

            // Listening Card
            FeatureCard(
              title: 'Listening',
              description: 'Level up your English listening with dynamic!',
              imagePath: 'assets/listening_img.svg',
              backgroundColor: const Color(0xFFFFC200),
              onStart: () {
                print("Start Listening clicked!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
