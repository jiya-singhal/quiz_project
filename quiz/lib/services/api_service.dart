import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question_model.dart';

class ApiService {
  static Future<List<Question>> fetchQuestionsByLevel(int level) async {
    final response = await http.get(Uri.parse('http://localhost:8080/questions?level=$level'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => Question.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}