import 'package:cruzadinha/utils/color_utilities.dart';
import 'package:flutter/material.dart';

class LetterLoadingHolderWidget extends StatelessWidget {
  final String letter;
  final int backgroundColor;

  const LetterLoadingHolderWidget({
    required this.letter,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  Color _backgroundColor(BuildContext context) {
    switch (backgroundColor) {
      case 0:
        return Theme.of(context).colorScheme.error;
      case 1:
        return Theme.of(context).colorScheme.background;
      default:
        return Theme.of(context).colorScheme.background;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 28,
          width: 28,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: ColorUtilities.lighten(_backgroundColor(context), 0.1),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Text(
              letter,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white.withOpacity(0.9)),
            ),
          ),
        ),
        SizedBox(
          height: 28,
          width: 28,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                width: 14,
                height: 2,
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: const Text(""),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
