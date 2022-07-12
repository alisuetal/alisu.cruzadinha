import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as fWeb;

class ScreenHolderWidget extends StatelessWidget {
  final Widget content;
  const ScreenHolderWidget({required this.content, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenSize.height < 620 ? 620 : screenSize.height,
            maxWidth: 640,
            minWidth: 256,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: fWeb.kIsWeb ? 20 : 56),
            child: content,
          ),
        ),
      ),
    );
    // ;
  }
}
