import 'package:flutter/material.dart';
import 'package:quiz/utils/level_manager.dart';  // Adjust the import path
import 'package:quiz/screens/quiz_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: LevelManager.getUnlockedLevel(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        int unlockedLevel = snapshot.data!;
        int maxLevel = 3;  // Define the maximum level available

        return Scaffold(
          appBar: AppBar(
            title: Text('Select Level'),
            backgroundColor: Colors.deepPurple,
          ),
          body: ListView.builder(
            itemCount: maxLevel,
            itemBuilder: (context, index) {
              int level = index + 1;
              return ListTile(
                title: Text('Level $level'),
                enabled: level <= unlockedLevel,
                onTap: level <= unlockedLevel
                    ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(currentLevel: level),
                          ),
                        )
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}
