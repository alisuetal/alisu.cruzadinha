import 'package:flutter/material.dart';

class GameModel with ChangeNotifier {
  final String mainWord;
  final List<String> words;
  final List<String> wordsTips;
  final GameMode gameType;
  List<List<String>> wordsState;

  GameModel({
    required this.mainWord,
    required this.words,
    required this.wordsTips,
    required this.gameType,
    required this.wordsState,
  }) {
    if (wordsState == []) {
      wordsState = List<List<String>>.from(
        List<List>.generate(
          words.length,
          (_) => List<String>.from(["", "", "", "", ""]),
        ),
      );
    }
  }

  void addLetter(String letter, int x, int y) {
    wordsState[x][y] = letter;
  }

  void removeLetter(int x, int y) {
    wordsState[x][y] = "";
  }
}

enum GameMode { none, time, life }
