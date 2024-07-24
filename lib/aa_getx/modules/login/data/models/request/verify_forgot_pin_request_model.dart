import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_forgot_pin_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VerifyForgotPinRequestModel {
  String? email;
  String? otp;
  String? newPin;
  String? retypePin;
  
  VerifyForgotPinRequestModel({
    this.email,
    this.otp,
    this.newPin,
    this.retypePin,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'otp': otp,
      'newPin': newPin,
      'retypePin': retypePin,
    };
  }

  factory VerifyForgotPinRequestModel.fromMap(Map<String, dynamic> map) {
    return VerifyForgotPinRequestModel(
      email: map['email'] != null ? map['email'] as String : null,
      otp: map['otp'] != null ? map['otp'] as String : null,
      newPin: map['newPin'] != null ? map['newPin'] as String : null,
      retypePin: map['retypePin'] != null ? map['retypePin'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyForgotPinRequestModel.fromJson(String source) => VerifyForgotPinRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory VerifyForgotPinRequestModel.fromEntity(VerifyForgotPinRequestEntity verifyForgotPinRequestEntity) {
    return VerifyForgotPinRequestModel(
      email: verifyForgotPinRequestEntity.email != null ? verifyForgotPinRequestEntity.email as String : null,
      otp: verifyForgotPinRequestEntity.otp != null ? verifyForgotPinRequestEntity.otp as String : null,
      newPin: verifyForgotPinRequestEntity.newPin != null ? verifyForgotPinRequestEntity.newPin as String : null,
      retypePin: verifyForgotPinRequestEntity.retypePin != null ? verifyForgotPinRequestEntity.retypePin as String : null,
    );
  }

  VerifyForgotPinRequestEntity toEntity() =>
  VerifyForgotPinRequestEntity(
      email: email,
      otp: otp,
      newPin: newPin,
      retypePin: retypePin,
  
  );
}
