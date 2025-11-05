import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user_progress.dart';
import 'screens/welcome_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(
    // WAJIB 7: State Management (menggunakan Provider/ChangeNotifierProvider)
    ChangeNotifierProvider(
      create: (context) => UserProgress(),
      child: const MyApp(),
    ),
  );
}

// WAJIB 1: StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kuis Flutter',
      // Pengaturan Theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // WAJIB 5: Font Kustom
        fontFamily: 'CustomFont',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Bonus Poin 1: Jika ingin dual-theme, Anda akan menggunakan ThemeMode dan ThemeData.dark()
      ),
      // WAJIB 2: Navigasi Antar Halaman
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        QuizScreen.routeName: (context) => const QuizScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
      },
    );
  }
}