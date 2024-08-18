import 'package:flutter/material.dart';
import 'package:quiz/screens/quiz_screen.dart';
import 'package:quiz/screens/level_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LevelSelectionScreen()),
            );
          },
          child: Text('Let\'s Play Quiz'),
        ),
      ),
    );
  }
}
