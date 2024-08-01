import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_consent_details_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetConsentDetailsRequestModel {
  String consentIsfor;
  
  GetConsentDetailsRequestModel({
    required this.consentIsfor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'consent_name': consentIsfor,
    };
  }

  factory GetConsentDetailsRequestModel.fromMap(Map<String, dynamic> map) {
    return GetConsentDetailsRequestModel(
      consentIsfor: map['consent_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetConsentDetailsRequestModel.fromJson(String source) => GetConsentDetailsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GetConsentDetailsRequestEntity toEntity() =>
  GetConsentDetailsRequestEntity(
      consentIsfor: consentIsfor,
  
  );

  factory GetConsentDetailsRequestModel.fromEntity(GetConsentDetailsRequestEntity getConsentDetailsRequestEntity) {
    return GetConsentDetailsRequestModel(
      consentIsfor: getConsentDetailsRequestEntity.consentIsfor,
    );
  }
}
