import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/request/forgot_pin_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForgotPinRequestModel {
  String emailId;
  
  ForgotPinRequestModel({
    required this.emailId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'emailId': emailId,
    };
  }

  factory ForgotPinRequestModel.fromMap(Map<String, dynamic> map) {
    return ForgotPinRequestModel(
      emailId: map['emailId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPinRequestModel.fromJson(String source) => ForgotPinRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ForgotPinRequestEntity toEntity() =>
  ForgotPinRequestEntity(
      emailId: emailId,
  
  );

  factory ForgotPinRequestModel.fromEntity(ForgotPinRequestEntity forgotPinRequestEntity) {
    return ForgotPinRequestModel(
      emailId: forgotPinRequestEntity.emailId,
    );
  }
}
