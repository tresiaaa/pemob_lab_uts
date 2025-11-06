import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/question.dart'; // Pastikan 'question.dart' (singular)
import '../models/user_progress.dart';
import '../widgets/question_card.dart'; // Kita akan pakai widget ini

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';

  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedAnswerIndex;
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

    Future.delayed(const Duration(seconds: 1), () {
      if (progress.currentQuestionIndex < dummyQuestions.length - 1) {
        progress.nextQuestion();
        setState(() {
          _selectedAnswerIndex = null;
          _isAnswerSubmitted = false;
        });
      } else {
        Navigator.of(context).pushReplacementNamed('/result');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // <<< TEMA ROCOCO DIMULAI DI SINI
    const Color softPink = Color(0xFFF8BBD0);
    const Color darkText = Color(0xFF4E342E);
    const Color softWhite = Color(0xFFFFF8F8);
    const Color hintPink = Color(0xFFF48FB1);
    const Color correctGreen = Color(0xFFC8E6C9); // Hijau muda
    const Color incorrectRed = Color(0xFFF8BBD0); // Kita pakai pink untuk salah

    return Consumer<UserProgress>(
      builder: (context, progress, child) {
        if (progress.username.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/');
          });
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final currentQuestion = dummyQuestions[progress.currentQuestionIndex];
        double screenHeight = MediaQuery.of(context).size.height;

        return Scaffold(
          // <<< PERUBAHAN WARNA LATAR BELAKANG
          backgroundColor: softWhite,
          appBar: AppBar(
            // <<< PERUBAHAN WARNA APPBAR
            backgroundColor: softPink,
            automaticallyImplyLeading: false, // Hapus tombol kembali

            // <<< PERUBAHAN: Hapus "Halo, [Nama]"
            title: Text(
              // Ganti judul menjadi progres pertanyaan
              'Pertanyaan ${progress.currentQuestionIndex + 1}/${dummyQuestions.length}',
              style: TextStyle(
                  fontFamily: 'CustomFont',
                  color: darkText,
                  fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView( // Tambahkan agar bisa di-scroll
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  // <<< PERUBAHAN: MENAMPILKAN GAMBAR
                  Container(
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: softPink, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                      child: Image.asset(
                        currentQuestion.imageUrl,
                        fit: BoxFit.contain, // <<< GANTI JADI INI
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.broken_image_outlined, color: Colors.red, size: 40)
                          );
                        },
                      ),
                    ),
                  ),

                  // <<< PERUBAHAN: Menggunakan QuestionCard (widget kustom)
                  QuestionCard(
                    questionText: currentQuestion.text,
                  ),

                  const SizedBox(height: 20),

                  // Daftar Pilihan Jawaban
                  ...currentQuestion.options.asMap().entries.map((entry) {
                    int optionIndex = entry.key;
                    String optionText = entry.value;

                    // <<< PERUBAHAN LOGIKA WARNA TOMBOL
                    Color buttonColor;
                    Color textColor = darkText;
                    BorderSide borderSide = BorderSide.none;

                    if (_isAnswerSubmitted) {
                      if (optionIndex == currentQuestion.correctAnswerIndex) {
                        buttonColor = correctGreen; // Jawaban benar
                      } else if (optionIndex == _selectedAnswerIndex) {
                        buttonColor = incorrectRed; // Jawaban salah
                        textColor = Colors.white; // Biar kontras
                      } else {
                        buttonColor = softWhite; // Pilihan lain
                        borderSide = BorderSide(color: softPink, width: 1.0);
                      }
                    } else {
                      buttonColor = softWhite; // Default
                      borderSide = BorderSide(color: softPink, width: 2.0);
                    }
                    // <<< AKHIR PERUBAHAN LOGIKA WARNA

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        onPressed: () => _handleAnswer(optionIndex, progress),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: borderSide, // Tambahkan border
                          ),
                          elevation: 2.0, // Sedikit bayangan
                        ),
                        child: Text(
                          optionText,
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                            fontFamily: 'CustomFont',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}