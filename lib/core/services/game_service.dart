import '../models/game_model.dart';
import 'firebase_game_service.dart';

abstract class GameService {
  Future<GameModel> get game;

  factory GameService() {
    return FirebaseGameService();
  }
}
