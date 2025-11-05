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
    // WAJIB 7: Mengakses State
    final progress = Provider.of<UserProgress>(context);
    final totalQuestions = dummyQuestions.length;
    final score = progress.score;
    // WAJIB 6: Ukuran Dinamis
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis', style: TextStyle(fontFamily: 'CustomFont')),
        automaticallyImplyLeading: false, // Nonaktifkan tombol kembali
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(screenHeight * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // WAJIB 4: Ikon/Gambar
              Icon(Icons.emoji_events, size: screenHeight * 0.1, color: Colors.amber),
              const SizedBox(height: 20),
              Text(
                'Selamat, ${progress.username}!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CustomFont',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Skor Akhir Anda:',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$score / $totalQuestions',
                        style: TextStyle(
                          fontSize: screenHeight * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton( // WAJIB 3
                text: 'Main Lagi',
                onPressed: () {
                  progress.reset();
                  // WAJIB 2: Navigasi
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}