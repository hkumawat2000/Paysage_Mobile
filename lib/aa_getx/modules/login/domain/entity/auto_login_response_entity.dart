// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lms/aa_getx/modules/login/domain/entity/common_items_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/customer_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/errors_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/register_data_entity.dart';

class AuthLoginResponseEntity {
  String? message;
  RegisterDataEntity? registerData;
  ErrorsEntity? errors;

  AuthLoginResponseEntity({this.message, this.registerData, this.errors});
}


