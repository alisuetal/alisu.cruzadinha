import 'package:flutter/material.dart';

class WordIndexWidget extends StatelessWidget {
  final Widget wordIndex;

  const WordIndexWidget({required this.wordIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceWidth > 540 ? 32 : 28,
      width: deviceWidth > 540 ? 32 : 28,
      child: Center(
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: Color(Theme.of(context).primaryColor.value),
          ),
          child: Center(
            child: wordIndex,
          ),
        ),
      ),
    );
  }
}
