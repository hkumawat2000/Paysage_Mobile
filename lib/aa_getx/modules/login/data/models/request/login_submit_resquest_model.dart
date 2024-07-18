import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginSubmitResquestModel {
  dynamic mobileNumber;
  dynamic firebase_token;
  dynamic acceptTerms;
  String? platform;
  String? appVersion;

  LoginSubmitResquestModel({
    required this.mobileNumber,
    required this.firebase_token,
    required this.acceptTerms,
    required this.platform,
    required this.appVersion,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mobile': mobileNumber,
      'firebase_token': firebase_token,
      'accept_terms': acceptTerms,
      'platform' : platform,
      'app_version' : appVersion,
    };
  }

  factory LoginSubmitResquestModel.fromMap(Map<String, dynamic> map) {
    return LoginSubmitResquestModel(
      mobileNumber: map['mobile'] as dynamic,
      firebase_token: map['firebase_token'] as dynamic,
      acceptTerms: map['accept_terms'] as dynamic,
      platform: map['platform'],
      appVersion: map['app_version'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSubmitResquestModel.fromJson(String source) =>
      LoginSubmitResquestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  LoginSubmitResquestEntity toEntity() => LoginSubmitResquestEntity(
        mobileNumber: mobileNumber,
        firebase_token: firebase_token,
        acceptTerms: acceptTerms,
        platform: platform,
      appVersion: appVersion,
      );

  factory LoginSubmitResquestModel.fromEntity(
      LoginSubmitResquestEntity loginSubmitResquestEntity) {
    return LoginSubmitResquestModel(
      mobileNumber: loginSubmitResquestEntity.mobileNumber as dynamic,
      firebase_token: loginSubmitResquestEntity.firebase_token as dynamic,
      acceptTerms: loginSubmitResquestEntity.acceptTerms as dynamic,
       platform: loginSubmitResquestEntity.platform,
      appVersion: loginSubmitResquestEntity.appVersion,
    );
  }
}
