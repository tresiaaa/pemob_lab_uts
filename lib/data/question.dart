class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  const Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

const List<Question> dummyQuestions = [
  Question(
    text: 'Apa bahasa pemrograman yang digunakan Flutter?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    text: 'Widget apa yang digunakan untuk tata letak yang berubah-ubah?',
    options: ['StatelessWidget', 'StatefulWidget', 'Container', 'Text'],
    correctAnswerIndex: 1,
  ),
  // Tambahkan minimal 3-5 pertanyaan lagi
];