import 'package:cruzadinha/Components/button_widget.dart';
import 'package:flutter/material.dart';

class SettingsCardWidget extends StatelessWidget {
  final void Function() changeGM;

  const SettingsCardWidget({
    required this.changeGM,
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
            "Configurações",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white.withOpacity(0.9)),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ButtonWidget(
            text: "Alterar modo de jogo",
            function: () {
              changeGM();
            },
          ),
        )
      ],
    );
  }
}
