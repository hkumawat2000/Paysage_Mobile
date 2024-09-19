import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';

class MutualFundSendOtpResponseModel {
  String? message;
  MutualFundSendOtpData? mutualFundSendOtpData;

  MutualFundSendOtpResponseModel({this.message, this.mutualFundSendOtpData});

  MutualFundSendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    mutualFundSendOtpData = json['data'] != null ? new MutualFundSendOtpData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.mutualFundSendOtpData != null) {
      data['data'] = this.mutualFundSendOtpData!.toJson();
    }
    return data;
  }

  MutualFundSendOtpResponseEntity toEntity() =>
      MutualFundSendOtpResponseEntity(
        message: message,
        mutualFundSendOtpData: mutualFundSendOtpData?.toEntity(),
      );
}

class MutualFundSendOtpData {
  int? reqId;
  String? otpRef;
  String? userSubjectReference;
  String? clientRefNo;

  MutualFundSendOtpData({this.reqId, this.otpRef, this.userSubjectReference, this.clientRefNo});

  MutualFundSendOtpData.fromJson(Map<String, dynamic> json) {
    reqId = json['reqId'];
    otpRef = json['otpRef'];
    userSubjectReference = json['userSubjectReference'];
    clientRefNo = json['clientRefNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reqId'] = this.reqId;
    data['otpRef'] = this.otpRef;
    data['userSubjectReference'] = this.userSubjectReference;
    data['clientRefNo'] = this.clientRefNo;
    return data;
  }

  MutualFundSendOtpDataEntity toEntity() =>
      MutualFundSendOtpDataEntity(
        reqId: reqId,
        otpRef: otpRef,
        userSubjectReference: userSubjectReference,
        clientRefNo: clientRefNo,
      );
}

