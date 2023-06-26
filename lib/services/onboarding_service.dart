import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  Future<void> skipOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Write value
    await prefs.setBool('onboarding_skip', true);
    print(await checkOnboarding());
  }

  Future<bool> checkOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get value
    bool value = prefs.getBool('onboarding_skip') ?? false;
    return value;
  }
}
