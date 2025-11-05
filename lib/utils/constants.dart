import 'package:flutter/material.dart';

// Definisi Konstanta Warna
// Berguna jika Anda ingin mengimplementasikan Dual-Theme (Bonus Poin 1)
class AppColors {
  static const Color primary = Colors.blueAccent;
  static const Color accent = Colors.amber;
  static const Color backgroundLight = Colors.white;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color textLight = Colors.black87;
  static const Color textDark = Colors.white;
}

// Definisi Konstanta Ukuran (Padding, Margin, Radius)
// Membantu memastikan konsistensi desain.
class AppSizes {
  // Padding standar
  static const double sPadding = 8.0;
  static const double mPadding = 16.0;
  static const double lPadding = 24.0;

  // Radius sudut standar
  static const double borderRadius = 10.0;
}

// Helper untuk Ukuran Dinamis (opsional, bisa juga menggunakan MediaQuery langsung)
// Ini adalah contoh bagaimana Anda bisa mendefinisikan persentase layar.
class ScreenUtils {
  // Dapatkan persentase lebar layar
  static double getWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  // Dapatkan persentase tinggi layar
  static double getHeightPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
}