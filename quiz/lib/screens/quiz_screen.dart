import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/api_service.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    questions = await ApiService.fetchQuestions();
    setState(() {});
  }

  void checkAnswer(int selectedIndex) {
    setState(() {
      isAnswered = true;
      isCorrect = selectedIndex == questions[currentQuestionIndex].correct;
    });

    Future.delayed(Duration(seconds: 2), () {
      if (isCorrect) score++;
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          isAnswered = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.deepPurple,
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${questions.length}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 20),
                // Display the situation
                Text(
                  'Situation: ${questions[currentQuestionIndex].situation}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  SizedBox(height: 20),
                  Text(
                    'Question: ${questions[currentQuestionIndex].question}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Center(
                      child: Image.asset('assets/images/chart.jpeg'), // Placeholder for the image
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: questions[currentQuestionIndex].options
                        .asMap()
                        .entries
                        .map((entry) {
                      int idx = entry.key;
                      String option = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: isAnswered
                              ? null
                              : () {
                                  checkAnswer(idx);
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isAnswered
                                ? (idx == questions[currentQuestionIndex].correct
                                    ? Colors.green
                                    : Colors.red)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          child: Center(child: Text(option)),
                        ),
                      );
                    }).toList(),
                  ),
                  if (isAnswered)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            isCorrect ? '😄 Correct!' : '😣 Wrong!',
                            style: TextStyle(
                              fontSize: 24,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Logic to show explanation
                                },
                                child: Text('Explanation'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (currentQuestionIndex <
                                      questions.length - 1) {
                                    setState(() {
                                      currentQuestionIndex++;
                                      isAnswered = false;
                                    });
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultScreen(
                                          score: score,
                                          total: questions.length,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Text('Continue'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
