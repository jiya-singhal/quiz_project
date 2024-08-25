import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';

class ApiService {
  // Use the Vercel domain for your base URL
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://quiz-project-git-main-jiya-singhals-projects.vercel.app/',
  );

  static Future<List<Question>> fetchQuestionsByLevel(int level) async {
    final response = await http.get(Uri.parse('$baseUrl/questions?level=$level'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Question.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
