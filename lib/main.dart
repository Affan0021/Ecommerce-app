import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'login.dart';
void main() {
  runApp(MaterialApp(
    //Animated splash screen
    home: Login(),

    // AnimatedSplashScreen(
    //   backgroundColor: Colors.blueGrey,
    //   splash: Image.asset(
    //     'assets/logo.png',
    //   ),
    //   splashIconSize: 100,
    //   nextScreen: Login(),
    //   splashTransition: SplashTransition.rotationTransition,
    //   duration: 50000,

  ));
}


