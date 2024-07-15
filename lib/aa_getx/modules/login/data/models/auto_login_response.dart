// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/aa_getx/modules/login/data/models/common_items_response.dart';
import 'package:lms/aa_getx/modules/login/data/models/errors_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/register_data_response_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class AuthLoginResponse extends ModelWrapper<RegisterData> {
  String? message;
  RegisterData? registerData;
  Errors? errors;

  AuthLoginResponse({this.message, this.registerData,this.errors});

  AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data =
    json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    } if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }

  AuthLoginResponseEntity toEntity() =>
  AuthLoginResponseEntity(
      message: message,
      registerData: registerData?.toEntity(),
      errors: errors!.toEntity(),
  
  );
}


















