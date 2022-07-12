import 'package:cruzadinha/Components/disabled_word_holder_widget.dart';
import 'package:cruzadinha/Components/word_index_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FirstWordIndexWidget extends StatelessWidget {
  final List<String> words;
  final String mainWord;
  final int wordIndex;

  const FirstWordIndexWidget({
    required this.words,
    required this.mainWord,
    required this.wordIndex,
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
    int insertIndex = (4 - _rowSize().reduce(min));

    for (var x = 0; x <= insertIndex; x++) {
      letters.add(const DisabledLetterHolderWidget());
    }

    letters.add(
      WordIndexWidget(
        wordIndex: Icon(
          Icons.star_rounded,
          color: Colors.white.withOpacity(0.9),
          size: 18,
        ),
      ),
    );

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
