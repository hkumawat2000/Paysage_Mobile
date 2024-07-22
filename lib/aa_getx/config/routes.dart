import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/login_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/pin_screen_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/terms_and_condition_webview_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/verify_otp_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/login_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/offline_customer_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/otp_verify_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/pin_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/terms_and_conditions_webview.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/bindings/splash_binding.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/jail_break_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/splash_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/walkthrough_view.dart';


const String splashView = "splash-view";
const String jailBreakView = "jail-break-view";
const String pinView = "pin-view";
const String loginView = "login-view";
const String tutorialsView = "tutorials-view";
const String offlineCustomerView = "offline-customer-view";
const String termsAndConditionsWebView = "terms-and-condition-web-view";
const String otpVerificationView = "otp-verification-view";
const String pinScreen = "pin-view";

LoginSubmitResquestEntity? loginSubmitResquestEntity;

List<GetPage> routes = [
  GetPage(
    name: '/$splashView',
    page: () => SplashView(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: '/$jailBreakView',
    page: () => JailBreakView(),
  ),
  GetPage(
    name: '/$pinView',
    page: () => PinScreenView(),
    binding: PinScreenBindings(),
  ),
  GetPage(
    name: '/$loginView',
    page: () => LoginView(),
    binding: LoginBindings(),
  ),
  GetPage(
    name: '/$tutorialsView',
    page: () => WalkthroughScreen()

  ),
  GetPage(
    name: '/$offlineCustomerView',
    page: () => OfflineCustomerScreen()
  ),
  GetPage(
    name: '/$termsAndConditionsWebView',
    page: () => TermsAndConditionsWebview(),
    binding: TermsAndConditionWebviewBindings(),
  ),
  GetPage(
    name: '/$otpVerificationView',
    page: () => OTPVerificationView(loginSubmitResquestEntity: loginSubmitResquestEntity!,),
    binding: VerifyOtpBindings(),
  ),
];
