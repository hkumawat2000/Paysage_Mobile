import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/pincode_data_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PincodeDataResponseModel {
  String? district;
  String? state;
  
  PincodeDataResponseModel({
    this.district,
    this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'district': district,
      'state': state,
    };
  }

  factory PincodeDataResponseModel.fromMap(Map<String, dynamic> map) {
    return PincodeDataResponseModel(
      district: map['district'] != null ? map['district'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PincodeDataResponseModel.fromJson(String source) => PincodeDataResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PincodeDataResponseEntity toEntity() =>
  PincodeDataResponseEntity(
      district: district,
      state: state,
  
  );

  factory PincodeDataResponseModel.fromEntity(PincodeDataResponseEntity pincodeDataResponseEntity) {
    return PincodeDataResponseModel(
      district: pincodeDataResponseEntity.district != null ? pincodeDataResponseEntity.district as String : null,
      state: pincodeDataResponseEntity.state != null ? pincodeDataResponseEntity.state as String : null,
    );
  }
}
