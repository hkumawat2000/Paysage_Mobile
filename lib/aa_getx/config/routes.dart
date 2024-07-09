import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lms/login/LoginScreen.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/splash/JailBreakScreen.dart';

import '../modules/onboarding/presentation/bindings/splash_binding.dart';
import '../modules/onboarding/presentation/views/splash_view.dart';

const String splashView = "splash-view";
const String jailBreakView = "jail-break-view";
const String pinView = "pin-view";
const String loginView = "login-view";

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
];
