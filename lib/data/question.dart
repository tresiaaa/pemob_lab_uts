class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String imageUrl;

  const Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.imageUrl,
  });
}

const List<Question> dummyQuestions = [
  // Soal 1
  Question(
    text: 'Logo apakah ini?',
    options: ['Linux', 'Phyton', 'Flutter', 'Windows'],
    correctAnswerIndex: 0,
    imageUrl: 'assets/images/linux.jpeg',
  ),
  // Soal 2
  Question(
    text: 'Logo apakah ini?',
    options: ['Firefox', 'Chrome', 'Opera', 'Safari'],
    correctAnswerIndex: 1,
    imageUrl: 'assets/images/chrome.jpeg',
  ),

  // Soal 3
  Question(
    text: 'Logo apakah ini?',
    options: ['Phyton', 'Kotlin', 'Visual Studio', 'PostgreSQL'],
    correctAnswerIndex: 0,
    imageUrl: 'assets/images/phyton.png',
  ),

  // Soal 4
  Question(
    text: 'Logo apakah ini?',
    options: ['Java', 'Kotlin', 'Windows', 'Android'],
    correctAnswerIndex: 2,
    imageUrl: 'assets/images/windows.png',
  ),

  // Soal 5
  Question(
    text: 'Logo apakah ini?',
    options: ['Java', 'flutter', 'Windows', 'Android'],
    correctAnswerIndex: 1,
    imageUrl: 'assets/images/flutter.png',
  ),

  // Soal 6
  Question(
    text: 'Logo apakah ini?',
    options: ['Css', 'Kotlin', 'Windows', 'Html'],
    correctAnswerIndex: 3,
    imageUrl: 'assets/images/html.png',
  ),

  // Soal 7
  Question(
    text: 'Logo apakah ini?',
    options: ['Css', 'Kotlin', 'Javascript', 'Html'],
    correctAnswerIndex: 0,
    imageUrl: 'assets/images/css.jpeg',
  ),

  // Soal 8
  Question(
    text: 'Logo apakah ini?',
    options: ['Css', 'Javascript', 'Windows', 'Html'],
    correctAnswerIndex: 1,
    imageUrl: 'assets/images/javascript.png',
  ),

  // Soal 9
  Question(
    text: 'Logo apakah ini?',
    options: ['Java', 'Kotlin', 'Dart', 'Android'],
    correctAnswerIndex: 2,
    imageUrl: 'assets/images/dart.png',
  ),

  // Soal 10
  Question(
    text: 'Logo apakah ini?',
    options: ['Java', 'Dart', 'Swift', 'Flutter'],
    correctAnswerIndex: 2,
    imageUrl: 'assets/images/swift.jpeg',
  ),
];