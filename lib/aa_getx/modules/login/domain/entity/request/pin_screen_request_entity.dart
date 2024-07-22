class PinScreenRequestEntity {
  dynamic mobileNumber;
  dynamic pin;
  dynamic firebase_token;
  dynamic acceptTerms;
  String? platform;
  String? appversion;

  PinScreenRequestEntity({
    required this.mobileNumber,
    required this.pin,
    required this.firebase_token,
    required this.acceptTerms,
    required this.platform,
    required this.appversion,
  });
}