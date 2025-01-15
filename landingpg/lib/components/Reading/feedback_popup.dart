import 'package:flutter/material.dart';

class FeedbackPopup extends StatelessWidget {
  final bool isCorrect;
  final VoidCallback onContinue;

  const FeedbackPopup({
    super.key,
    required this.isCorrect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFD7FFB8) : const Color(0xFFFFDADC),
        border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon dan Teks Feedback
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  isCorrect ? Icons.check : Icons.close,
                  color: isCorrect ? const Color(0xFF489D26) : const Color(0xFFEC0B1B),
                  size: 30,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                isCorrect ? "Nice!" : "Nice Try!",
                style: TextStyle(
                  color: isCorrect ? const Color(0xFF489D26) : const Color(0xFFEC0B1B),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Tombol Continue
          GestureDetector(
            onTap: onContinue,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF42C62F),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF489D26),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Text(
                "CONTINUE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
