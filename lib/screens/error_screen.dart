import 'package:cruzadinha/Components/letter_loading_holder_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/tools.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    onInitColor(
      Theme.of(context).colorScheme.error.withOpacity(0.9),
      Theme.of(context).colorScheme.error.withOpacity(0.9),
      Brightness.dark,
      Brightness.dark,
    );
    List<Widget> letter = [];
    String word = "erro";

    for (var x = 1; x <= word.length; x++) {
      letter.add(
        Padding(
          padding:
              x != 1 ? const EdgeInsets.only(left: 4) : const EdgeInsets.all(0),
          child: LetterLoadingHolderWidget(
            letter: word[x - 1],
            backgroundColor: 0,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Parece que algo deu errado...",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...letter,
            ],
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: InkWell(
              onTap: () => launchUrl(
                Uri.parse('https://github.com/alisuetal'),
              ),
              child: Text(
                "Acredita ter achado um bug? Me contate!",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
