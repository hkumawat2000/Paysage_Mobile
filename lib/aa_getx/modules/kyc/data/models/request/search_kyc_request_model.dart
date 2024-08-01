import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/request/search_kyc_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SearchKycRequestModel {
  dynamic panCardNumber;
  dynamic acceptTerms;
  
  SearchKycRequestModel({
    required this.panCardNumber,
    required this.acceptTerms,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pan_no': panCardNumber,
      'accept_terms': acceptTerms,
    };
  }

  factory SearchKycRequestModel.fromMap(Map<String, dynamic> map) {
    return SearchKycRequestModel(
      panCardNumber: map['pan_no'] as dynamic,
      acceptTerms: map['accept_terms'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchKycRequestModel.fromJson(String source) => SearchKycRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  SearchKycRequestEntity toEntity() =>
  SearchKycRequestEntity(
      panCardNumber: panCardNumber,
      acceptTerms: acceptTerms,
  
  );

  factory SearchKycRequestModel.fromEntity(SearchKycRequestEntity searchKycRequestEntity) {
    return SearchKycRequestModel(
      panCardNumber: searchKycRequestEntity.panCardNumber as dynamic,
      acceptTerms: searchKycRequestEntity.acceptTerms as dynamic,
    );
  }
}
