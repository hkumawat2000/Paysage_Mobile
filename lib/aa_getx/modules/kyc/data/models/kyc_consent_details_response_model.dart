// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/data/models/consent_details_data_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_details_data_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_consent_details_response_entity.dart';

class ConsentDetailResponseModel {
  String? message;
  ConsentDetailDataModel? consentDetailData;

  ConsentDetailResponseModel({this.message, this.consentDetailData});

  ConsentDetailResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    consentDetailData = json['data'] != null ? new ConsentDetailDataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.consentDetailData != null) {
      data['data'] = this.consentDetailData!.toJson();
    }
    return data;
  }

  ConsentDetailResponseEntity toEntity() =>
  ConsentDetailResponseEntity(
      message: message,
      consentDetailData: consentDetailData?.toEntity(),
  );

  factory ConsentDetailResponseModel.fromEntity(ConsentDetailResponseEntity consentDetailResponseEntity) {
    return ConsentDetailResponseModel(
      message: consentDetailResponseEntity.message != null ? consentDetailResponseEntity.message as String : null,
      consentDetailData: consentDetailResponseEntity.consentDetailData != null ? ConsentDetailDataModel.fromEntity(consentDetailResponseEntity.consentDetailData as ConsentDetailDataEntity) : null,
    );
  }
}



// class Country {
//   String? name;
//   String? country;
//
//   Country({this.name, this.country});
//
//   Country.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     country = json['country'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['country'] = this.country;
//     return data;
//   }
// }











