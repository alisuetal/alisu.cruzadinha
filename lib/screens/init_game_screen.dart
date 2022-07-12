import 'package:cruzadinha/core/models/game_model.dart';
import 'package:cruzadinha/screens/game_screen.dart';
import 'package:flutter/material.dart';
import '../core/services/game_service.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class InitGameScreen extends StatelessWidget {
  const InitGameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GameService().game,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.done:
            if (snapshot.hasData) {
              GameModel game = (snapshot.data as GameModel);
              return GameScreen(
                mainWord: game.mainWord,
                tips: game.wordsTips,
                words: game.words,
              );
            } else {
              return const ErrorScreen();
            }
          default:
            return const ErrorScreen();
        }
      },
    );
  }
}
