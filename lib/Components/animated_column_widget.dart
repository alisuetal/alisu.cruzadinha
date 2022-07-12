import 'dart:async';
import 'package:cruzadinha/Components/letter_loading_holder_widget.dart';
import 'package:flutter/material.dart';

class AnimatedColumnWidget extends StatefulWidget {
  final int delay;
  final String letter;

  const AnimatedColumnWidget({
    required this.delay,
    required this.letter,
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedColumnWidget> createState() => _AnimatedColumnWidgetState();
}

class _AnimatedColumnWidgetState extends State<AnimatedColumnWidget> {
  double _height = 36;
  Future delay = Future.delayed(const Duration());

  @override
  void initState() {
    super.initState();
    delay = Future.delayed(Duration(milliseconds: 80 * widget.delay), () {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        _tickAnimation();
      });
    });
  }

  void _tickAnimation() {
    if (mounted) {
      setState(() {
        _height == 128 ? _height = 36 : _height = 128;
      });
    }
  }

  @override
  void dispose() {
    delay.ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
      height: _height,
      child: Column(children: [
        LetterLoadingHolderWidget(
          letter: widget.letter,
          backgroundColor: 1,
        ),
      ]),
    );
  }
}
