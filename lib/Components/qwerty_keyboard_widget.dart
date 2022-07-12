import 'package:cruzadinha/Components/keyboard_icon_holder_widget%20.dart';
import 'package:cruzadinha/Components/keyboard_letter_holder_widget.dart';
import 'package:flutter/material.dart';

class QwertyKeyboardWidget extends StatelessWidget {
  final void Function(String letter) write;
  final void Function() backspace;

  const QwertyKeyboardWidget({
    required this.backspace,
    required this.write,
    Key? key,
  }) : super(key: key);

  List<Widget> _fillers(int amount) {
    List<Widget> fillers = [];

    for (var x = 0; x < amount; x++) {
      fillers.add(
        const SizedBox(
          height: 28,
          width: 28,
        ),
      );
    }

    return [...fillers];
  }

  @override
  Widget build(BuildContext context) {
    List<String> letters = [];
    for (int i = 65; i <= 90; i++) {
      letters.add(String.fromCharCode(i));
    }

    List<Widget> keyboardLetters = [];
    for (var x = 0; x < letters.length; x++) {
      keyboardLetters.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: KeyboardLetterHolderWidget(
              letter: letters[x].toLowerCase(),
              function: (String letter) => write(letter)),
        ),
      );
    }

    keyboardLetters.add(
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: KeyboardIconHolderWidget(
          icon: Icons.backspace_rounded,
          function: () => backspace(),
        ),
      ),
    );

    List<Widget> keyboard = [];
    for (var x = 0; x < 5; x++) {
      keyboard.add(
        Padding(
          padding: EdgeInsets.only(
            top: x > 0 ? 8 : 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...keyboardLetters.take(keyboardLetters.length > 3 ? 6 : 3),
              ..._fillers(keyboardLetters.length > 3 ? 0 : 3)
            ],
          ),
        ),
      );
      keyboardLetters.removeRange(0, keyboardLetters.length > 3 ? 6 : 3);
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      child: Container(
        padding: const EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24,
          bottom: 32,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Icon(
                  Icons.more_horiz_rounded,
                  size: 28,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              ...keyboard
            ],
          ),
        ),
      ),
    );
  }
}
