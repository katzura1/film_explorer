import 'package:film_explorer/home.dart';
import 'package:film_explorer/onboarding.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: whiteColor),
          titleTextStyle: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      ),
      routes: {
        '/': (context) => const Splash(),
        '/onboarding': (context) => const Onboarding(),
        '/home': (context) => Home(),
      },
    );
  }
}
