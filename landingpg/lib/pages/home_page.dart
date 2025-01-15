import 'package:flutter/material.dart';
import '../components/feature_card.dart';
import '../components/header.dart';
import '../utils/assets.dart';

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
              profileIcon: AppAssets.smallProfileIconPng, // Gunakan gambar PNG
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
              title: 'Reading',
              description: 'Boost your English reading skills with fun!',
              imagePath: AppAssets.readingImagePng, // Gunakan gambar PNG
              backgroundColor: const Color(0xFF58CC02),
              navigateTo: '/readingQuiz',
            ),
            const SizedBox(height: 20),

            // Listening Card
            FeatureCard(
              title: 'Listening',
              description: 'Level up your English listening with dynamic!',
              imagePath: AppAssets.listeningImagePng, // Gunakan gambar PNG
              backgroundColor: const Color(0xFFFFC200),
              navigateTo: '/listeningQuiz',
            ),
          ],
        ),
      ),
    );
  }
}
