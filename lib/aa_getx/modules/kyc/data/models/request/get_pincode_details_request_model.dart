import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_pincode_details_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetPincodeDetailsRequestModel {
  String? pincode;

  GetPincodeDetailsRequestModel({
   required this.pincode,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pincode': pincode,
    };
  }

  factory GetPincodeDetailsRequestModel.fromMap(Map<String, dynamic> map) {
    return GetPincodeDetailsRequestModel(
      pincode: map['pincode'] != null ? map['pincode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetPincodeDetailsRequestModel.fromJson(String source) => GetPincodeDetailsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GetPincodeDetailsRequestEntity toEntity() =>
  GetPincodeDetailsRequestEntity(
      pincode: pincode,
  
  );

  factory GetPincodeDetailsRequestModel.fromEntity(GetPincodeDetailsRequestEntity getPincodeDetailsRequestEntity) {
    return GetPincodeDetailsRequestModel(
      pincode: getPincodeDetailsRequestEntity.pincode != null ? getPincodeDetailsRequestEntity.pincode as String : null,
    );
  }
}
