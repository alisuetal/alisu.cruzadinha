import 'package:cruzadinha/screens/error_screen.dart';
import 'package:cruzadinha/screens/init_game_screen.dart';
import 'package:cruzadinha/screens/loading_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cruzadinha/core/firebase_options.dart';

class LoadThenGameScreen extends StatelessWidget {
  const LoadThenGameScreen({
    Key? key,
  }) : super(key: key);

  Future<void> firebaseInit(BuildContext context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseInit(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.done:
            return const InitGameScreen();
          default:
            return const ErrorScreen();
        }
      },
    );
  }
}
