import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/fade_in_down_transition.dart';

import 'widgets/animated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: Column(children: [
          AnimatedButton(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pressed'),
                  duration: Duration(milliseconds: 200),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          FadeInDownTransition(
            controller: (controller) {
              controller.forward();
            },
            child: Container(
              width: 80,
              height: 80,
              color: Colors.orange,
            ),
          ),
        ]),
      ),
    );
  }
}
