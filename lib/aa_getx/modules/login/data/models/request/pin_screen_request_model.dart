import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/request/pin_screen_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PinScreenRequestModel {
  dynamic mobileNumber;
  dynamic pin;
  dynamic firebase_token;
  dynamic acceptTerms;
  String? platform;
  String? appversion;

  PinScreenRequestModel({
    required this.mobileNumber,
    required this.pin,
    required this.firebase_token,
    required this.acceptTerms,
    this.platform,
    this.appversion,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobile': mobileNumber,
      'pin': pin,
      'firebase_token': firebase_token,
      'accept_terms': acceptTerms,
      'platform': platform,
      'app_version': appversion,
    };
  }

  factory PinScreenRequestModel.fromMap(Map<String, dynamic> map) {
    return PinScreenRequestModel(
      mobileNumber: map['mobile'] as dynamic,
      pin: map['pin'] as dynamic,
      firebase_token: map['firebase_token'] as dynamic,
      acceptTerms: map['accept_terms'] as dynamic,
      platform: map['platform'] != null ? map['platform'] as String : null,
      appversion: map['app_version'] != null ? map['appversion'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PinScreenRequestModel.fromJson(String source) => PinScreenRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PinScreenRequestEntity toEntity() =>
  PinScreenRequestEntity(
      mobileNumber: mobileNumber,
      pin: pin,
      firebase_token: firebase_token,
      acceptTerms: acceptTerms,
      platform: platform,
      appversion: appversion,
  
  );

  factory PinScreenRequestModel.fromEntity(PinScreenRequestEntity pinScreenRequestEntity) {
    return PinScreenRequestModel(
      mobileNumber: pinScreenRequestEntity.mobileNumber as dynamic,
      pin: pinScreenRequestEntity.pin as dynamic,
      firebase_token: pinScreenRequestEntity.firebase_token as dynamic,
      acceptTerms: pinScreenRequestEntity.acceptTerms as dynamic,
      platform: pinScreenRequestEntity.platform != null ? pinScreenRequestEntity.platform as String : null,
      appversion: pinScreenRequestEntity.appversion != null ? pinScreenRequestEntity.appversion as String : null,
    );
  }
}
