import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  final String title;
  final Color backgroundColor; // Tambahkan parameter untuk warna latar belakang

  const QuizHeader({
    super.key,
    required this.title,
    this.backgroundColor = const Color(0xFF58CC02), // Warna default
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 110,
      padding: const EdgeInsets.only(top: 50), // Adjust spacing here
      decoration: BoxDecoration(
        color: backgroundColor, // Gunakan parameter warna
        borderRadius: const BorderRadius.only(
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
