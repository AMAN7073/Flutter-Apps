import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback stateHandler;
  final String answerText;

  Answer(this.stateHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        onPressed: stateHandler,
        child: Text(answerText),
        color: Colors.blue,
      ),
    );
  }
}
