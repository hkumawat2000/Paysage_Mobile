// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/data/models/consent_details_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_text_response_entity.dart';

class ConsentTextResponseModel {
  String? message;
  ConsentDetailsResponseModel? consentDetails;

  ConsentTextResponseModel({
    this.message,
    this.consentDetails,
  });

   ConsentTextResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    consentDetails = json['data'] != null ? new ConsentDetailsResponseModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.consentDetails != null) {
      data['data'] = this.consentDetails!.toJson();
    }
    return data;
  }

  ConsentTextResponseEntity toEntity() =>
  ConsentTextResponseEntity(
      message: message,
      consentDetails: consentDetails?.toEntity(),
  
  );

  factory ConsentTextResponseModel.fromEntity(ConsentTextResponseEntity consentTextResponseEntity) {
    return ConsentTextResponseModel(
      message: consentTextResponseEntity.message != null ? consentTextResponseEntity.message as String : null,
      consentDetails: consentTextResponseEntity.consentDetails != null ? ConsentDetailsResponseModel.fromEntity(consentTextResponseEntity.consentDetails as ConsentDetailsResponseEntity) : null,
    );
  }
}
