class Quiz {
  final String id;
  final String title;
  final List<Question> questions;

  Quiz({required this.id, required this.title, required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      title: json['title'],
      questions:
          (json['questions'] as List).map((q) => Question.fromJson(q)).toList(),
    );
  }
}

class Question {
  final String id;
  final String questionText;
  final String imageUrl;
  final List<Answer> answers;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.questionText,
    required this.imageUrl,
    required this.answers,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['questionText'],
      imageUrl: json['imageUrl'],
      answers:
          (json['answers'] as List).map((a) => Answer.fromJson(a)).toList(),
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
    );
  }
}

class Answer {
  final String text;
  final bool isCorrect;

  Answer({required this.text, required this.isCorrect});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}

// Add the LeaderboardEntry class here
class LeaderboardEntry {
  final int rank;
  final String name;
  final int score;
  final bool isVirtual;
  final bool hasWon;

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
    required this.isVirtual,
    required this.hasWon,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      rank: json['rank'],
      name: json['name'],
      score: json['score'],
      isVirtual: json['isVirtual'] ?? false,
      hasWon: json['hasWon'] ?? false,
    );
  }
}
