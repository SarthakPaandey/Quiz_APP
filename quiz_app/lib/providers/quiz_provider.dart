import 'package:flutter/material.dart';
import '../models/models.dart';

class QuizProvider with ChangeNotifier {
  late Quiz _quiz;
  late int _currentQuestionIndex = 0;

  Quiz get quiz => _quiz;
  int get currentQuestionIndex => _currentQuestionIndex;

  Future<void> loadQuiz() async {
    // Load quiz using ApiService
    // _quiz = await ApiService().fetchQuiz();
    notifyListeners();
  }

  void answerQuestion(String answer) {
    // Logic for answering a question
    _currentQuestionIndex++;
    notifyListeners();
  }
}
