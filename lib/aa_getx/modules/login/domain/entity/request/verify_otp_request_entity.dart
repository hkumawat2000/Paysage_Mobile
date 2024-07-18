// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerifyOtpRequestEntity {
  dynamic mobileNumber;
  dynamic otp;
  dynamic firebase_token;
  String? platform;
  String? appVersion;

  VerifyOtpRequestEntity({
    required this.mobileNumber,
    required this.otp,
    required this.firebase_token,
    required this.platform,
    required this.appVersion,
  });
}
