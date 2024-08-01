import 'dart:convert';

import 'package:lms/aa_getx/modules/kyc/domain/entities/request/download_kyc_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DownloadKycRequestModel {
  String panCardNumber;
  String dateOfBirth;
  String ckycNumber;
  
  DownloadKycRequestModel({
    required this.panCardNumber,
    required this.dateOfBirth,
    required this.ckycNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pan_no': panCardNumber,
      'dob': dateOfBirth,
      'ckyc_no': ckycNumber,
    };
  }

  factory DownloadKycRequestModel.fromMap(Map<String, dynamic> map) {
    return DownloadKycRequestModel(
      panCardNumber: map['pan_no'] as String,
      dateOfBirth: map['dob'] as String,
      ckycNumber: map['ckyc_no'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DownloadKycRequestModel.fromJson(String source) => DownloadKycRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  DownloadKycRequestEntity toEntity() =>
  DownloadKycRequestEntity(
      panCardNumber: panCardNumber,
      dateOfBirth: dateOfBirth,
      ckycNumber: ckycNumber,
  
  );

  factory DownloadKycRequestModel.fromEntity(DownloadKycRequestEntity downloadKycRequestEntity) {
    return DownloadKycRequestModel(
      panCardNumber: downloadKycRequestEntity.panCardNumber as String,
      dateOfBirth: downloadKycRequestEntity.dateOfBirth as String,
      ckycNumber: downloadKycRequestEntity.ckycNumber as String,
    );
  }
}
