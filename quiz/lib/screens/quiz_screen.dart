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

  void nextQuestion(bool correct) {
    setState(() {
      isAnswered = true;
      isCorrect = correct;
    });

    Future.delayed(Duration(seconds: 2), () {
      if (correct) score++;
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          isAnswered = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(score: score, total: questions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Colors.purple,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${currentQuestionIndex + 1} of ${questions.length} – Fundamentals',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Situation: The trade war between the U.S. and China is escalating.',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Question: Will AUD/USD go up or down?',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          'assets/images/chart.jpeg',
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => nextQuestion(true), // Replace with your logic
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Up',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => nextQuestion(false), // Replace with your logic
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.green[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'Down',
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isAnswered)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isCorrect ? '🥳 Correct!' : '😬 Wrong!',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isCorrect ? Colors.green : Colors.red,
                                ),
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text('Explanation'),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => nextQuestion(isCorrect),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: Text('Continue'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
