import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cruzadinha/Components/cross_word_holder_widget.dart';
import 'package:cruzadinha/Components/cross_word_tips_widget%20.dart';
import 'package:cruzadinha/Components/game_type_status_widget.dart';
import 'package:cruzadinha/Components/title_message_widget.dart';
import 'package:cruzadinha/Components/header_widget.dart';
import 'package:cruzadinha/Components/inline_keyboard_widget.dart';
import 'package:cruzadinha/Components/screen_holder_widget.dart';
import 'package:cruzadinha/Components/welcome_widget.dart';
import 'package:cruzadinha/core/models/updates.dart';
import 'package:cruzadinha/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Components/bottom_modal_widget.dart';
import '../Components/qwerty_keyboard_widget.dart';
import '../core/models/game_model.dart';
import '../core/services/cookie_service.dart';
import '../utils/routes.dart';

class GameScreen extends StatefulWidget {
  final List<String> words;
  final List<String> tips;
  final String mainWord;

  const GameScreen({
    required this.words,
    required this.tips,
    required this.mainWord,
    Key? key,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ScrollController _scrollController = ScrollController();
  int _wordSelected = 0;
  int _letterSelected = 0;
  List<List<String>> wordState = [];
  bool _tipsState = false;
  int? _timeLimit;
  int? _lives;
  Timer? _stopWatch;
  final SnackBar _shareSnack = const SnackBar(
    content: Text('Copiado para a área de transferência.'),
    action: null,
  );

  @override
  void initState() {
    onInitColor(
      const Color(0xff3d405b),
      const Color(0xffe07a5f),
      Brightness.light,
      Brightness.light,
    );
    initWordState();
    chooseGM();
    super.initState();
  }

  void changeGM() {
    Navigator.of(context)
        .pushNamed(
      AppRoutes.CHOOSE_STYLE,
    )
        .then(
      (value) {
        resetGM(value as bool);
      },
    );
  }

  void chooseGM() async {
    int? lLives = await CookieService().lives;
    int? lTimeLimit = await CookieService().timer;
    if (lLives == null && lTimeLimit == null) {
      Navigator.of(context)
          .pushNamed(
        AppRoutes.CHOOSE_STYLE,
      )
          .then(
        (value) async {
          // print(value);
          await CookieService()
              .initGame(value as bool ? GameMode.life : GameMode.time);
          initGameStyle();
        },
      );
    } else {
      initGameStyle();
    }
  }

  void resetGM(bool gameStyle) async {
    if ((gameStyle && await CookieService().timer != null) ||
        (!gameStyle && await CookieService().lives != null)) {
      if (_stopWatch != null) {
        _stopWatch!.cancel();
        _stopWatch = null;
      }
      await CookieService().resetGame();
      if (gameStyle) {
        await CookieService().setLives(5);
      } else {
        await CookieService().setTimer(1800);
      }
      initGameStyle();
    }
  }

  void initGameStyle() async {
    _lives = await CookieService().lives;
    _timeLimit = await CookieService().timer;
    setState(
      () {
        _lives = _lives;
        _timeLimit = _timeLimit;
        if (_timeLimit != null) {
          _stopWatch = _stopWatch ??
              Timer.periodic(
                const Duration(seconds: 1),
                (_) {
                  if (_timeLimit! > 0) {
                    setState(() {
                      _timeLimit = _timeLimit! - 1;
                      CookieService().setTimer(_timeLimit);
                    });
                  }
                },
              );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    if (_stopWatch != null) _stopWatch!.cancel();
    super.dispose();
  }

  int? dLive(int wordSelected) {
    if (wordState[wordSelected].join() !=
        wordConversor(widget.words[wordSelected])) {
      if (_lives != null) {
        if (_lives! > 0) {
          setState(() {
            _lives = _lives! - 1;
          });
          CookieService().setLives(_lives);
        }
      }
    }
    return _lives;
  }

  Future<void> initWordState() async {
    List<List<String>> wordCookie = await CookieService().game;
    if (wordCookie.isNotEmpty) {
      setState((() {
        wordState = wordCookie;
        _wordSelected = -1;
        _letterSelected = -1;
      }));
    } else {
      setState(() {
        wordState = List<List<String>>.from(List<List>.generate(
            widget.words.length,
            (_) => List<String>.from(["", "", "", "", ""])));
      });
    }
  }

  void _selectLetter(int word, int letter) {
    setState(() {
      _wordSelected = word;
      _letterSelected = letter;
    });
  }

  void _openHeaderModal(BuildContext context, Widget content) async {
    onInitColor(
      const Color.fromARGB(255, 18, 27, 34),
      const Color(0xff3d405b),
      Brightness.light,
      Brightness.light,
    );
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ModalWidget(
          content: content,
        );
      },
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
      constraints: const BoxConstraints(
        maxHeight: 580.0,
      ),
    ).then((value) {
      onInitColor(
        const Color(0xff3d405b),
        const Color(0xffe07a5f),
        Brightness.light,
        Brightness.light,
      );
    });
  }

  List<int> _getNextWord() {
    return [
      wordState.indexWhere((element) =>
          element ==
          wordState.firstWhere(
              (element) =>
                  !wordsConversor(widget.words).contains(element.join('')),
              orElse: () => [""])),
      wordState[_wordSelected].indexWhere((element) => element.isEmpty)
    ];
  }

  void _addLetter(String letter) {
    if (_wordSelected != -1 && _letterSelected != -1) {
      setState(() {
        wordState[_wordSelected][_letterSelected] = letter.toLowerCase();
        if ((_letterSelected == 4 ||
                wordState[_wordSelected].join('').length == 5) &&
            _wordSelected < widget.words.length - 1) {
          dLive(_wordSelected);
          _wordSelected = _getNextWord()[0];
          _letterSelected = 0;
        } else {
          if (_letterSelected < 4) {
            _letterSelected++;
          } else {
            if (_gameStatus()) {
              _letterSelected = -1;
              _wordSelected = -1;
            }
          }
        }
        _setCookieGame();
      });
    }
  }

  void _setCookieGame() {
    setState(() {
      if (_gameStatus()) {
        CookieService().setGame(widget.words);
      } else {
        List<String> localWordState = [];
        for (var element in wordState) {
          localWordState.add(element.join(''));
        }
        CookieService().setGame(localWordState);
      }
    });
  }

  Future<void> stopSW() async {
    if (_timeLimit != null) {
      setState(() {
        _stopWatch!.cancel();
      });

      await CookieService().setTimer(0);
    }
  }

  bool _gameStatus() {
    bool gS = true;

    if (_lives == 0 || _timeLimit == 0) return gS;

    if (wordState.length == widget.words.length) {
      for (var x = 0; x < widget.words.length; x++) {
        if (wordConversor(widget.words[x]) !=
            wordConversor(wordState[x].join(''))) {
          return gS = false;
        }
      }
    } else {
      return gS = false;
    }

    stopSW();

    return gS;
  }

  void _removeLetter() {
    setState(() {
      if (wordState[_wordSelected][_letterSelected] != "") {
        wordState[_wordSelected][_letterSelected] = "";
      } else {
        if (_letterSelected != -1 && _wordSelected != -1) {
          if (_letterSelected == 0 && _wordSelected > 0) {
            _wordSelected = _getNextWord()[0];
            _letterSelected = _getNextWord()[1];
          } else {
            if (_letterSelected > 0) {
              _letterSelected--;
            }
          }
        }
      }
      _setCookieGame();
    });
  }

  void _showTips(BuildContext context, double deviceSize) {
    setState(() {
      _scrollController.animateTo(
        _tipsState
            ? 0
            : deviceSize >= 640
                ? 640
                : deviceSize,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
      );
      _tipsState = !_tipsState;
    });
  }

  List<int> _rowSize() {
    List<int> insertIndexes = [];

    for (var x = 0; x < widget.words.length; x++) {
      insertIndexes.add(4 - widget.words[x].indexOf(widget.mainWord[x]));
    }

    return [...insertIndexes];
  }

  String _shareResults() {
    String gameHeader = "Joguei cruzadinha.xyz!\n";
    if (_lives != null) {
      gameHeader += "Finalizado com ${_lives.toString()} vidas.\n\n";
    } else {
      gameHeader +=
          "Finalizado em ${Duration(seconds: 1800 - _timeLimit!).toString().substring(2, 7)}.\n\n";
    }
    String gameRH = "";
    int insertIndex = (4 - _rowSize().reduce(min));

    for (var x = 0; x < insertIndex; x++) {
      gameRH += "⬛";
    }
    gameRH += "🌟";

    for (var x = gameRH.length ~/ 2;
        x < (_rowSize().reduce(max) - _rowSize().reduce(min) + 3);
        x++) {
      gameRH += "⬛";
    }
    gameRH += "\n";

    for (var i = 0; i < widget.words.length; i++) {
      String column = "";
      int insertIndex = (4 - _rowSize().reduce(min)) -
          widget.words[i].indexOf(widget.mainWord[i]);

      for (var x = 0; x < insertIndex; x++) {
        column += "⬛";
      }

      for (var x = 0; x < widget.words[i].length; x++) {
        wordConversor(wordState[i].join('')) == wordConversor(widget.words[i])
            ? column += "🟩"
            : column += "🟥";
      }

      for (var x = column.length;
          x < (_rowSize().reduce(max) - _rowSize().reduce(min) + 10);
          x++) {
        column += "⬛";
      }

      gameRH += "$column\n";
    }

    return gameHeader + gameRH;
  }

  void giveUpF() async {
    if (_timeLimit != null) {
      setState(() {
        _stopWatch!.cancel();
        _timeLimit = 0;
      });

      await CookieService().setTimer(0);
    }
    if (_lives != null) {
      setState(() {
        _lives = 0;
      });

      await CookieService().setLives(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    if (_gameStatus()) {
      onInitColor(
        const Color(0xff3d405b),
        const Color(0xff3d405b),
        Brightness.light,
        Brightness.light,
      );
    }
    CookieService().setVersion(updates.last.version).then((value) =>
        value ? _openHeaderModal(context, const WelcomeWidget()) : null);
    return ScreenHolderWidget(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
            child: HeaderWidget(
              openModal: (BuildContext context, Widget widget) =>
                  _openHeaderModal(context, widget),
              showTips: () => _showTips(context, deviceSize.width),
              tipsState: _tipsState,
              changeGM: () => changeGM(),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: SizedBox(
              height: deviceSize.height * 0.86,
              width: deviceSize.width >= 640 ? 1280 : deviceSize.width * 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: deviceSize.width >= 640 ? 640 : deviceSize.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_lives != null && !_gameStatus())
                          GameTypeStatusWidget(
                            icon: Icons.favorite_rounded,
                            text: _lives.toString(),
                            openModal: (BuildContext context, Widget widget) =>
                                _openHeaderModal(context, widget),
                            giveUpF: () => giveUpF(),
                          ),
                        if (_timeLimit != null && !_gameStatus())
                          GameTypeStatusWidget(
                            icon: Icons.timer_rounded,
                            text: Duration(seconds: _timeLimit!)
                                .toString()
                                .substring(2, 7),
                            openModal: (BuildContext context, Widget widget) =>
                                _openHeaderModal(context, widget),
                            giveUpF: () => giveUpF(),
                          ),
                        if (_gameStatus())
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: TitleMessageWidget(
                              message: _lives != 0 && _timeLimit != 0
                                  ? "Incrível!"
                                  : "Quase!",
                              iconWidget: Icon(
                                Icons.share,
                                color: Colors.white.withOpacity(0.9),
                                size: 20,
                              ),
                              function: () {
                                Clipboard.setData(ClipboardData(
                                  text: _shareResults(),
                                ));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_shareSnack);
                              },
                            ),
                          ),
                        if (_lives != null || _stopWatch != null)
                          Padding(
                            padding: MediaQuery.of(context).size.height > 698
                                ? const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 16)
                                : const EdgeInsets.all(0),
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              constraints: BoxConstraints(
                                maxHeight: _gameStatus()
                                    ? deviceSize.height * 0.64
                                    : deviceSize.height > 700
                                        ? deviceSize.height * 0.4
                                        : deviceSize.height * 0.6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                color: Colors.white.withOpacity(0.06),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: CrossWordHolderWidget(
                                        wordSelected: _wordSelected,
                                        letterSelected: _letterSelected,
                                        words: widget.words,
                                        lives: _lives,
                                        timeLimit: _timeLimit,
                                        mainWord: widget.mainWord,
                                        selection: (int word, int letter) =>
                                            _selectLetter(word, letter),
                                        wordState: wordState.isNotEmpty
                                            ? wordState
                                            : [[]],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (!_gameStatus() &&
                            ((_lives != 0 && _lives != null) ||
                                (_timeLimit != 0 && _timeLimit != null)))
                          MediaQuery.of(context).size.height < 698
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: InlineKeyboardWidget(
                                    write: (String letter) {
                                      _addLetter(letter);
                                    },
                                    backspace: () {
                                      _removeLetter();
                                    },
                                  ),
                                )
                              : QwertyKeyboardWidget(
                                  write: (String letter) {
                                    _addLetter(letter);
                                  },
                                  backspace: () {
                                    _removeLetter();
                                  },
                                ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: deviceSize.width >= 640 ? 640 : deviceSize.width,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: CrossWordTipsWidget(
                        tips: widget.tips,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
