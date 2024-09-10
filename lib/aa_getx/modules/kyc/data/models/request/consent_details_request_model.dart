import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/request/consent_details_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConsentDetailsRequestModel {
  String? userKycName;
  int? acceptTerms;
  AddressDetailsRequestModel? addressDetailsRequestModel;
  int? isLoanRenewal;
  
  ConsentDetailsRequestModel({
    this.userKycName,
    this.acceptTerms,
    this.addressDetailsRequestModel,
    this.isLoanRenewal,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_kyc_name': userKycName,
      'accept_terms': acceptTerms,
      'address_details': addressDetailsRequestModel != null ? addressDetailsRequestModel!.toMap() : null,
      'is_loan_renewal': isLoanRenewal,
    };
  }

  factory ConsentDetailsRequestModel.fromMap(Map<String, dynamic> map) {
    return ConsentDetailsRequestModel(
      userKycName: map['user_kyc_name'] != null ? map['user_kyc_name'] as String : null,
      acceptTerms: map['accept_terms'] != null ? map['accept_terms'] as int : null,
      addressDetailsRequestModel: AddressDetailsRequestModel.fromMap(map['address_details'] as Map<String,dynamic>),
      isLoanRenewal: map['is_loan_renewal'] != null ? map['is_loan_renewal'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConsentDetailsRequestModel.fromJson(String source) => ConsentDetailsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ConsentDetailsRequestEntity toEntity() =>
  ConsentDetailsRequestEntity(
      userKycName: userKycName,
      acceptTerms: acceptTerms,
      addressDetailsRequestEntity: addressDetailsRequestModel!.toEntity(),
      isLoanRenewal: isLoanRenewal,
  
  );

  factory ConsentDetailsRequestModel.fromEntity(ConsentDetailsRequestEntity consentDetailsRequestEntity) {
    return ConsentDetailsRequestModel(
      userKycName: consentDetailsRequestEntity.userKycName != null ? consentDetailsRequestEntity.userKycName as String : null,
      acceptTerms: consentDetailsRequestEntity.acceptTerms != null ? consentDetailsRequestEntity.acceptTerms as int : null,
      addressDetailsRequestModel: consentDetailsRequestEntity.addressDetailsRequestEntity != null ? AddressDetailsRequestModel.fromEntity(consentDetailsRequestEntity.addressDetailsRequestEntity as AddressDetailsRequestEntity) : null,
      isLoanRenewal: consentDetailsRequestEntity.isLoanRenewal != null ? consentDetailsRequestEntity.isLoanRenewal as int : null,
    );
  }
}

class AddressDetailsRequestModel {
  PermanentAddressRequestModel? permanentAddress;
  String? permCorresFlag;
  PermanentAddressRequestModel? correspondingAddress;
  
  AddressDetailsRequestModel({
    this.permanentAddress,
    this.permCorresFlag,
    this.correspondingAddress,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'permanent_address': permanentAddress?.toMap(),
      'perm_corres_flag': permCorresFlag,
      'corresponding_address': correspondingAddress?.toMap(),
    };
  }

  factory AddressDetailsRequestModel.fromMap(Map<String, dynamic> map) {
    return AddressDetailsRequestModel(
      permanentAddress: map['permanent_address'] != null ? PermanentAddressRequestModel.fromMap(map['permanent_address'] as Map<String,dynamic>) : null,
      permCorresFlag: map['perm_corres_flag'] != null ? map['perm_corres_flag'] as String : null,
      correspondingAddress: map['corresponding_address'] != null ? PermanentAddressRequestModel.fromMap(map['corresponding_address'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressDetailsRequestModel.fromJson(String source) => AddressDetailsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AddressDetailsRequestEntity toEntity() =>
  AddressDetailsRequestEntity(
      permanentAddress: permanentAddress?.toEntity(),
      permCorresFlag: permCorresFlag,
      correspondingAddress: correspondingAddress?.toEntity(),
  
  );

  factory AddressDetailsRequestModel.fromEntity(AddressDetailsRequestEntity addressDetailsRequestEntity) {
    return AddressDetailsRequestModel(
      permanentAddress: addressDetailsRequestEntity.permanentAddress != null ? PermanentAddressRequestModel.fromEntity(addressDetailsRequestEntity.permanentAddress as PermanentAddressRequestEntity) : null,
      permCorresFlag: addressDetailsRequestEntity.permCorresFlag != null ? addressDetailsRequestEntity.permCorresFlag as String : null,
      correspondingAddress: addressDetailsRequestEntity.correspondingAddress != null ? PermanentAddressRequestModel.fromEntity(addressDetailsRequestEntity.correspondingAddress as PermanentAddressRequestEntity) : null,
    );
  }
}

class PermanentAddressRequestModel {
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? city;
  String? pinCode;
  String? state;
  String? district;
  String? country;
  String? addressProofImage;
  String? poaType;
  
  PermanentAddressRequestModel({
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.pinCode,
    this.state,
    this.district,
    this.country,
    this.addressProofImage,
    this.poaType,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_line1': addressLine1,
      'address_line2': addressLine2,
      'address_line3': addressLine3,
      'city': city,
      'pin_code': pinCode,
      'state': state,
      'district': district,
      'country': country,
      'address_proof_image': addressProofImage,
      'poa_type': poaType,
    };
  }

  factory PermanentAddressRequestModel.fromMap(Map<String, dynamic> map) {
    return PermanentAddressRequestModel(
      addressLine1: map['address_line1'] != null ? map['address_line1'] as String : null,
      addressLine2: map['address_line2'] != null ? map['address_line2'] as String : null,
      addressLine3: map['address_line3'] != null ? map['address_line3'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      pinCode: map['pin_code'] != null ? map['pin_code'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      addressProofImage: map['address_proof_image'] != null ? map['address_proof_image'] as String : null,
      poaType: map['poa_type'] != null ? map['poa_type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermanentAddressRequestModel.fromJson(String source) => PermanentAddressRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PermanentAddressRequestEntity toEntity() =>
  PermanentAddressRequestEntity(
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      addressLine3: addressLine3,
      city: city,
      pinCode: pinCode,
      state: state,
      district: district,
      country: country,
      addressProofImage: addressProofImage,
      poaType: poaType,
  
  );

  factory PermanentAddressRequestModel.fromEntity(PermanentAddressRequestEntity permanentAddressRequestEntity) {
    return PermanentAddressRequestModel(
      addressLine1: permanentAddressRequestEntity.addressLine1 != null ? permanentAddressRequestEntity.addressLine1 as String : null,
      addressLine2: permanentAddressRequestEntity.addressLine2 != null ? permanentAddressRequestEntity.addressLine2 as String : null,
      addressLine3: permanentAddressRequestEntity.addressLine3 != null ? permanentAddressRequestEntity.addressLine3 as String : null,
      city: permanentAddressRequestEntity.city != null ? permanentAddressRequestEntity.city as String : null,
      pinCode: permanentAddressRequestEntity.pinCode != null ? permanentAddressRequestEntity.pinCode as String : null,
      state: permanentAddressRequestEntity.state != null ? permanentAddressRequestEntity.state as String : null,
      district: permanentAddressRequestEntity.district != null ? permanentAddressRequestEntity.district as String : null,
      country: permanentAddressRequestEntity.country != null ? permanentAddressRequestEntity.country as String : null,
      addressProofImage: permanentAddressRequestEntity.addressProofImage != null ? permanentAddressRequestEntity.addressProofImage as String : null,
      poaType: permanentAddressRequestEntity.poaType != null ? permanentAddressRequestEntity.poaType as String : null,
    );
  }
}

