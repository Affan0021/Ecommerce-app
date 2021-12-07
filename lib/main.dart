import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MaterialApp(
    home: AnimatedSplashScreen(
      backgroundColor: Colors.blueGrey,
      splash: Image.asset(
        'assets/logo.png',
      ),
      splashIconSize: 100,
      nextScreen: Main(),
      splashTransition: SplashTransition.rotationTransition,
      duration: 50000,
    ),
  ));
}





class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);


  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}





