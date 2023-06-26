import 'dart:async';

import 'package:film_explorer/home.dart';
import 'package:film_explorer/services/onboarding_service.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      if (await OnboardingService().checkOnboarding() == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                selectedIndex: 0,
              ),
            ),
            (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/icon_splash.png"),
      ),
    );
  }
}
