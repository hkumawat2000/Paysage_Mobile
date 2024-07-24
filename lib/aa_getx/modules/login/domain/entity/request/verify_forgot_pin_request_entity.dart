class VerifyForgotPinRequestEntity {
  String? email;
  String? otp;
  String? newPin;
  String? retypePin;

  VerifyForgotPinRequestEntity({
   required this.email,
   required this.otp,
   required this.newPin,
   required this.retypePin,
  });
}
