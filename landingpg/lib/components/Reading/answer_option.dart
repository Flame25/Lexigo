import 'package:flutter/material.dart';

class AnswerOption extends StatefulWidget {
  final String optionLabel;
  final String optionText;
  final bool isSelected;
  final bool isCorrect;
  final bool highlightCorrect;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.optionLabel,
    required this.optionText,
    required this.isSelected,
    required this.isCorrect,
    this.highlightCorrect = false,
    required this.onTap,
  });

  @override
  _AnswerOptionState createState() => _AnswerOptionState();
}

class _AnswerOptionState extends State<AnswerOption> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: widget.highlightCorrect && widget.isCorrect
              ? const Color(0xFFD7FFB8) // Warna hijau untuk jawaban benar
              : (widget.isSelected
              ? const Color(0xFFFFDE00) // Warna kuning untuk opsi yang dipilih
              : Colors.white),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: widget.highlightCorrect && widget.isCorrect
                ? const Color(0xFF89E219) // Warna hijau untuk lingkaran jawaban benar
                : (widget.isSelected
                ? const Color(0xFFFFC200) // Warna oranye untuk lingkaran opsi yang dipilih
                : const Color(0xFFE5E5E5)),
            child: Text(
              widget.optionLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            widget.optionText,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
