import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  ResultScreen({required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Result'),
      ),
      body: Center(
        child: Text(
          'Your Score: $score',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
