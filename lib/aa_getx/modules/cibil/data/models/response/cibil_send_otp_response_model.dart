import 'dart:convert';

import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_send_otp_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilSendOtpResponseModel {
  String? message;
  CibilSendOtpResponseDataModel? cibilOtpData;
  
  CibilSendOtpResponseModel({
    this.message,
    this.cibilOtpData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': cibilOtpData?.toMap(),
    };
  }

  factory CibilSendOtpResponseModel.fromMap(Map<String, dynamic> map) {
    return CibilSendOtpResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      cibilOtpData: map['data'] != null ? CibilSendOtpResponseDataModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilSendOtpResponseModel.fromJson(String source) => CibilSendOtpResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilSendOtpResponseEntity toEntity() =>
  CibilSendOtpResponseEntity(
      message: message,
      cibilOtpDataEntity: cibilOtpData?.toEntity(),
  
  );

  factory CibilSendOtpResponseModel.fromEntity(CibilSendOtpResponseEntity cibilSendOtpResponseEntity) {
    return CibilSendOtpResponseModel(
      message: cibilSendOtpResponseEntity.message != null ? cibilSendOtpResponseEntity.message as String : null,
      cibilOtpData: cibilSendOtpResponseEntity.cibilOtpDataEntity != null ? CibilSendOtpResponseDataModel.fromEntity(cibilSendOtpResponseEntity.cibilOtpDataEntity as CibilSendOtpResponseDataEntity) : null,
    );
  }
}



class CibilSendOtpResponseDataModel {
  String? errorMessage;
  String? stdOneHitID;
  String? stdTwoHitId;
  String? otpGenerationStatus;
  
  CibilSendOtpResponseDataModel({
    this.errorMessage,
    this.stdOneHitID,
    this.stdTwoHitId,
    this.otpGenerationStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'errorString': errorMessage,
      'stgOneHitId': stdOneHitID,
      'stgTwoHitId': stdTwoHitId,
      'otpGenerationStatus': otpGenerationStatus,
    };
  }

  factory CibilSendOtpResponseDataModel.fromMap(Map<String, dynamic> map) {
    return CibilSendOtpResponseDataModel(
      errorMessage: map['errorString'] != null ? map['errorString'] as String : null,
      stdOneHitID: map['stgOneHitId'] != null ? map['stgOneHitId'] as String : null,
      stdTwoHitId: map['stgTwoHitId'] != null ? map['stgTwoHitId'] as String : null,
      otpGenerationStatus: map['otpGenerationStatus'] != null ? map['otpGenerationStatus'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilSendOtpResponseDataModel.fromJson(String source) => CibilSendOtpResponseDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilSendOtpResponseDataEntity toEntity() =>
  CibilSendOtpResponseDataEntity(
      errorMessage: errorMessage,
      stdOneHitID: stdOneHitID,
      stdTwoHitId: stdTwoHitId,
      otpGenerationStatus: otpGenerationStatus,
  
  );

  factory CibilSendOtpResponseDataModel.fromEntity(CibilSendOtpResponseDataEntity cibilSendOtpResponseDataEntity) {
    return CibilSendOtpResponseDataModel(
      errorMessage: cibilSendOtpResponseDataEntity.errorMessage != null ? cibilSendOtpResponseDataEntity.errorMessage as String : null,
      stdOneHitID: cibilSendOtpResponseDataEntity.stdOneHitID != null ? cibilSendOtpResponseDataEntity.stdOneHitID as String : null,
      stdTwoHitId: cibilSendOtpResponseDataEntity.stdTwoHitId != null ? cibilSendOtpResponseDataEntity.stdTwoHitId as String : null,
      otpGenerationStatus: cibilSendOtpResponseDataEntity.otpGenerationStatus != null ? cibilSendOtpResponseDataEntity.otpGenerationStatus as String : null,
    );
  }
}
