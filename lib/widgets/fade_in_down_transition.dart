import 'package:flutter/material.dart';

class FadeInDownTransition extends StatefulWidget {
  const FadeInDownTransition({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final Function(AnimationController controller) controller;
  final Widget child;

  @override
  State<FadeInDownTransition> createState() => _FadeInDownTransitionState();
}

class _FadeInDownTransitionState extends State<FadeInDownTransition>
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

    transitionAnim = Tween<Offset>(
      begin: const Offset(0.0, -0.5),
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
