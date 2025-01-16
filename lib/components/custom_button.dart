import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color shadowColor;
  final Color textColor;
  final double? width; // Parameter untuk lebar tombol

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color(0xFF1899D6),
    this.shadowColor = const Color(0xFF1CB0F6),
    this.textColor = Colors.white,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity, // Gunakan lebar sesuai parameter
        padding: const EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center, // Teks otomatis di tengah
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Text(
          text.toUpperCase(),
          textAlign: TextAlign.center, // Untuk memastikan teks rata tengah
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
      ),
    );
  }
}
