import 'package:cruzadinha/Components/giveup_form_widget.dart';
import 'package:flutter/material.dart';

class GameTypeStatusWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function(BuildContext context, Widget widget) openModal;
  final void Function() giveUpF;

  const GameTypeStatusWidget({
    required this.icon,
    required this.text,
    required this.openModal,
    required this.giveUpF,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 176,
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => openModal(
              context,
              GiveUpFormWidget(
                giveUpF: () => giveUpF(),
              ),
            ),
            child: Text(
              "Desistir",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
