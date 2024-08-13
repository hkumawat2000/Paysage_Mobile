import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/pledge_otp_request_entity.dart';

class PledgeOTPRequestModel {
  String? instrumentType;

  PledgeOTPRequestModel({this.instrumentType});

  PledgeOTPRequestModel.fromJson(Map<String, dynamic> json) {
    instrumentType = json['instrument_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instrument_type'] = this.instrumentType;
    return data;
  }

  PledgeOTPRequestEntity toEntity() =>
      PledgeOTPRequestEntity(
        instrumentType: instrumentType,
      );

  factory PledgeOTPRequestModel.fromEntity(PledgeOTPRequestEntity pledgeOtprequestEntity) {
    return PledgeOTPRequestModel(
      instrumentType: pledgeOtprequestEntity.instrumentType != null ? pledgeOtprequestEntity.instrumentType as String : null,
    );
  }
}