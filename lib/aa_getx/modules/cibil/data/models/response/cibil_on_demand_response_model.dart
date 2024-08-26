import 'dart:convert';

import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_on_demand_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilOnDemandResponseModel {
  String? message;
  CibilOnDemandResponseDataModel? cibilData;
  
  CibilOnDemandResponseModel({
    this.message,
    this.cibilData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': cibilData?.toMap(),
    };
  }

  factory CibilOnDemandResponseModel.fromMap(Map<String, dynamic> map) {
    return CibilOnDemandResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      cibilData: map['data'] != null ? CibilOnDemandResponseDataModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilOnDemandResponseModel.fromJson(String source) => CibilOnDemandResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilOnDemandResponseEntity toEntity() =>
  CibilOnDemandResponseEntity(
      message: message,
      cibilDataEntity: cibilData?.toEntity(),
  
  );

  factory CibilOnDemandResponseModel.fromEntity(CibilOnDemandResponseEntity cibilOnDemandResponseEntity) {
    return CibilOnDemandResponseModel(
      message: cibilOnDemandResponseEntity.message != null ? cibilOnDemandResponseEntity.message as String : null,
      cibilData: cibilOnDemandResponseEntity.cibilDataEntity != null ? CibilOnDemandResponseDataModel.fromEntity(cibilOnDemandResponseEntity.cibilDataEntity as CibilOnDemandResponseDataEntity) : null,
    );
  }
}

class CibilOnDemandResponseDataModel {
  int? cibilScore;
  String? cibilScoreDate;

  CibilOnDemandResponseDataModel({
    this.cibilScore,
    this.cibilScoreDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cibil_score': cibilScore,
      'cibil_score_date': cibilScoreDate,
    };
  }

  factory CibilOnDemandResponseDataModel.fromMap(Map<String, dynamic> map) {
    return CibilOnDemandResponseDataModel(
      cibilScore: map['cibil_score'] != null ? map['cibil_score'] as int : null,
      cibilScoreDate: map['cibil_score_date'] != null ? map['cibil_score_date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilOnDemandResponseDataModel.fromJson(String source) => CibilOnDemandResponseDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilOnDemandResponseDataEntity toEntity() =>
  CibilOnDemandResponseDataEntity(
    cibilScore: cibilScore,
    cibilScoreDate: cibilScoreDate,
  );

  factory CibilOnDemandResponseDataModel.fromEntity(CibilOnDemandResponseDataEntity cibilOnDemandResponseDataEntity) {
    return CibilOnDemandResponseDataModel(
      cibilScore: cibilOnDemandResponseDataEntity.cibilScore != null ? cibilOnDemandResponseDataEntity.cibilScore as int : null,
      cibilScoreDate: cibilOnDemandResponseDataEntity.cibilScoreDate != null ? cibilOnDemandResponseDataEntity.cibilScoreDate as String : null,
    );
  }
}
