import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function restarth;

  Result(this.score, this.restarth);

  String get resultScore {
    String text;
    if (score <= 15) {
      text = 'You are a asshole.';
    } else {
      text = 'Good boy';
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultScore,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          FlatButton(
            onPressed: restarth as VoidCallback,
            child: Text('Restart Quiz!'),
            textColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
