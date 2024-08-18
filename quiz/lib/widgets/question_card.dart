import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final Function(bool) onAnswer;

  QuestionCard({required this.question, required this.onAnswer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            question.question,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        ...question.options.map((option) {
          int index = question.options.indexOf(option);
          return ElevatedButton(
            onPressed: () {
              bool correct = index == question.correct;
              onAnswer(correct);
            },
            child: Text(option),
          );
        }).toList(),
      ],
    );
  }
}
