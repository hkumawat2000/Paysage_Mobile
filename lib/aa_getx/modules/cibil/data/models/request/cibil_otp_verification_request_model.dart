import 'dart:convert';

import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilOtpVerificationRequestModel {
  String? oneID;
  String? twoId;
  String? otp;
  String? type;
  
  CibilOtpVerificationRequestModel({
    this.oneID,
    this.twoId,
    this.otp,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'one_id': oneID,
      'two_id': twoId,
      'otp': otp,
      'type': type,
    };
  }

  factory CibilOtpVerificationRequestModel.fromMap(Map<String, dynamic> map) {
    return CibilOtpVerificationRequestModel(
      oneID: map['one_id'] != null ? map['one_id'] as String : null,
      twoId: map['two_id'] != null ? map['two_id'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilOtpVerificationRequestModel.fromJson(String source) => CibilOtpVerificationRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilOtpVerificationRequestEntity toEntity() =>
  CibilOtpVerificationRequestEntity(
      oneID: oneID,
      twoId: twoId,
      otp: otp,
      type: type,
  
  );

  factory CibilOtpVerificationRequestModel.fromEntity(CibilOtpVerificationRequestEntity cibilOtpVerificationRequestEntity) {
    return CibilOtpVerificationRequestModel(
      oneID: cibilOtpVerificationRequestEntity.oneID != null ? cibilOtpVerificationRequestEntity.oneID as String : null,
      twoId: cibilOtpVerificationRequestEntity.twoId != null ? cibilOtpVerificationRequestEntity.twoId as String : null,
      otp: cibilOtpVerificationRequestEntity.otp != null ? cibilOtpVerificationRequestEntity.otp as String : null,
      type: cibilOtpVerificationRequestEntity.type != null ? cibilOtpVerificationRequestEntity.type as String : null,
    );
  }
}
