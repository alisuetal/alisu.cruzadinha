import 'package:cruzadinha/Components/button_widget.dart';
import 'package:cruzadinha/Components/radio_button_widget.dart';
import 'package:cruzadinha/Components/screen_holder_widget.dart';
import 'package:cruzadinha/utils/tools.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChooseGameStyleScreen extends HookWidget {
  void _backToGame(
    BuildContext context,
    int gStyle,
  ) async {
    Navigator.pop(context, gStyle == 0 ? false : true);
  }

  @override
  Widget build(BuildContext context) {
    onInitColor(
      const Color(0xff3d405b),
      const Color(0xff3d405b),
      Brightness.light,
      Brightness.light,
    );
    final gStyle = useState(0);
    return ScreenHolderWidget(
      content: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Escolha o seu modo de jogo",
              style: Theme.of(context).textTheme.headline1!.copyWith(
                    fontSize: 28,
                    color: Colors.white.withOpacity(0.9),
                  ),
            ),
            DottedBorder(
              borderType: BorderType.Circle,
              color: Colors.white30,
              dashPattern: const [6],
              strokeWidth: 4,
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(128)),
                ),
                child: Icon(
                  gStyle.value == 0
                      ? Icons.timer_rounded
                      : Icons.favorite_rounded,
                  size: 56,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GestureDetector(
                    onTap: () => gStyle.value = 0,
                    child: RadioButtonWidget(
                      group: gStyle.value,
                      index: 0,
                      function: (int value) => {},
                      title: "Tempo",
                      description: "Você terá 30 minutos para resolver o jogo.",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: GestureDetector(
                    onTap: () => gStyle.value = 1,
                    child: RadioButtonWidget(
                      group: gStyle.value,
                      index: 1,
                      function: (int value) => gStyle.value = value,
                      title: "Vidas",
                      description:
                          "Você terá 5 tentativas para resolver o jogo.",
                    ),
                  ),
                ),
                ButtonWidget(
                  text: "Confirmar",
                  function: () => _backToGame(context, gStyle.value),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 8),
                //   child: Text(
                //     "Ao alterar o modo de jogo, seu progresso será perdido.",
                //     style: Theme.of(context).textTheme.headline1!.copyWith(
                //           fontSize: 16,
                //           color: Colors.white.withOpacity(0.6),
                //         ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
