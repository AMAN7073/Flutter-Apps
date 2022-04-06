import 'package:first_app/quiz.dart';
import 'package:first_app/result.dart';
import 'package:flutter/material.dart';
//import './question.dart';
//import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _question_index = 0;
  var _totalScore = 0;
  var _questions = [
    {
      'questionText': 'What is your favourite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Blue', 'score': 9},
        {'text': 'Green', 'score': 8},
        {'text': 'White', 'score': 7}
      ]
    },
    {
      'questionText': 'Which is your favourite animal?',
      'answers': [
        {'text': 'Lion', 'score': 10},
        {'text': 'Tiger', 'score': 15},
        {'text': 'Giraffe', 'score': 20},
      ]
    }
  ];
  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _question_index = _question_index + 1;
    });
  }

  void _resetState() {
    setState(() {
      _totalScore = 0;
      _question_index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is my First App.'),
        ),
        body: _question_index < _questions.length
            ? Quiz(
                answerQuestion: _answerQuestion,
                question_index: _question_index,
                questions: _questions)
            : Result(_totalScore, _resetState),
      ),
    );
  }
}
