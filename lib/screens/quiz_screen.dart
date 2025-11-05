import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/question.dart';
import '../models/user_progress.dart';

// WAJIB 1 & 2: Halaman, Navigasi, StatefulWidget
class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedAnswerIndex; // Local state untuk pilihan yang sedang diklik
  bool _isAnswerSubmitted = false;

  void _handleAnswer(int selectedIndex, UserProgress progress) {
    if (_isAnswerSubmitted) return;

    final currentQuestion = dummyQuestions[progress.currentQuestionIndex];
    final isCorrect = selectedIndex == currentQuestion.correctAnswerIndex;

    progress.submitAnswer(progress.currentQuestionIndex, selectedIndex);
    if (isCorrect) {
      progress.incrementScore();
    }

    setState(() {
      _selectedAnswerIndex = selectedIndex;
      _isAnswerSubmitted = true;
    });

    // Pindah ke pertanyaan berikutnya atau layar hasil setelah delay
    Future.delayed(const Duration(seconds: 1), () {
      if (progress.currentQuestionIndex < dummyQuestions.length - 1) {
        progress.nextQuestion();
        setState(() {
          _selectedAnswerIndex = null;
          _isAnswerSubmitted = false;
        });
      } else {
        // WAJIB 2: Navigasi
        Navigator.of(context).pushReplacementNamed('/result');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // WAJIB 7: Mengakses State
    return Consumer<UserProgress>(
      builder: (context, progress, child) {
        if (progress.username.isEmpty) {
          // Navigasi kembali jika tidak ada nama pengguna
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final currentQuestion = dummyQuestions[progress.currentQuestionIndex];
        // WAJIB 6: Ukuran Dinamis
        double screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Halo, ${progress.username}',
                style: const TextStyle(fontFamily: 'CustomFont')),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(screenHeight * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Pertanyaan ${progress.currentQuestionIndex + 1} dari ${dummyQuestions.length}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                // Kartu Pertanyaan
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      currentQuestion.text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Daftar Pilihan Jawaban
                ...currentQuestion.options.asMap().entries.map((entry) {
                  int optionIndex = entry.key;
                  String optionText = entry.value;

                  Color buttonColor = Colors.grey.shade200;
                  Color textColor = Colors.black;

                  // Logika Warna untuk Feedback (WAJIB 7)
                  if (_isAnswerSubmitted) {
                    if (optionIndex == currentQuestion.correctAnswerIndex) {
                      buttonColor = Colors.green.shade200; // Jawaban benar
                    } else if (optionIndex == _selectedAnswerIndex) {
                      buttonColor = Colors.red.shade200; // Jawaban salah
                    }
                  } else if (optionIndex == _selectedAnswerIndex) {
                    buttonColor = Colors.blue.shade200; // Pilihan yang sedang diklik
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () => _handleAnswer(optionIndex, progress),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                      ),
                      child: Text(
                        optionText,
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}