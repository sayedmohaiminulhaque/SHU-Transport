import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_map_live/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Image.asset('Image/busLocation.png'),
            Text('SHU TRANSPORT',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      nextScreen: Myapp(),
      backgroundColor: Colors.white,
      splashIconSize: 1000,
      splashTransition: SplashTransition.slideTransition,
      animationDuration: const Duration(seconds: 1),

    );
  }
}
