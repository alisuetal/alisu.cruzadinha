import 'package:cruzadinha/Components/how_to_play_widget.dart';
import 'package:cruzadinha/Components/icon_holder_widget.dart';
import 'package:cruzadinha/Components/profile_card_widget.dart';
import 'package:cruzadinha/Components/settings_form_widget.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final void Function(BuildContext context, Widget widget) openModal;
  final void Function() showTips;
  final void Function() changeGM;
  final bool tipsState;

  const HeaderWidget({
    required this.openModal,
    required this.showTips,
    required this.tipsState,
    required this.changeGM,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconHolderWidget(
              openModal: () => openModal(context, const HowToPlayWidget()),
              icon: Text(
                "?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            IconHolderWidget(
              openModal: () => showTips(),
              icon: Icon(
                tipsState ? Icons.abc_rounded : Icons.lightbulb_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 18,
              ),
            ),
          ],
        ),
        Text(
          "Cruzadinha",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white.withOpacity(0.9)),
        ),
        Row(
          children: [
            IconHolderWidget(
              openModal: () => openModal(context, const ProfileCardWidget()),
              icon: Icon(
                Icons.article_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 20,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            // IconHolderWidget(
            //   openModal: () => openModal(
            //       context, SettingsCardWidget(changeGM: () => changeGM())),
            //   icon: Icon(
            //     Icons.settings_rounded,
            //     color: Colors.white.withOpacity(0.9),
            //     size: 20,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
