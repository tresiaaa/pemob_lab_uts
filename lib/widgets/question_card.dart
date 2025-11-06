import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final String questionText;

  const QuestionCard({
    super.key,
    required this.questionText,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Text(
          questionText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'QuestionFont',
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}