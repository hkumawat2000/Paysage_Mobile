import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/arguments/tutotrials_arguments.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/controllers/walkthrough_controller.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/walkthrough_view.dart';
import 'package:lms/login/LoginScreen.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/splash/JailBreakScreen.dart';
import 'package:lms/splash/TutorialScreen.dart';

import '../modules/onboarding/presentation/bindings/splash_binding.dart';
import '../modules/onboarding/presentation/views/splash_view.dart';

const String splashView = "splash-view";
const String jailBreakView = "jail-break-view";
const String pinView = "pin-view";
const String loginView = "login-view";
const String tutorialsView = "tutorials-view";

List<GetPage> routes = [
  GetPage(
    name: '/$splashView',
    page: () => SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/$jailBreakView',
    page: () => JailBreakScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/$pinView',
    page: () => PinScreen(false),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/$loginView',
    page: () => LoginScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/$tutorialsView',
    page: () => WalkthroughScreen()
  ),
];
