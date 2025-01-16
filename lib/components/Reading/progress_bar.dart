import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // nilai antara 0 hingga 1

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E5E5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * progress,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF1899D6),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
