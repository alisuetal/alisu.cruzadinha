import 'package:cruzadinha/Components/animated_column_widget.dart';
import 'package:flutter/material.dart';

import '../utils/tools.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    onInitColor(
      const Color(0xff3d405b),
      const Color(0xff3d405b),
      Brightness.light,
      Brightness.light,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> letter = [];
    String word = "carregando";

    for (var x = 1; x <= word.length; x++) {
      letter.add(
        Padding(
          padding:
              x != 1 ? const EdgeInsets.only(left: 4) : const EdgeInsets.all(0),
          child: AnimatedColumnWidget(
            delay: x - 0,
            letter: word[x - 1],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...letter],
        ),
      ),
    );
  }
}
