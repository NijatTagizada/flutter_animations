import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.15,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () {
        widget.onTap();
      },
      child: Transform.scale(
        scale: _scale,
        child: _animatedButtonUI,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  Widget get _animatedButtonUI => Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 141, 183, 255),
              Color.fromARGB(255, 64, 131, 255),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Press Me',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
