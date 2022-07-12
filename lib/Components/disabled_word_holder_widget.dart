import 'package:flutter/material.dart';

class DisabledLetterHolderWidget extends StatelessWidget {
  const DisabledLetterHolderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: deviceWidth > 540 ? 32 : 28,
      width: deviceWidth > 540 ? 32 : 28,
    );
  }
}
