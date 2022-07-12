import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 16,
          ),
          child: Text(
            "Sobre o projeto",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(color: Colors.white.withOpacity(0.9)),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => launchUrl(
              Uri.parse('https://github.com/alisuetal/cruzadinha'),
            ),
            child: Container(
              height: 102,
              width: double.infinity,
              padding: const EdgeInsets.only(
                  top: 16, left: 20, right: 20, bottom: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                color: Colors.white.withOpacity(0.08),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(36),
                          ),
                          child: Image.network(
                              'https://avatars.githubusercontent.com/u/46061416?v=4'),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alisu",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white.withOpacity(0.9)),
                          ),
                          Text(
                            "Criador",
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(
                    Icons.link,
                    color: Colors.white.withOpacity(0.9),
                    size: 32,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
