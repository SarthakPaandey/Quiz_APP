import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/models.dart';
import '../quiz_data.dart';
import '../services/api_service.dart';
import '../utils/audio_manager.dart';
import 'package:flutter/animation.dart';
// import 'dart:math' as math;

class QuizScreen extends StatefulWidget {
  final String quizId;

  QuizScreen({required this.quizId});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int currentQuestionIndex = 0;
  late Quiz quiz;
  int score = 0;
  int health = 2;
  int consecutiveWrong = 0;
  late AnimationController _controller;
  late AnimationController _backgroundAnimationController;
  late Animation<Color?> _colorAnimation;
  String currentLevel = 'Easy';

  @override
  void initState() {
    super.initState();
    quiz = technicalAnalysisQuiz;
    _controller = AnimationController(vsync: this);

    // Initialize background animation
    _backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = TweenSequence<Color?>(
      [
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.blue[100],
            end: Colors.purple[100],
          ),
        ),
        TweenSequenceItem(
          weight: 1.0,
          tween: ColorTween(
            begin: Colors.purple[100],
            end: Colors.blue[100],
          ),
        ),
      ],
    ).animate(_backgroundAnimationController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = quiz.questions[currentQuestionIndex];

    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Question ${currentQuestionIndex + 1} of ${quiz.questions.length}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueAccent,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _colorAnimation.value!,
                  _colorAnimation.value!.withOpacity(0.7),
                ],
              ),
            ),
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Level: $currentLevel',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    question.questionText,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        question.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ...question.answers
                      .map((answer) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: Text(
                                answer.text,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                _handleAnswer(answer);
                              },
                            ),
                          ))
                      .toList(),
                  SizedBox(height: 20),
                  Text('Score: $score', style: TextStyle(fontSize: 18)),
                  Text('Health: $health', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleAnswer(Answer answer) {
    setState(() {
      if (answer.isCorrect) {
        score += 10;
        consecutiveWrong = 0;
        AudioManager.playCorrectSound();
        _showExplanationDialog(context, 'Correct!',
            quiz.questions[currentQuestionIndex].explanation, true);
      } else {
        health--;
        consecutiveWrong++;
        AudioManager.playWrongSound();
        _showExplanationDialog(context, 'Wrong!',
            quiz.questions[currentQuestionIndex].explanation, false);

        if (consecutiveWrong == 2 || health == 0) {
          _showGameOverDialog();
        }
      }

      // Update level
      if (currentQuestionIndex < quiz.questions.length - 1) {
        currentQuestionIndex++;
        if (currentQuestionIndex == 3) {
          currentLevel = 'Medium';
        } else if (currentQuestionIndex == 6) {
          currentLevel = 'Hard';
        }
      } else {
        _promptForName();
      }
    });
  }

  void _showExplanationDialog(
      BuildContext context, String title, String explanation, bool isCorrect) {
    _controller.reset();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explanation:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(explanation),
              SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: isCorrect
                      ? Lottie.asset(
                          'assets/animations/Correct.json',
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller
                              ..duration = composition.duration
                              ..repeat();
                          },
                        )
                      : Lottie.asset(
                          'assets/animations/Wrong.json',
                          controller: _controller,
                          onLoaded: (composition) {
                            _controller
                              ..duration = composition.duration
                              ..repeat();
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              _controller.stop();
              Navigator.of(context).pop();
            },
            child: Text('Continue'),
          )
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    AudioManager.playGameOverSound();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text('Game Over'),
        content: Text('You have lost all your lives!'),
        actions: [
          ElevatedButton(
            child: Text('Restart'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }

  void _promptForName() {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Completed!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your score: $score'),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter your name",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              String userName = nameController.text;
              _submitScore(userName);
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/leaderboard', (Route<dynamic> route) => false);
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  void _submitScore(String name) async {
    try {
      await ApiService().submitScore(name, score, health);
    } catch (e) {
      print('Error submitting score: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit score. Please try again later.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }
}
