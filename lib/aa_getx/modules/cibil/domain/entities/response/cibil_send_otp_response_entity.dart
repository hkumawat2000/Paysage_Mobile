// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilSendOtpResponseEntity {
  String? message;
  CibilSendOtpResponseDataEntity? cibilOtpDataEntity;
  
  CibilSendOtpResponseEntity({
    this.message,
    this.cibilOtpDataEntity,
  });
}


class CibilSendOtpResponseDataEntity {
  String? errorMessage;
  String? stdOneHitID;
  String? stdTwoHitId;
  String? otpGenerationStatus;

  CibilSendOtpResponseDataEntity({
    this.errorMessage,
    this.stdOneHitID,
    this.stdTwoHitId,
    this.otpGenerationStatus,
  });
}
