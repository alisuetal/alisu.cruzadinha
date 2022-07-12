import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cruzadinha/core/models/game_model.dart';
import 'package:cruzadinha/core/services/game_service.dart';
import 'package:cruzadinha/utils/tools.dart';

class FirebaseGameService implements GameService {
  late Future<GameModel> _game;

  FirebaseGameService() {
    _game = _fetchGame();
  }

  @override
  Future<GameModel> get game {
    return _game;
  }

  Future<GameModel> _fetchGame() async {
    Map<String, dynamic>? snapshot = await FirebaseFirestore.instance
        .collection('words')
        .doc(getDate())
        .get()
        .then(
          (value) => value.data(),
        );

    return GameModel(
      mainWord: snapshot!["mainWord"],
      words: List<String>.from(snapshot["words"]),
      wordsTips: List<String>.from(snapshot["tips"]),
      wordsState: [],
      gameType: GameMode.none,
    );
  }
}
