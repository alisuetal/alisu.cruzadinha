import 'package:cruzadinha/core/models/game_model.dart';
import 'package:cruzadinha/screens/choose_game_style_screen.dart';
import 'package:cruzadinha/screens/load_then_game_screen.dart';
import 'package:cruzadinha/utils/color_utilities.dart';
import 'package:cruzadinha/utils/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xff3d405b),
      systemNavigationBarColor: Color(0xffe07a5f),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const AppInit());
}

class AppInit extends StatelessWidget {
  const AppInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameModel(
            mainWord: "",
            words: [],
            wordsState: [],
            wordsTips: [],
            gameType: GameMode.none,
          ),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Cruzadinha',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch:
            ColorUtilities.createMaterialColor(const Color(0xffe07a5f)),
        colorScheme: Theme.of(context).colorScheme.copyWith(
              background: const Color(0xff3d405b),
              error: const Color.fromARGB(255, 128, 52, 53),
            ),
        textTheme: TextTheme(
          headline1: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white.withOpacity(0.9),
          ),
          headline2: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Colors.white.withOpacity(0.9),
          ),
          headline3: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white.withOpacity(0.9),
          ),
          bodyText1: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.white.withOpacity(0.9),
          ),
          bodyText2: GoogleFonts.robotoSlab(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ),
      home: const LoadThenGameScreen(),
      routes: {
        AppRoutes.CHOOSE_STYLE: (context) => ChooseGameStyleScreen(),
      },
    );
  }
}
