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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? username = "User";
  String? user_id = "1";
  int reading_progress = 0;
  int listening_progress = 0;
  bool isLogin = false;

  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    reading_progress = 0;
    listening_progress = 0;
    username = "User";

    print(user_id);
    setState(() {
      user_id = prefs.getString("user_id");
    });

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/user/profile'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': user_id}),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> parsedJson = jsonDecode(response.body);
      Map<String, dynamic> userInfo = parsedJson['user_info'];

      setState(() {
        username = userInfo["username"];
        reading_progress = userInfo["reading_progress"];
        listening_progress = userInfo["listening_progress"];
        bool isLogin = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Header(
              title: 'Hi, ${username}!',
              profileIcon:
              AppAssets.smallProfileIconPng, // Gunakan gambar PNG
              onProfileTap: () {
                Navigator.pushNamed(
                  context,
                  '/profile',
                ).then((result) {
                    if (result == true) {
                      loadSession();
                    }
                });
            }),
            const SizedBox(height: 20),

            if (!isLogin)
              AlertDialog(
                title: Text('You are not logged in'),
                content: Text('Please log in to continue.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      // You can replace this with your actual login navigation logic
                      Navigator.pop(context); // Close the dialog
                      Navigator.pushNamed(context, '/');
                    },
                    child: Text('Log In'),
                  ),
                ],
              ),

            // Reading Card
            FeatureCard(
              title: 'Read',
              description: 'Boost your English reading skills with fun!',
              imagePath: AppAssets.readingImagePng,
              backgroundColor: const Color(0xFF58CC02),
              navigateTo: '/reading',
              progress: reading_progress / 100, // Contoh progress 75%
            ),
            const SizedBox(height: 20),

            // Listening Card
            FeatureCard(
              title: 'Listen',
              description:
                  'Level up your English listening skills with dynamic!',
              imagePath: AppAssets.listeningImagePng,
              backgroundColor: const Color(0xFFFFC200),
              navigateTo: '/listening',
              progress: listening_progress / 100, // Contoh progress 50%
            ),
          ],
        ),
      ),
    );
  }
}
