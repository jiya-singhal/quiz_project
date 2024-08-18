class Question {
  final String questionText;
  final List<String> options;
  final int correctOption;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOption,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'],
      options: List<String>.from(json['options']),
      correctOption: json['correctOption'],
    );
  }
}
