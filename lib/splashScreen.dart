import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper_app/main_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                "assets/lottie/Animation - 1719224624813.json"),
          ),
          const Text(
            "Classico",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                fontFamily: "Myfont"),
          )
        ],
      ),
      nextScreen: const MainPage(),
      splashIconSize: 400,
      backgroundColor: Colors.amberAccent,
      duration: 2500,
    );
  }
}
