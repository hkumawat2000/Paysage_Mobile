import 'dart:convert';
import 'package:lms/aa_getx/modules/aml_check/domain/entity/aml_check_response_entity.dart';

class AmlCheckResponseModel {
  String? message;
  AmlDataModel? amlData;
  
  AmlCheckResponseModel({
    this.message,
    this.amlData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': amlData?.toMap(),
    };
  }

  factory AmlCheckResponseModel.fromMap(Map<String, dynamic> map) {
    return AmlCheckResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      amlData: map['data'] != null ? AmlDataModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmlCheckResponseModel.fromJson(String source) => AmlCheckResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AmlCheckResponseEntity toEntity() =>
  AmlCheckResponseEntity(
      message: message,
      amlData: amlData?.toEntity(),
  
  );

  factory AmlCheckResponseModel.fromEntity(AmlCheckResponseEntity amlCheckResponseEntity) {
    return AmlCheckResponseModel(
      message: amlCheckResponseEntity.message != null ? amlCheckResponseEntity.message as String : null,
      amlData: amlCheckResponseEntity.amlData != null ? AmlDataModel.fromEntity(amlCheckResponseEntity.amlData as AmlDataEntity) : null,
    );
  }
}

class AmlDataModel {
  int? hitCount;
  
  AmlDataModel({
    this.hitCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hit_count': hitCount,
    };
  }

  factory AmlDataModel.fromMap(Map<String, dynamic> map) {
    return AmlDataModel(
      hitCount: map['hit_count'] != null ? map['hit_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmlDataModel.fromJson(String source) => AmlDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AmlDataEntity toEntity() =>
  AmlDataEntity(
      hitCount: hitCount,
  
  );

  factory AmlDataModel.fromEntity(AmlDataEntity amlDataEntity) {
    return AmlDataModel(
      hitCount: amlDataEntity.hitCount != null ? amlDataEntity.hitCount as int : null,
    );
  }
}
