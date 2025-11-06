import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/question.dart';
import '../models/user_progress.dart';
import '../widgets/custom_buttons.dart';
import '../utils/theme_provider.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class ResultScreen extends StatefulWidget {
  static const routeName = '/result';
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    final progress = Provider.of<UserProgress>(context);
    final totalQuestions = dummyQuestions.length;
    final score = progress.score;
    double screenHeight = MediaQuery.of(context).size.height;

    const Color hintPink = Color(0xFFF48FB1);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Kuis',
          style: TextStyle(
            fontFamily: 'CustomFont',
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, notifier, child) {
              return IconButton(
                onPressed: () {
                  notifier.toggleTheme();
                },
                icon: Icon(
                  notifier.themeMode == ThemeMode.light
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                ),
              );
            },
          )
        ],
      ),

      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(screenHeight * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.emoji_events,
                    size: screenHeight * 0.1,
                    color: colors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Selamat, ${progress.username}!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'CustomFont',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          const Text(
                            'Skor Akhir Anda:',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'CustomFont',
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '$score / $totalQuestions',
                            style: TextStyle(
                              fontSize: screenHeight * 0.08,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'CustomFont',
                              color: hintPink,
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
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              emissionFrequency: 0.02,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                softPink,
                hintPink,
                Color(0xFFFFF8F8),
                Color(0xFF4E342E),
              ],
            ),
          ),
        ],
      ),
    );
  }
}