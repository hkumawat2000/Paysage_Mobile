import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AppButton extends StatefulWidget {

  final double? buttonHeight;
  final double? buttonWidth;
  final VoidCallback? onClick;
  final BoxDecoration? baseDecoration;
  final BoxDecoration? topDecoration;
  final Widget? child;
  final BorderRadius? borderRadius;

  const AppButton({super.key,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.onClick,
    required this.child,
    this.baseDecoration,
    this.topDecoration,
    this.borderRadius,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {

  bool buttonPressed = false;
  bool animationCompleted = true;
  bool get _enabled => widget.onClick != null;
  bool get _disabled => !_enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _disabled ? 0.5 : 1,
      child: GestureDetector(
        onTap: () {
          if (!_disabled) {
            setState(() {
              buttonPressed = true;
              animationCompleted = false;
            });
          }
        },
        child: SizedBox(
          height: widget.buttonHeight,
          width: widget.buttonWidth,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: (widget.buttonWidth ?? 100) - 10,
                  height: (widget.buttonHeight ?? 40) - 10,
                  decoration: widget.baseDecoration?.copyWith(
                    borderRadius: widget.borderRadius,
                  ) ?? BoxDecoration(
                    color: colorTransparent,
                    border: Border.all(color: colorBlack),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: _enabled ? (buttonPressed ? 0 : 4) : 4,
                right: _enabled ? (buttonPressed ? 0 : 4) : 4,
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                onEnd: () {
                  if (!animationCompleted) {
                    animationCompleted = true;
                    setState(() => buttonPressed = false);
                    if (_enabled) {
                      widget.onClick!();
                    }
                  }
                },
                child: Container(
                  width: (widget.buttonWidth ?? 100) - 10,
                  height: (widget.buttonHeight ?? 100) - 10,
                  alignment: Alignment.center,
                  decoration: widget.topDecoration?.copyWith(
                    borderRadius: widget.borderRadius,
                  ) ?? BoxDecoration(
                    color: _disabled ? colorGrey : colorBlue,
                    border: Border.all(color: _disabled ? colorGrey : colorBlue),
                  ),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
