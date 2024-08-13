// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilOtpVerificationResponseEntity {
  String? message;
  CibilOtpVerificationResponseDataEntity? otpVerityDataEntity;
  
  CibilOtpVerificationResponseEntity({
    this.message,
    this.otpVerityDataEntity,
  });
}

class CibilOtpVerificationResponseDataEntity {
  int? cibilScore;
  CibilOtpVerificationResponseDataEntity({
    this.cibilScore,
  });
}
