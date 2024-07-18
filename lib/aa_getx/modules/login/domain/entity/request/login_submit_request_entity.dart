class LoginSubmitResquestEntity {
  dynamic mobileNumber;
  dynamic firebase_token;
  dynamic acceptTerms;
  String? platform;
  String? appVersion;

  LoginSubmitResquestEntity({
    required this.mobileNumber,
    required this.firebase_token,
    required this.acceptTerms,
    required this.platform,
    required this.appVersion,
  });
}
