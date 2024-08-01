// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/data/models/address_details_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/consent_details_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/user_kyc_doc_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/address_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_details_data_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/user_kyc_doc_response_entity.dart';

class ConsentDetailDataModel {
  UserKycDocResponseModel? userKycDoc;
  ConsentDetailsResponseModel? consentDetails;
  List<String>? poaType;
  List<String>? country;
  AddressDetailsResponseModel? address;

  ConsentDetailDataModel({this.userKycDoc, this.consentDetails, this.poaType, this.country, this.address});

  ConsentDetailDataModel.fromJson(Map<String, dynamic> json) {
    userKycDoc = json['user_kyc_doc'] != null
        ? new UserKycDocResponseModel.fromJson(json['user_kyc_doc'])
        : null;
    consentDetails = json['consent_details'] != null
        ? new ConsentDetailsResponseModel.fromJson(json['consent_details'])
        : null;
    poaType = json['poa_type'].cast<String>();
    // if (json['country'] != null) {
    //   country = <Country>[];
    //   json['country'].forEach((v) {
    //     country!.add(new Country.fromJson(v));
    //   });
    // }
    country = json['country'].cast<String>();
    address = json['address'] != null && json['address'].toString().isNotEmpty
        ? new AddressDetailsResponseModel.fromJson(json['address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userKycDoc != null) {
      data['user_kyc_doc'] = this.userKycDoc!.toJson();
    }
    if (this.consentDetails != null) {
      data['consent_details'] = this.consentDetails!.toJson();
    }
    data['poa_type'] = this.poaType;
    // if (this.country != null) {
    //   data['country'] =
    //       this.country!.map((v) => v.toJson()).toList();
    // }
    data['country'] = this.country;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }

  ConsentDetailDataEntity toEntity() =>
  ConsentDetailDataEntity(
      userKycDoc: userKycDoc?.toEntity(),
      consentDetails: consentDetails?.toEntity(),
      poaType: poaType,
      country: country,
      address: address?.toEntity(),
  
  );

 

  factory ConsentDetailDataModel.fromEntity(ConsentDetailDataEntity consentDetailDataEntity) {
    return ConsentDetailDataModel(
      userKycDoc: consentDetailDataEntity.userKycDoc != null ? UserKycDocResponseModel.fromEntity(consentDetailDataEntity.userKycDoc as UserKycDocResponseEntity) : null,
      consentDetails: consentDetailDataEntity.consentDetails != null ? ConsentDetailsResponseModel.fromEntity(consentDetailDataEntity.consentDetails as ConsentDetailsResponseEntity) : null,
      poaType: consentDetailDataEntity.poaType != null ? List<String>.from(consentDetailDataEntity.poaType as List<String>) : null,
      country: consentDetailDataEntity.country != null ? List<String>.from(consentDetailDataEntity.country as List<String>) : null,
      address: consentDetailDataEntity.address != null ? AddressDetailsResponseModel.fromEntity(consentDetailDataEntity.address as AddressDetailsResponseEntity) : null,
    );
  }
}
