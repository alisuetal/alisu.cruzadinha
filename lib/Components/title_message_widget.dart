import 'package:flutter/material.dart';

class TitleMessageWidget extends StatefulWidget {
  final String message;
  final Widget? iconWidget;
  final void Function()? function;

  const TitleMessageWidget({
    required this.message,
    required this.iconWidget,
    required this.function,
    Key? key,
  }) : super(key: key);

  @override
  State<TitleMessageWidget> createState() => _TitleMessageWidgetState();
}

class _TitleMessageWidgetState extends State<TitleMessageWidget> {
  double _width = 0;
  Future delay = Future.delayed(const Duration());

  @override
  void initState() {
    super.initState();
    delay = Future.delayed(const Duration(milliseconds: 50), () {
      _tickAnimation();
    });
  }

  void _tickAnimation() {
    if (mounted) {
      setState(() {
        _width = 160;
      });
    }
  }

  @override
  void dispose() {
    delay.ignore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(18)),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.ease,
            height: 36,
            width: _width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: widget.function,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.message,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      if (widget.iconWidget != null) widget.iconWidget!,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
