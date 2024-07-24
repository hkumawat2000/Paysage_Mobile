import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/forgot_pin_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/login_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/pin_screen_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/terms_and_condition_webview_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/bindings/verify_otp_bindings.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/forgot_pin_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/login_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/offline_customer_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/otp_verify_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/pin_screen.dart';
import 'package:lms/aa_getx/modules/login/presentation/screens/terms_and_conditions_webview.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/bindings/splash_binding.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/jail_break_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/splash_view.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/bindings/enable_fingerprint_dialog_binding.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/bindings/fingerprint_binding.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/views/enable_fingerprint_dialog_view.dart';
import 'package:lms/aa_getx/modules/authentication/presentation/views/fingerprint_view.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/views/walkthrough_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/offline_customer_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/registration_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/bindings/set_pin_binding.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/offline_customer_screen.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/registration_successful_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/registration_view.dart';
import 'package:lms/aa_getx/modules/registration/presentation/views/set_pin_view.dart';
import 'package:lms/login/LoginScreen.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/splash/JailBreakScreen.dart';


const String splashView = "splash-view";
const String jailBreakView = "jail-break-view";
const String pinView = "pin-view";
const String loginView = "login-view";
const String tutorialsView = "tutorials-view";
const String offlineCustomerView = "offline-customer-view";
const String termsAndConditionsWebView = "terms-and-condition-web-view";
const String otpVerificationView = "otp-verification-view";
const String pinScreen = "pin-view";
const String setPinView = "set-pin-view";
const String forgotPinView = "forgot-pin-view";
const String registrationView = "registration-view";
const String fingerPrintView = "fingerprint-view";
const String enableFingerPrintView = "enable-fingerprint-view";
const String registrationSuccessfulView = "registration-successful-view";
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
    name: '/$forgotPinView',
    page: () => ForgotPinScreen(),
    binding: ForgotPinBindings(),
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
  GetPage(
    name: '/$registrationView',
    page: () => RegistrationView(),
    binding: RegistrationBinding(),
  ),
  GetPage(
    name: '/$fingerPrintView',
    page: () => FingerPrintView(),
    binding: FingerprintBinding(),
  ),
  GetPage(
    name: '/$enableFingerPrintView',
    page: () => EnableFingerPrintDialog(),
    binding: EnableFingerprintBinding(),
  ),
  GetPage(
    name: '/$registrationSuccessfulView',
    page: () => RegistrationSuccessfulView(),
  ),
];
