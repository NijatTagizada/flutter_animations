import 'package:flutter/material.dart';
import 'package:flutter_animations/transition_direction.dart';

class FadeTransitionWidget extends StatefulWidget {
  const FadeTransitionWidget({
    Key? key,
    required this.controller,
    required this.child,
    this.direction = TransitionDirection.leftIn,
  }) : super(key: key);

  final Function(AnimationController controller) controller;
  final Widget child;
  final TransitionDirection direction;

  @override
  State<FadeTransitionWidget> createState() => _FadeTransitionWidgetState();
}

class _FadeTransitionWidgetState extends State<FadeTransitionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> transitionAnim;
  late Animation<double> opacityAnim;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    opacityAnim = Tween<double>(begin: 0, end: 1).animate(controller);

    late Offset offset;

    switch (widget.direction) {
      case TransitionDirection.leftIn:
        offset = const Offset(-0.5, 0.0);
        break;
      case TransitionDirection.rightIn:
        offset = const Offset(0.5, 0.0);
        break;
      case TransitionDirection.topIn:
        offset = const Offset(0.0, -0.5);
        break;
      case TransitionDirection.bottomIn:
        offset = const Offset(0.0, 0.5);
        break;
    }

    transitionAnim = Tween<Offset>(
      begin: offset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.3,
          1,
          curve: Curves.linear,
        ),
      ),
    );

    widget.controller(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? c) {
        return SlideTransition(
          position: transitionAnim,
          child: Opacity(
            opacity: opacityAnim.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
