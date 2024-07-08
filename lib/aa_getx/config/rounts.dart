import 'package:get/get_navigation/src/routes/get_route.dart';

import '../modules/onboarding/presentation/bindings/splash_binding.dart';
import '../modules/onboarding/presentation/views/splash_view.dart';

const String splashView = "splash-view";

List<GetPage> routes = [
  GetPage(
    name: '/$splashView',
    page: () => SplashView(),
    binding: SplashBinding(),
  ),
];