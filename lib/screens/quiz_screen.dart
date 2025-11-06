// lib/screens/quiz_screen.dart

import 'dart:async'; // <<< PENTING: Impor timer
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/question.dart';
import '../models/user_progress.dart';
import '../widgets/question_card.dart';
import '../utils/theme_provider.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedAnswerIndex;
  bool _isAnswerSubmitted = false;

  Timer? _timer;
  int _remainingTime = 15;
  final int _totalTime = 15;

  void _startTimer() {
    final progress = Provider.of<UserProgress>(context, listen: false);
    if (!progress.isTimerEnabled) return;

    _timer?.cancel();
    setState(() {
      _remainingTime = _totalTime;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          // Waktu Habis!
          _timer?.cancel();
          _handleTimeUp();
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _handleTimeUp() {
    if (_isAnswerSubmitted) return;

    setState(() {
      _isAnswerSubmitted = true;
      _selectedAnswerIndex = -1;
    });

    final progress = Provider.of<UserProgress>(context, listen: false);

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      _goToNextQuestionOrResult(progress);
    });
  }

  void _goToNextQuestionOrResult(UserProgress progress) {
    if (progress.currentQuestionIndex < dummyQuestions.length - 1) {
      progress.nextQuestion();
      setState(() {
        _selectedAnswerIndex = null;
        _isAnswerSubmitted = false;
      });
      _startTimer();
    } else {
      Navigator.of(context).pushReplacementNamed('/result');
    }
  }

  void _handleAnswer(int selectedIndex, UserProgress progress) {
    if (_isAnswerSubmitted) return;

    if (progress.isTimerEnabled) {
      _stopTimer();
    }

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

    // Pindah ke soal berikutnya
    Future.delayed(const Duration(seconds: 1), () {
      _goToNextQuestionOrResult(progress);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);

    const Color hintPink = Color(0xFFF48FB1); // Kita masih butuh ini utk progress bar

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Pertanyaan ${progress.currentQuestionIndex + 1}/${dummyQuestions.length}',
              style: TextStyle(
                  color: colors.appBarTheme.foregroundColor,
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  // <<< INI TAMBAHAN TAMPILAN TIMER
                  if (progress.isTimerEnabled)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: _remainingTime / _totalTime, // 15/15 -> 0/15
                            backgroundColor: colors.primaryColor.withOpacity(0.2),
                            valueColor: const AlwaysStoppedAnimation<Color>(hintPink),
                            minHeight: 10,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Sisa Waktu: $_remainingTime detik',
                            style: const TextStyle(
                              fontFamily: 'CustomFont',
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),

                  Container(
                    height: screenHeight * 0.25,
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13.0),
                      child: Image.asset(
                        currentQuestion.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.broken_image_outlined, color: Colors.red, size: 40)
                          );
                        },
                      ),
                    ),
                  ),

                  QuestionCard(
                    questionText: currentQuestion.text,
                  ),
                  const SizedBox(height: 20),

                  ...currentQuestion.options.asMap().entries.map((entry) {
                    int optionIndex = entry.key;
                    String optionText = entry.value;

                    Color buttonColor;
                    Color textColor = colors.brightness == Brightness.dark ? darkWhite : darkText;
                    BorderSide borderSide = BorderSide.none;

                    if (_isAnswerSubmitted) {
                      if (optionIndex == currentQuestion.correctAnswerIndex) {
                        buttonColor = correctGreen;
                      } else if (optionIndex == _selectedAnswerIndex) {
                        buttonColor = hintPink;
                        textColor = darkText;
                      } else {
                        buttonColor = colors.scaffoldBackgroundColor;
                        borderSide = BorderSide(color: colors.primaryColor, width: 1.0);
                      }
                    } else {
                      buttonColor = colors.cardTheme.color ?? colors.scaffoldBackgroundColor; // Default
                      borderSide = BorderSide(color: colors.primaryColor, width: 2.0);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ElevatedButton(
                        onPressed: () => _handleAnswer(optionIndex, progress),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: borderSide,
                          ),
                          elevation: 2.0,
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