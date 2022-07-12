import 'dart:convert';
import 'package:cruzadinha/core/models/game_model.dart';
import 'package:cruzadinha/utils/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setLives(int? lives) async {
    var prefs = await _prefs.then((value) => value);
    if (lives != null) {
      prefs.setInt("${getDate()} - lives", lives);
    } else {
      prefs.remove("${getDate()} - lives");
    }
  }

  Future<void> setTimer(int? timer) async {
    var prefs = await _prefs.then((value) => value);
    if (timer != null) {
      prefs.setInt("${getDate()} - timer", timer);
    } else {
      prefs.remove("${getDate()} - timer");
    }
  }

  Future<int?> get lives async {
    var prefs = await _prefs.then((value) => value);
    return prefs.getInt("${getDate()} - lives");
  }

  Future<int?> get timer async {
    var prefs = await _prefs.then((value) => value);
    return prefs.getInt("${getDate()} - timer");
  }

  Future<List<List<String>>> get game async {
    var prefs = await _prefs.then((value) => value);
    List<String> wordState = [];
    if (prefs.getString("${getDate()} - state") != null) {
      wordState = List<String>.from(
          jsonDecode(prefs.getString("${getDate()} - state")!));
    }

    if (wordState.isEmpty) {
      return [];
    } else {
      List<List<String>> returnState = [];

      for (var element in wordState) {
        List<String> localWord = [];

        if (element.isNotEmpty) {
          for (var letter in element.split('')) {
            localWord.add(letter);
          }
        }

        int remaingLetters = (5 - localWord.length);

        for (var x = 0; x < remaingLetters; x++) {
          localWord.add('');
        }

        returnState.add(localWord);
      }

      return returnState;
    }
  }

  Future<void> setGame(List<String> wordState) async {
    var prefs = await _prefs.then((value) => value);
    prefs.setString("${getDate()} - state", jsonEncode(wordState));
  }

  Future<bool> setVersion(String version) async {
    var prefs = await _prefs.then((value) => value);
    if (prefs.getString("lastUpdate") == null) {
      prefs.setString("lastUpdate", version);
    } else {
      if (prefs.getString("lastUpdate") != version) {
        prefs.setString("lastUpdate", version);
      } else {
        return false;
      }
    }
    return true;
  }

  Future<void> resetGame() async {
    var prefs = await _prefs.then((value) => value);

    prefs.remove("${getDate()} - state");
    prefs.remove("${getDate()} - lives");
    prefs.remove("${getDate()} - timer");
  }

  Future<void> initTimer() async {
    var prefs = await _prefs.then((value) => value);
    if (prefs.getInt("${getDate()} - timer") == null) {
      prefs.setInt("${getDate()} - timer", 1800);
    }
  }

  Future<void> initLives() async {
    var prefs = await _prefs.then((value) => value);
    if (prefs.getInt("${getDate()} - lives") == null) {
      prefs.setInt("${getDate()} - lives", 5);
    }
  }

  Future<void> initGame(GameMode gameMode) async {
    var prefs = await _prefs.then((value) => value);

    if (prefs.getString("${getDate()} - state") == null) {
      prefs.setString("${getDate()} - state", jsonEncode([]));
    }

    if (gameMode == GameMode.life) {
      await initLives();
    } else {
      await initTimer();
    }
  }
}
