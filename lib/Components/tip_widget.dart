import 'package:cruzadinha/Components/word_index_widget.dart';
import 'package:flutter/material.dart';

class TipWidget extends StatelessWidget {
  final int index;
  final String tip;

  const TipWidget({
    required this.index,
    required this.tip,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WordIndexWidget(
          wordIndex: Text(index.toString(),
              style: Theme.of(context).textTheme.bodyText2!),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white12,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                tip,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
