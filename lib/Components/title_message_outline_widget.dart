import 'package:flutter/material.dart';

class TitleMessageOutlineWidget extends StatelessWidget {
  final String message;

  const TitleMessageOutlineWidget({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 28,
          width: 128,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 14, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
