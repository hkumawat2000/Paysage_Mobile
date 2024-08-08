import 'dart:convert';

import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_otp_verification_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilOtpVerificationResponseModel {
  String? message;
  CibilOtpVerificationResponseDataModel? cibilData;
  
  CibilOtpVerificationResponseModel({
    this.message,
    this.cibilData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': cibilData?.toMap(),
    };
  }

  factory CibilOtpVerificationResponseModel.fromMap(Map<String, dynamic> map) {
    return CibilOtpVerificationResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      cibilData: map['data'] != null ? CibilOtpVerificationResponseDataModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilOtpVerificationResponseModel.fromJson(String source) => CibilOtpVerificationResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilOtpVerificationResponseEntity toEntity() =>
  CibilOtpVerificationResponseEntity(
      message: message,
      otpVerityDataEntity: cibilData?.toEntity(),
  
  );

  factory CibilOtpVerificationResponseModel.fromEntity(CibilOtpVerificationResponseEntity cibilOtpVerificationResponseEntity) {
    return CibilOtpVerificationResponseModel(
      message: cibilOtpVerificationResponseEntity.message != null ? cibilOtpVerificationResponseEntity.message as String : null,
      cibilData: cibilOtpVerificationResponseEntity.otpVerityDataEntity != null ? CibilOtpVerificationResponseDataModel.fromEntity(cibilOtpVerificationResponseEntity.otpVerityDataEntity as CibilOtpVerificationResponseDataEntity) : null,
    );
  }
}

class CibilOtpVerificationResponseDataModel {
  int? cibilScore;
  CibilOtpVerificationResponseDataModel({
    this.cibilScore,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cibil_score': cibilScore,
    };
  }

  factory CibilOtpVerificationResponseDataModel.fromMap(Map<String, dynamic> map) {
    return CibilOtpVerificationResponseDataModel(
      cibilScore: map['cibil_score'] != null ? map['cibil_score'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilOtpVerificationResponseDataModel.fromJson(String source) => CibilOtpVerificationResponseDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilOtpVerificationResponseDataEntity toEntity() =>
  CibilOtpVerificationResponseDataEntity(
      cibilScore: cibilScore,
  
  );

  factory CibilOtpVerificationResponseDataModel.fromEntity(CibilOtpVerificationResponseDataEntity cibilOtpVerificationResponseDataEntity) {
    return CibilOtpVerificationResponseDataModel(
      cibilScore: cibilOtpVerificationResponseDataEntity.cibilScore != null ? cibilOtpVerificationResponseDataEntity.cibilScore as int : null,
    );
  }
}
