// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/data/models/pincode_data_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/pincode_data_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/pincode_response_entity.dart';

class PincodeResponseModel {
  String? message;
  PincodeDataResponseModel? data;
  
  PincodeResponseModel({
    this.message,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory PincodeResponseModel.fromMap(Map<String, dynamic> map) {
    return PincodeResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null ? PincodeDataResponseModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PincodeResponseModel.fromJson(String source) => PincodeResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PincodeResponseEntity toEntity() =>
  PincodeResponseEntity(
      message: message,
      data: data?.toEntity(),
  
  );

  factory PincodeResponseModel.fromEntity(PincodeResponseEntity pincodeResponseEntity) {
    return PincodeResponseModel(
      message: pincodeResponseEntity.message != null ? pincodeResponseEntity.message as String : null,
      data: pincodeResponseEntity.data != null ? PincodeDataResponseModel.fromEntity(pincodeResponseEntity.data as PincodeDataResponseEntity) : null,
    );
  }
}
