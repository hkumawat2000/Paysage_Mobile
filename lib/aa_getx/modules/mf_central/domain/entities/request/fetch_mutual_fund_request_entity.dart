
class FetchMutualFundRequestEntity {
  String? otp;
  int? reqId;
  String? otpRef;
  String? userSubjectReference;
  String? clientRefno;

  FetchMutualFundRequestEntity(
      {this.otp,
        this.reqId,
        this.otpRef,
        this.userSubjectReference,
        this.clientRefno});
}