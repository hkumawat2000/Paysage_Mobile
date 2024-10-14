
import 'package:lms/aa_getx/modules/mf_central/domain/entities/request/fetch_mutual_fund_request_entity.dart';

class FetchMutualFundRequestModel {
  String? otp;
  int? reqId;
  String? otpRef;
  String? userSubjectReference;
  String? clientRefno;

  FetchMutualFundRequestModel(
      {this.otp,
        this.reqId,
        this.otpRef,
        this.userSubjectReference,
        this.clientRefno});

  FetchMutualFundRequestModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    reqId = json['req_id'];
    otpRef = json['otp_ref'];
    userSubjectReference = json['user_subject_reference'];
    clientRefno = json['client_refno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['req_id'] = this.reqId;
    data['otp_ref'] = this.otpRef;
    data['user_subject_reference'] = this.userSubjectReference;
    data['client_refno'] = this.clientRefno;
    return data;
  }

  factory FetchMutualFundRequestModel.fromEntity(FetchMutualFundRequestEntity fetchMutualFundRequestEntity) {
    return FetchMutualFundRequestModel(
      otp: fetchMutualFundRequestEntity.otp != null ? fetchMutualFundRequestEntity.otp as String : null,
      reqId: fetchMutualFundRequestEntity.reqId != null ? fetchMutualFundRequestEntity.reqId as int : null,
      otpRef: fetchMutualFundRequestEntity.otpRef != null ? fetchMutualFundRequestEntity.otpRef as String : null,
      userSubjectReference: fetchMutualFundRequestEntity.userSubjectReference != null ? fetchMutualFundRequestEntity.userSubjectReference as String : null,
     clientRefno:  fetchMutualFundRequestEntity.clientRefno != null ? fetchMutualFundRequestEntity.clientRefno as String : null,
    );
  }
}
