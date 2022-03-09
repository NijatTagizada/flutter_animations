import 'package:flutter/material.dart';

class CustomTransitionWidget extends StatefulWidget {
  const CustomTransitionWidget({
    Key? key,
    required this.controller,
    required this.child,
    required this.offset,
  }) : super(key: key);

  final Function(AnimationController controller) controller;
  final Widget child;
  final Offset offset;

  @override
  State<CustomTransitionWidget> createState() => _CustomTransitionWidgetState();
}

class _CustomTransitionWidgetState extends State<CustomTransitionWidget>
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
      begin: widget.offset,
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
