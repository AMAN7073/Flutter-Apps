import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int question_index;
  final Function answerQuestion;

  Quiz(
      {required this.answerQuestion,
      required this.question_index,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[question_index]['questionText'] as String),
        ...(questions[question_index]['answers'] as List<Map<String, Object>>)
            .map((answerText) {
          return Answer(() {
            answerQuestion(answerText['score']);
          }, answerText['text'] as String);
        }).toList(),
      ],
    );
  }
}
