import 'package:cruzadinha/components/tip_widget.dart';
import 'package:cruzadinha/components/title_message_outline_widget.dart';
import 'package:flutter/material.dart';

class CrossWordTipsWidget extends StatelessWidget {
  final List<String> tips;

  const CrossWordTipsWidget({
    required this.tips,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> tipsWidgets = [];

    for (var x = 0; x < tips.length; x++) {
      tipsWidgets.add(Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TipWidget(index: x + 1, tip: tips[x]),
      ));
    }

    return SingleChildScrollView(
      controller: null,
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: TitleMessageOutlineWidget(message: "Dicas:"),
          ),
          ...tipsWidgets,
        ],
      ),
    );
  }
}
