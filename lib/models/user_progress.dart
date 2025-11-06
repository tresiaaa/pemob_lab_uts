import 'package:flutter/foundation.dart';

class UserProgress extends ChangeNotifier {
  String _username = '';
  int _score = 0;
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {};
  bool _isTimerEnabled = false;

  String get username => _username;
  int get score => _score;
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, int> get userAnswers => _userAnswers;
  bool get isTimerEnabled => _isTimerEnabled;

  void setTimerMode(bool isEnabled) {
    _isTimerEnabled = isEnabled;
    notifyListeners();
  }

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void incrementScore() {
    _score++;
    notifyListeners();
  }

  void submitAnswer(int questionIndex, int selectedAnswerIndex) {
    _userAnswers[questionIndex] = selectedAnswerIndex;
    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionIndex++;
    notifyListeners();
  }

  void reset() {
    _username = '';
    _score = 0;
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _isTimerEnabled = false;
    notifyListeners();
  }
}