import 'package:flutter/material.dart';
import '../components/Reading/header_quiz.dart';
import '../components/Reading/progress_bar.dart';
import '../components/Reading/question_content.dart';
import '../components/Reading/answer_option.dart';
import '../components/custom_button.dart';
import '../components/Reading/feedback_popup.dart';

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
                  '/profile',
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
              imagePath: AppAssets.readingImagePng,
              backgroundColor: const Color(0xFF58CC02),
              navigateTo: '/reading',
              progress: 0.75, // Contoh progress 75%
            ),
            const SizedBox(height: 20),

            // Listening Card
            FeatureCard(
              title: 'Listen',
              description: 'Level up your English listening skills with dynamic!',
              imagePath: AppAssets.listeningImagePng,
              backgroundColor: const Color(0xFFFFC200),
              navigateTo: '/listening',
              progress: 0.5, // Contoh progress 50%
            ),
          ],
        ),
      ),
    );
  }
}
