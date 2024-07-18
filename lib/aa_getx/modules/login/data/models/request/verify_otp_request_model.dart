import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerifyOtpRequestModel {
  dynamic mobileNumber;
  dynamic otp;
  dynamic firebase_token;
  String? platform;
  String? appVersion;
  
  VerifyOtpRequestModel({
    required this.mobileNumber,
    required this.otp,
    required this.firebase_token,
    required this.platform,
    required this.appVersion,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobile': mobileNumber,
      'otp': otp,
      'firebase_token': firebase_token,
      'platform' : platform,
      'app_version' : appVersion,
    };
  }

  factory VerifyOtpRequestModel.fromMap(Map<String, dynamic> map) {
    return VerifyOtpRequestModel(
      mobileNumber: map['mobile'] as dynamic,
      otp: map['otp'] as dynamic,
      firebase_token: map['firebase_token'] as dynamic,
      platform: map['platform'],
      appVersion: map['app_version'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpRequestModel.fromJson(String source) => VerifyOtpRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  VerifyOtpRequestEntity toEntity() =>
  VerifyOtpRequestEntity(
      mobileNumber: mobileNumber,
      otp: otp,
      firebase_token: firebase_token,
      platform: platform,
      appVersion: appVersion,
  );

  factory VerifyOtpRequestModel.fromEntity(VerifyOtpRequestEntity verifyOtpRequestEntity) {
    return VerifyOtpRequestModel(
      mobileNumber: verifyOtpRequestEntity.mobileNumber as dynamic,
      otp: verifyOtpRequestEntity.otp as dynamic,
      firebase_token: verifyOtpRequestEntity.firebase_token as dynamic,
      platform: verifyOtpRequestEntity.platform,
      appVersion: verifyOtpRequestEntity.appVersion,
    );
  }
}
