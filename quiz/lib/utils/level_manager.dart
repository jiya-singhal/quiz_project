import 'package:shared_preferences/shared_preferences.dart';

class LevelManager {
  static Future<void> unlockNextLevel(int currentLevel) async {
    final prefs = await SharedPreferences.getInstance();
    int unlockedLevel = prefs.getInt('unlockedLevel') ?? 1;

    if (currentLevel >= unlockedLevel) {
      prefs.setInt('unlockedLevel', currentLevel + 1);
    }
  }

  static Future<int> getUnlockedLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('unlockedLevel') ?? 1; // Default to 1 if not set
  }
}
