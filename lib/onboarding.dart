import 'package:film_explorer/services/onboarding_service.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/img_onboarding.png'),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [whiteColor.withOpacity(0), backgroundBlackColor.withOpacity(0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              backgroundBlendMode: BlendMode.colorBurn, // Mengatur mode blend untuk latar belakang
              // borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 70.0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [backgroundBlackColor.withOpacity(0), backgroundBlackColor.withOpacity(0.8)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  backgroundBlendMode: BlendMode.colorBurn, // Mengatur mode blend untuk latar belakang
                  // borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: backgroundColor.withOpacity(0.7),
                      blurRadius: 25.0,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "The ultimate guide to movies, TV shows, anime, and much more.",
                      style: whiteTextStyle.copyWith(
                        fontSize: 35,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Stay updated with information about movies, TV shows, anime, and much more..",
                      style: whiteTextStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: backgroundBlackColor,
                          borderRadius: BorderRadius.circular(
                            60,
                          )),
                      child: TextButton(
                        child: Text(
                          "Continue",
                          style: whiteTextStyle.copyWith(
                            fontWeight: semiBold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () async {
                          await OnboardingService().skipOnboarding().then((value) {
                            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          }); //for next time
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
