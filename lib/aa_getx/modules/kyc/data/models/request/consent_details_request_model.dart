import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/request/consent_details_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConsentDetailsRequestModel {
  String? userKycName;
  int? acceptTerms;
  int? isLoanRenewal;
  
  ConsentDetailsRequestModel({
    this.userKycName,
    this.acceptTerms,
    this.isLoanRenewal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userKycName': userKycName,
      'acceptTerms': acceptTerms,
      'isLoanRenewal': isLoanRenewal,
    };
  }

  factory ConsentDetailsRequestModel.fromMap(Map<String, dynamic> map) {
    return ConsentDetailsRequestModel(
      userKycName: map['userKycName'] != null ? map['userKycName'] as String : null,
      acceptTerms: map['acceptTerms'] != null ? map['acceptTerms'] as int : null,
      isLoanRenewal: map['isLoanRenewal'] != null ? map['isLoanRenewal'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsentDetailsRequestModel.fromJson(String source) => ConsentDetailsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ConsentDetailsRequestEntity toEntity() =>
  ConsentDetailsRequestEntity(
      userKycName: userKycName,
      acceptTerms: acceptTerms,
      isLoanRenewal: isLoanRenewal,
  
  );

  factory ConsentDetailsRequestModel.fromEntity(ConsentDetailsRequestEntity consentDetailsRequestEntity) {
    return ConsentDetailsRequestModel(
      userKycName: consentDetailsRequestEntity.userKycName != null ? consentDetailsRequestEntity.userKycName as String : null,
      acceptTerms: consentDetailsRequestEntity.acceptTerms != null ? consentDetailsRequestEntity.acceptTerms as int : null,
      isLoanRenewal: consentDetailsRequestEntity.isLoanRenewal != null ? consentDetailsRequestEntity.isLoanRenewal as int : null,
    );
  }
}
