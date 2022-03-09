import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/custom_transition_widget.dart';

import 'transition_direction.dart';
import 'widgets/animated_button.dart';
import 'widgets/fade_transition_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AnimationController leftCtrl;
  late AnimationController rightCtrl;
  late AnimationController bottomCtrl;
  late AnimationController topCtrl;
  late AnimationController customCtrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homa Page',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedButton(
                onTap: () {
                  topCtrl.reset();
                  leftCtrl.reset();
                  rightCtrl.reset();
                  bottomCtrl.reset();
                  customCtrl.reset();

                  topCtrl.forward();
                  leftCtrl.forward();
                  rightCtrl.forward();
                  bottomCtrl.forward();
                  customCtrl.forward();
                },
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransitionWidget(
                    direction: TransitionDirection.topIn,
                    controller: (controller) {
                      topCtrl = controller;
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FadeTransitionWidget(
                    direction: TransitionDirection.leftIn,
                    controller: (controller) {
                      leftCtrl = controller;
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  FadeTransitionWidget(
                    direction: TransitionDirection.bottomIn,
                    controller: (controller) {
                      bottomCtrl = controller;
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: const Color.fromARGB(255, 110, 185, 243),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FadeTransitionWidget(
                    direction: TransitionDirection.rightIn,
                    controller: (controller) {
                      rightCtrl = controller;
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      color: const Color.fromARGB(255, 188, 146, 255),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              CustomTransitionWidget(
                controller: (controller) {
                  customCtrl = controller;
                },
                offset: const Offset(-1.5, 3),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
