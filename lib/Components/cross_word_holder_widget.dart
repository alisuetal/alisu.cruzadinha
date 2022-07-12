import 'dart:math';

import 'package:cruzadinha/Components/first_word_index_widget.dart';
import 'package:cruzadinha/Components/word_holder_widget.dart';
import 'package:flutter/material.dart';

class CrossWordHolderWidget extends StatefulWidget {
  final List<String> words;
  final String mainWord;
  final int wordSelected;
  final int letterSelected;
  final List<List<String>> wordState;
  final Function(int word, int letter) selection;
  final int? timeLimit;
  final int? lives;

  const CrossWordHolderWidget({
    required this.letterSelected,
    required this.wordSelected,
    required this.words,
    required this.mainWord,
    required this.wordState,
    required this.selection,
    required this.timeLimit,
    required this.lives,
    Key? key,
  }) : super(key: key);

  @override
  State<CrossWordHolderWidget> createState() => _CrossWordHolderWidgetState();
}

class _CrossWordHolderWidgetState extends State<CrossWordHolderWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> words = [];

    if (widget.words.length == widget.wordState.length) {
      for (var x = 0; x < widget.words.length; x++) {
        words.add(
          Column(
            children: [
              Expanded(
                child: WordHolderWidget(
                  words: widget.words,
                  mainWord: widget.mainWord,
                  wordIndex: x,
                  lives: widget.lives,
                  timeLimit: widget.timeLimit,
                  wordState: widget.wordState[x],
                  selectedWord: widget.wordSelected == x,
                  selectedWordIndex: widget.letterSelected,
                  selection: (int word, int letter) =>
                      widget.selection(word, letter),
                ),
              ),
            ],
          ),
        );
      }
    }

    int _rowSize() {
      List<int> insertIndexes = [];

      for (var x = 0; x < widget.words.length; x++) {
        insertIndexes.add(4 - widget.words[x].indexOf(widget.mainWord[x]));
      }

      return insertIndexes.reduce(max) - insertIndexes.reduce(min) + 9;
    }

    return SingleChildScrollView(
      controller: null,
      scrollDirection: Axis.vertical,
      child: SizedBox(
        height: _rowSize() * 36,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FirstWordIndexWidget(
              words: widget.words,
              mainWord: widget.mainWord,
              wordIndex: 0,
            ),
            ...words,
          ],
        ),
      ),
    );
  }
}
