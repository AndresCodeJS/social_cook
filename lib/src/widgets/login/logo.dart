import 'package:flutter/material.dart';

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Column(
        children: [
          AnimatedSize(
            curve: Curves.easeIn,
            duration: const Duration(microseconds: 500),
            child: Image.asset(
              "assets/sombrero.png",
              color: Colors.white,
              height: isKeyboardVisible ? 150 : 200,
            ),
          ),
          AnimatedOpacity(
            opacity: isKeyboardVisible ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 500),
            child: const Text("Social Cook",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Gloria Hallelujah",
                    fontSize: 40)),
          ),
        ],
      );
    });
  }
}
