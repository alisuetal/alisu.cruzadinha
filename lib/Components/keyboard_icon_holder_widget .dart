import 'package:flutter/material.dart';

class KeyboardIconHolderWidget extends StatelessWidget {
  final IconData icon;
  final void Function() function;

  const KeyboardIconHolderWidget({
    required this.function,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => function(),
            child: Center(
              child: Icon(
                icon,
                size: 18,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
