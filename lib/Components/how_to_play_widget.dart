import 'package:cruzadinha/Components/word_index_widget.dart';
import 'package:flutter/material.dart';

class HowToPlayWidget extends StatelessWidget {
  const HowToPlayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            children: [
              Text(
                "Como jogar",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Colors.white.withOpacity(0.9)),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: Colors.white.withOpacity(0.08),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                "O objetivo do jogo é descobrir a palavra principal, marcada com:",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: WordIndexWidget(
                    wordIndex: Icon(
                      Icons.star_rounded,
                      color: Colors.white.withOpacity(0.9),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                "Descubra as palavras com letras distribuídas verticalmente",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var index = 1; index < 6; index++)
                    WordIndexWidget(
                      wordIndex: Text(
                        index.toString(),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                ],
              ),
            ),
            Text(
              "para desbloquear uma letra da palavra principal a cada descoberta.",
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white.withOpacity(0.9)),
              textAlign: TextAlign.justify,
            ),
          ]),
        ),
      ],
    );
  }
}
