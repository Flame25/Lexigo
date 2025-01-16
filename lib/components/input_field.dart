import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller; // Tambahkan controller untuk mengelola input

  const InputField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller, // Parameter controller diperlukan
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.inter(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0x23534C4C), width: 1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF534C4C),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              border: InputBorder.none, // Menghapus garis default
            ),
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
