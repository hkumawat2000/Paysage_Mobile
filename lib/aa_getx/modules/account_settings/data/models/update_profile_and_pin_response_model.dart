// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/aa_getx/modules/account_settings/data/models/update_data_response_model.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_data_response_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_profile_and_pin_response_entity.dart';

class UpdateProfileAndPinResponseModel {
  String? message;
  UpdateDataResponseModel? updateDataResponseModel;
  
  UpdateProfileAndPinResponseModel({
    this.message,
    this.updateDataResponseModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': updateDataResponseModel?.toMap(),
    };
  }

  factory UpdateProfileAndPinResponseModel.fromMap(Map<String, dynamic> map) {
    return UpdateProfileAndPinResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      updateDataResponseModel: map['data'] != null ? UpdateDataResponseModel.fromMap(map['updateDataResponseModel'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfileAndPinResponseModel.fromJson(String source) => UpdateProfileAndPinResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UpdateProfileAndPinResponseEntity toEntity() =>
  UpdateProfileAndPinResponseEntity(
      message: message,
      updateDataResponseEntity: updateDataResponseModel?.toEntity(),
  
  );

  factory UpdateProfileAndPinResponseModel.fromEntity(UpdateProfileAndPinResponseEntity updateProfileAndPinResponseEntity) {
    return UpdateProfileAndPinResponseModel(
      message: updateProfileAndPinResponseEntity.message != null ? updateProfileAndPinResponseEntity.message as String : null,
      updateDataResponseModel: updateProfileAndPinResponseEntity.updateDataResponseEntity != null ? UpdateDataResponseModel.fromEntity(updateProfileAndPinResponseEntity.updateDataResponseEntity as UpdateDataResponseEntity) : null,
    );
  }
}
