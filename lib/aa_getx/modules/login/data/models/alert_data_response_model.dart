// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/aa_getx/modules/login/data/models/customer_details_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/user_kyc_response_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/alert_data_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/customer_details_response_entity.dart';

class AlertDataResponseModel {
  CustomerDetailsResponseModel? customerDetails;
  String? loanApplicationStatus;
  String? loanName;
  String? instrumentType;
  String? pledgorBoid;
  UserKyc? userKyc;
  String? lastLogin;
  String? profilePhotoUrl;
  
  AlertDataResponseModel({
    this.customerDetails,
    this.loanApplicationStatus,
    this.loanName,
    this.instrumentType,
    this.pledgorBoid,
    this.userKyc,
    this.lastLogin,
    this.profilePhotoUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'customer_details': customerDetails?.toJson(),
      'loan_application_status': loanApplicationStatus,
      'loan_name': loanName,
      'instrument_type': instrumentType,
      'pledgor_boid': pledgorBoid,
      'user_kyc': userKyc?.toJson(),
      'last_login': lastLogin,
      'profile_picture_file_url': profilePhotoUrl,
    };
  }

  factory AlertDataResponseModel.fromJson(Map<String, dynamic> map) {
    return AlertDataResponseModel(
      customerDetails: map['customer_details'] != null ? CustomerDetailsResponseModel.fromJson(map['customer_details'] as Map<String,dynamic>) : null,
      loanApplicationStatus: map['loan_application_status'] != null ? map['loan_application_status'] as String : null,
      loanName: map['loan_name'] != null ? map['loan_name'] as String : null,
      instrumentType: map['instrument_type'] != null ? map['instrument_type'] as String : null,
      pledgorBoid: map['pledgor_boid'] != null ? map['pledgor_boid'] as String : null,
      userKyc: map['user_kyc'] != null ? UserKyc.fromJson(map['user_kyc'] as Map<String,dynamic>) : null,
      lastLogin: map['last_login'] != null ? map['last_login'] as String : null,
      profilePhotoUrl: map['profile_picture_file_url'] != null ? map['profile_picture_file_url'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory AlertDataResponseModel.fromJson(String source) => AlertDataResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AlertDataResponseEntity toEntity() =>
  AlertDataResponseEntity(
      customerDetails: customerDetails?.toEntity(),
      loanApplicationStatus: loanApplicationStatus,
      loanName: loanName,
      instrumentType: instrumentType,
      pledgorBoid: pledgorBoid,
      userKyc: userKyc?.toEntity(),
      lastLogin: lastLogin,
      profilePhotoUrl: profilePhotoUrl,
  
  );

  factory AlertDataResponseModel.fromEntity(AlertDataResponseEntity alertDataResponseEntity) {
    return AlertDataResponseModel(
      customerDetails: alertDataResponseEntity.customerDetails != null ? CustomerDetailsResponseModel.fromEntity(alertDataResponseEntity.customerDetails as CustomerDetailsResponseEntity) : null,
      loanApplicationStatus: alertDataResponseEntity.loanApplicationStatus != null ? alertDataResponseEntity.loanApplicationStatus as String : null,
      loanName: alertDataResponseEntity.loanName != null ? alertDataResponseEntity.loanName as String : null,
      instrumentType: alertDataResponseEntity.instrumentType != null ? alertDataResponseEntity.instrumentType as String : null,
      pledgorBoid: alertDataResponseEntity.pledgorBoid != null ? alertDataResponseEntity.pledgorBoid as String : null,
      userKyc: alertDataResponseEntity.userKyc != null ? UserKyc.fromEntity(alertDataResponseEntity.userKyc as UserKyc) : null,
      lastLogin: alertDataResponseEntity.lastLogin != null ? alertDataResponseEntity.lastLogin as String : null,
      profilePhotoUrl: alertDataResponseEntity.profilePhotoUrl != null ? alertDataResponseEntity.profilePhotoUrl as String : null,
    );
  }
}
