import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/question.dart';
import '../models/user_progress.dart';
import '../widgets/custom_buttons.dart';

// WAJIB 1 & 2: Halaman, Navigasi, StatelessWidget
class ResultScreen extends StatelessWidget {
  static const routeName = '/result';

  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // <<< TEMA ROCOCO DIMULAI DI SINI
    const Color softPink = Color(0xFFF8BBD0);
    const Color darkText = Color(0xFF4E342E);
    const Color softWhite = Color(0xFFFFF8F8);
    const Color hintPink = Color(0xFFF48FB1);

    final progress = Provider.of<UserProgress>(context);
    final totalQuestions = dummyQuestions.length;
    final score = progress.score;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // <<< PERUBAHAN: Latar belakang
      backgroundColor: softWhite,
      appBar: AppBar(
        // <<< PERUBAHAN: Warna AppBar
        backgroundColor: softPink,
        // <<< PERUBAHAN: Warna teks AppBar
        foregroundColor: darkText,
        title: const Text(
          'Hasil Kuis',
          // <<< PERUBAHAN: Font AppBar
          style: TextStyle(
            fontFamily: 'CustomFont',
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false, // Nonaktifkan tombol kembali
        centerTitle: true,
        elevation: 0, // Opsional: flat design
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // <<< PERUBAHAN: Warna Ikon
              Icon(
                Icons.emoji_events, // Ikon piala
                size: screenHeight * 0.1,
                color: hintPink, // Ganti dari amber ke pink tua
              ),
              const SizedBox(height: 20),
              Text(
                'Selamat, ${progress.username}!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                  // <<< PERUBAHAN: Warna teks
                  color: darkText,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 3, // Kurangi bayangan agar lebih soft
                // <<< PERUBAHAN: Warna kartu
                color: Colors.white, // Putih bersih agar kontras
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Text(
                        'Skor Akhir Anda:',
                        // <<< PERUBAHAN: Font & Warna
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'CustomFont',
                          color: darkText,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$score / $totalQuestions',
                        style: TextStyle(
                          fontSize: screenHeight * 0.08,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CustomFont',
                          // <<< PERUBAHAN: Warna skor
                          color: hintPink, // Ganti dari biru ke pink tua
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'Main Lagi',
                onPressed: () {
                  progress.reset();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/', (route) => false);
                },
                // <<< PERUBAHAN: Warna tombol
                color: softPink, // Ganti dari hijau ke pink
              ),
            ],
          ),
        ),
      ),
    );
  }
}