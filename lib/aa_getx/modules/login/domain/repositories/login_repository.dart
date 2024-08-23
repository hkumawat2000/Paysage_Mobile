import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_profile_and_set_alert_details_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/get_profile_and_set_alert_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/pin_screen_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';

/// LoginRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract class LoginRepository {

ResultFuture<GetTermsandPrivacyResponseEntity> getTermsAndPrivacyUrl();
ResultFuture<AuthLoginResponseEntity> loginSubmit(LoginSubmitResquestEntity loginSubmitResquestEntity);
ResultFuture<AuthLoginResponseEntity> verifyOtp(VerifyOtpRequestEntity verifyOtpRequestEntity);
ResultFuture<AuthLoginResponseEntity> getPin(PinScreenRequestEntity pinscreenRequestEntity);
ResultFuture<AuthLoginResponseEntity> forgotPinOtp(ForgotPinRequestEntity forgotPinRequestEntity);
ResultFuture<AuthLoginResponseEntity> verifyForgotPinOtp(VerifyForgotPinRequestEntity verifyforgotPinRequestEntity);
ResultFuture<GetProfileAndSetAlertDetailsResponseEntity> getProfileandSetAlert(GetProfileAndSetAlertRequestEntity getProfileAndSetAlertRequestEntity);



}