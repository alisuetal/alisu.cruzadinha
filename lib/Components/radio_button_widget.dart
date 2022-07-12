import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RadioButtonWidget extends HookWidget {
  final int index;
  final int group;
  final void Function(int value) function;
  final String title;
  final String description;

  const RadioButtonWidget({
    required this.group,
    required this.index,
    required this.function,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 16,
        bottom: 16,
        right: 12,
        left: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Radio<int>(
            value: index,
            groupValue: group,
            onChanged: (int? value) => function(value!),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                Text(
                  description,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
