// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/aa_getx/modules/login/data/models/alert_data_response_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/alert_data_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_profile_and_set_alert_details_response_entity.dart';

class GetProfileAndSetAlertsResponseModel {
  String? message;
  AlertDataResponseModel? alertData;

  GetProfileAndSetAlertsResponseModel({
    this.message,
    this.alertData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': alertData?.toMap(),
    };
  }

  factory GetProfileAndSetAlertsResponseModel.fromMap(Map<String, dynamic> map) {
    return GetProfileAndSetAlertsResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      alertData: map['data'] != null ? AlertDataResponseModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetProfileAndSetAlertsResponseModel.fromJson(String source) => GetProfileAndSetAlertsResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  GetProfileAndSetAlertDetailsResponseEntity toEntity() =>
  GetProfileAndSetAlertDetailsResponseEntity(
      message: message,
      alertData: alertData?.toEntity(),
  
  );

  factory GetProfileAndSetAlertsResponseModel.fromEntity(GetProfileAndSetAlertDetailsResponseEntity getProfileAndSetAlertsResponseEntity) {
    return GetProfileAndSetAlertsResponseModel(
      message: getProfileAndSetAlertsResponseEntity.message != null ? getProfileAndSetAlertsResponseEntity.message as String : null,
      alertData: getProfileAndSetAlertsResponseEntity.alertData != null ? AlertDataResponseModel.fromEntity(getProfileAndSetAlertsResponseEntity.alertData as AlertDataResponseEntity) : null,
    );
  }
}
