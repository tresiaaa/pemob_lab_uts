import 'package:flutter/material.dart';

// Widget yang dapat digunakan kembali untuk input teks
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    // Menggunakan ukuran layar dinamis untuk lebar field
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85, // 85% lebar layar
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(fontFamily: 'CustomFont'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          prefixIcon: const Icon(Icons.person),
        ),
        style: const TextStyle(fontFamily: 'CustomFont'),
      ),
    );
  }
}