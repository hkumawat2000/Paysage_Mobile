import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/walkthrough_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/offline_customer_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/set_pin_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/offline_customer_screen.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/set_pin_view.dart';
import 'package:lms/login/LoginScreen.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/splash/JailBreakScreen.dart';

import '../modules/onboarding/presentation/bindings/splash_binding.dart';
import '../modules/onboarding/presentation/views/splash_view.dart';

const String splashView = "splash-view";
const String jailBreakView = "jail-break-view";
const String pinView = "pin-view";
const String loginView = "login-view";
const String tutorialsView = "tutorials-view";
const String setPinView = "set-pin-view";
const String offlineCustomerView = "offline-customer-view";

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
  GetPage(
      name: '/$setPinView',
      page: () => SetPinView(),
      binding: SetPinBinding(),
  ),
  GetPage(
    name: '/$offlineCustomerView',
    page: () => OfflineCustomerView(),
    binding: OfflineCustomerBinding(),
  ),
];
