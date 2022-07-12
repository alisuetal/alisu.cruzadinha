import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LetterHolderWidget extends HookWidget {
  final bool selectedWord;
  final bool selectedLetter;
  final String letter;
  final String letterState;
  final int letterIndex;
  final int wordIndex;
  final Function(int word, int letter) selection;
  final bool validateLetter;
  final bool validateState;
  final bool gameOver;

  const LetterHolderWidget({
    required this.letter,
    required this.letterState,
    required this.selectedWord,
    required this.selectedLetter,
    required this.letterIndex,
    required this.wordIndex,
    required this.selection,
    required this.validateLetter,
    required this.validateState,
    required this.gameOver,
    Key? key,
  });

  Color _backgroundColor(BuildContext context) {
    if (gameOver) {
      return Theme.of(context).errorColor.withOpacity(0.5);
    } else {
      if (validateLetter) {
        if (validateState) {
          return Theme.of(context).primaryColor;
        } else {
          return Theme.of(context).errorColor.withOpacity(0.3);
        }
      } else {
        return Colors.white.withOpacity(0.12);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final size = useState<double>(
      deviceWidth > 540 ? 32 : 28,
    );

    useEffect(
      () {
        if (letterState != "") {
          size.value += 8;
          Future.delayed(
            const Duration(milliseconds: 110),
            () => size.value -= 8,
          );
        }
        return null;
      },
      [letterState],
    );

    return GestureDetector(
      onTap: (!validateLetter || !validateState) && !gameOver
          ? () {
              selection(wordIndex, letterIndex);
            }
          : null,
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: size.value,
            width: size.value,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: _backgroundColor(context),
              border: Border.all(
                color: selectedWord && selectedLetter && !gameOver
                    ? Theme.of(context).primaryColor
                    : selectedWord && !gameOver
                        ? Theme.of(context).primaryColor.withOpacity(0.4)
                        : Colors.transparent,
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Center(
              child: Text(
                validateState
                    ? letter.toUpperCase()
                    : letterState.toUpperCase(),
                style: validateLetter && validateState
                    ? Theme.of(context).textTheme.bodyText2
                    : Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white.withOpacity(0.9)),
              ),
            ),
          ),
          if (selectedWord && selectedLetter && !gameOver)
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: size.value,
              width: size.value,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Container(
                    width: deviceWidth > 540 ? 18 : 14,
                    height: 2,
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    child: const Text(""),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
