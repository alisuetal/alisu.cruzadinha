import 'package:flutter/material.dart';

class IconHolderWidget extends StatelessWidget {
  final Widget icon;
  final void Function() openModal;

  const IconHolderWidget(
      {required this.icon, required this.openModal, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          openModal();
        },
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Center(
            child: icon,
          ),
        ),
      ),
    );
  }
}
