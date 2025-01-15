import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  final String title;

  const QuizHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.only(top: 50), // Adjust spacing here
      decoration: const BoxDecoration(
        color: Color(0xFF58CC02),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Baloo',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
