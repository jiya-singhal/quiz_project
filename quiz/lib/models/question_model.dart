class Question {
  final int id;
  final String situation;
  final String question;
  final List<String> options;
  final int correct;

  Question({
    required this.id,
    required this.situation,
    required this.question,
    required this.options,
    required this.correct,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int,
      situation: json['situation'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correct: json['correct'] as int,
    );
  }
}
