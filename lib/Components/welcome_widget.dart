import 'package:cruzadinha/Components/word_index_widget.dart';
import 'package:cruzadinha/core/models/updates.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

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
                "Atualização ${updates.last.version}",
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
                updates.last.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.justify,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
