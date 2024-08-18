import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/question_model.dart';
import '../services/api_service.dart';
import 'result_screen.dart';
import '../utils/level_manager.dart';  // Importing the LevelManager
import '../screens/level_selection_screen.dart'; 

class QuizScreen extends StatefulWidget {
  final int currentLevel;

  QuizScreen({required this.currentLevel});  // Accepting currentLevel as a parameter

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool isAnswered = false;
  int selectedAnswerIndex = -1;

  // Timer variables
  int timeLimit = 10; // Set the time limit for each question in seconds
  int remainingTime = 10; // Remaining time for the current question
  Timer? timer; // Timer object

  @override
  void initState() {
    super.initState();
    loadQuestions(widget.currentLevel);  // Load questions based on the selected level
  }

  void loadQuestions(int level) async {
    questions = await ApiService.fetchQuestionsByLevel(level);  // Fetch questions based on the selected level
    startTimer();  // Start the timer when questions are loaded
    setState(() {});
  }

  void startTimer() {
    remainingTime = timeLimit;
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          t.cancel();
          goToNextQuestion();  // Move to the next question when time runs out
        }
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
        selectedAnswerIndex = -1;
        startTimer();  // Restart the timer for the next question
      });
    } else {
      // Unlock the next level if completed
      LevelManager.unlockNextLevel(widget.currentLevel + 1);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  void checkAnswer(int selectedIndex) {
    stopTimer();  // Stop the timer when an answer is selected

    setState(() {
      isAnswered = true;
      selectedAnswerIndex = selectedIndex;
      if (selectedIndex == questions[currentQuestionIndex].correct) {
        score++;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      goToNextQuestion();
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
                  // Displaying the timer
                  Text(
                    'Time Remaining: $remainingTime seconds',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: remainingTime <= 5 ? Colors.red : Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
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
                      bool isCorrect = idx == questions[currentQuestionIndex].correct;
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
                                ? (isCorrect
                                    ? Colors.green
                                    : (idx == selectedAnswerIndex
                                        ? Colors.red
                                        : Colors.white))
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
                            selectedAnswerIndex == questions[currentQuestionIndex].correct
                                ? '😄 Correct!'
                                : '😣 Wrong!',
                            style: TextStyle(
                              fontSize: 24,
                              color: selectedAnswerIndex == questions[currentQuestionIndex].correct
                                  ? Colors.green
                                  : Colors.red,
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
                                  goToNextQuestion();
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

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }
}
