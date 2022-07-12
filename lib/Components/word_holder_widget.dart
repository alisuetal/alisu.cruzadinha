import 'package:cruzadinha/Components/disabled_word_holder_widget.dart';
import 'package:cruzadinha/Components/letter_holder_widget.dart';
import 'package:cruzadinha/Components/word_index_widget.dart';
import 'package:cruzadinha/utils/tools.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';

class WordHolderWidget extends HookWidget {
  final List<String> words;
  final String mainWord;
  final int wordIndex;
  final List<String> wordState;
  final bool selectedWord;
  final int selectedWordIndex;
  final Function(int word, int letter) selection;
  final int? timeLimit;
  final int? lives;

  const WordHolderWidget({
    required this.words,
    required this.mainWord,
    required this.wordIndex,
    required this.wordState,
    required this.selectedWord,
    required this.selectedWordIndex,
    required this.selection,
    required this.timeLimit,
    required this.lives,
    Key? key,
  }) : super(key: key);

  List<int> _rowSize() {
    List<int> insertIndexes = [];

    for (var x = 0; x < words.length; x++) {
      insertIndexes.add(4 - words[x].indexOf(mainWord[x]));
    }

    return [...insertIndexes];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> letters = [];
    int insertIndex = (4 - _rowSize().reduce(min)) -
        words[wordIndex].indexOf(mainWord[wordIndex]);

    for (var x = 0; x < insertIndex; x++) {
      letters.add(const DisabledLetterHolderWidget());
    }

    letters.add(
      WordIndexWidget(
        wordIndex: Text((wordIndex + 1).toString(),
            style: Theme.of(context).textTheme.bodyText2!),
      ),
    );

    for (var x = 0; x < words[wordIndex].length; x++) {
      letters.add(MouseRegion(
        cursor: SystemMouseCursors.click,
        child: LetterHolderWidget(
          gameOver: lives == 0 || timeLimit == 0,
          selectedLetter: selectedWord && selectedWordIndex == x,
          selectedWord: selectedWord,
          letter: words[wordIndex][x],
          letterState: wordState.isNotEmpty ? wordState[x] : "",
          letterIndex: x,
          wordIndex: wordIndex,
          selection: (int word, int letter) => selection(word, letter),
          validateLetter: wordState.where((element) => element.isEmpty).isEmpty,
          validateState: wordConversor(wordState.join('')) ==
              wordConversor(words[wordIndex]),
        ),
      ));
    }

    for (var x = letters.length;
        x < (_rowSize().reduce(max) - _rowSize().reduce(min) + 6);
        x++) {
      letters.add(const DisabledLetterHolderWidget());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [...letters],
    );
  }
}
