import 'package:cruzadinha/Components/keyboard_icon_holder_widget%20.dart';
import 'package:cruzadinha/Components/keyboard_letter_holder_widget.dart';
import 'package:flutter/material.dart';

class InlineKeyboardWidget extends StatelessWidget {
  final Function(String letter) write;
  final void Function() backspace;

  const InlineKeyboardWidget({
    required this.write,
    required this.backspace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> letters = [];
    for (int i = 65; i <= 90; i++) {
      letters.add(String.fromCharCode(i));
    }

    List<Widget> keyboard = [];

    for (var x = 0; x < letters.length; x++) {
      keyboard.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).primaryColor,
              child: KeyboardLetterHolderWidget(
                letter: letters[x].toLowerCase(),
                function: (String letter) => write(letter),
              ),
            ),
          ),
        ),
      );
    }

    keyboard.add(
      MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).primaryColor,
            child: KeyboardIconHolderWidget(
              icon: Icons.backspace_rounded,
              function: () => backspace(),
            ),
          ),
        ),
      ),
    );

    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(
            width: (44 * 30) + 12 * 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...keyboard,
              ],
            ),
          )
        ],
      ),
    );
  }
}
