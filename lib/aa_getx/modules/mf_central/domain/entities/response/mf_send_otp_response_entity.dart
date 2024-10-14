class MutualFundSendOtpResponseEntity {
  String? message;
  MutualFundSendOtpDataEntity? mutualFundSendOtpData;

  MutualFundSendOtpResponseEntity({this.message, this.mutualFundSendOtpData});
}

class MutualFundSendOtpDataEntity {
  int? reqId;
  String? otpRef;
  String? userSubjectReference;
  String? clientRefNo;

  MutualFundSendOtpDataEntity({this.reqId, this.otpRef, this.userSubjectReference, this.clientRefNo});
}