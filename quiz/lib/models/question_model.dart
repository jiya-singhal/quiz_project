class Question {
  final int id;
  final String situation;
  final String question;
  final List<String> options;
  final int correct;
  final int level;
  final String imageUrl;  // New field for image URL

  Question({
    required this.id,
    required this.situation,
    required this.question,
    required this.options,
    required this.correct,
    required this.level,
    required this.imageUrl,  
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      situation: json['situation'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correct: json['correct'],
      level: json['level'],
      imageUrl: json['imageUrl'],  
    );
  }
}
