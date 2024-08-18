class Question {
  final int id;
  final String situation;
  final String question;
  final List<String> options;
  final int correct;
  final int level;

  Question({
    required this.id,
    required this.situation,
    required this.question,
    required this.options,
    required this.correct,
    required this.level,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      situation: json['situation'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correct: json['correct'],
      level: json['level'],
    );
  }
}
