import 'package:cruzadinha/Components/button_widget.dart';
import 'package:flutter/material.dart';

import 'ghost_button_widget.dart';

class GiveUpFormWidget extends StatelessWidget {
  final void Function() giveUpF;

  const GiveUpFormWidget({
    required this.giveUpF,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: Text(
            "Desistir?",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white.withOpacity(0.9)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GhostButtonWidget(
              text: "Desistir",
              function: () {
                giveUpF();
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ButtonWidget(
            text: "Voltar",
            function: () {
              Navigator.of(context).pop();
            },
          ),
        )
      ],
    );
  }
}
