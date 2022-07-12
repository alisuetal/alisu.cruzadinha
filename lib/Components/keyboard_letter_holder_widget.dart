import 'package:flutter/material.dart';

class KeyboardLetterHolderWidget extends StatelessWidget {
  final String letter;
  final void Function(String letter) function;

  const KeyboardLetterHolderWidget({
    required this.function,
    required this.letter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        height: 28,
        width: 28,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => function(letter),
            child: Center(
              child: Text(letter.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyText2!),
            ),
          ),
        ),
      ),
    );
  }
}
