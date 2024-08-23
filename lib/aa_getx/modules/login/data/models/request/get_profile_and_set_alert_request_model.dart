import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/request/get_profile_and_set_alert_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetProfileAndSetAlertRequestModel {
  int? isForAlert;
  int? percentage;
  int? amount;
  GetProfileAndSetAlertRequestModel({
    this.isForAlert,
    this.percentage,
    this.amount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_for_alerts': isForAlert,
      'percentage': percentage,
      'amount': amount,
    };
  }

  factory GetProfileAndSetAlertRequestModel.fromMap(Map<String, dynamic> map) {
    return GetProfileAndSetAlertRequestModel(
      isForAlert: map['is_for_alerts'] != null ? map['is_for_alerts'] as int : null,
      percentage: map['percentage'] != null ? map['percentage'] as int : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetProfileAndSetAlertRequestModel.fromJson(String source) => GetProfileAndSetAlertRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory GetProfileAndSetAlertRequestModel.fromEntity(GetProfileAndSetAlertRequestEntity getProfileAndSetAlertRequestEntity) {
    return GetProfileAndSetAlertRequestModel(
      isForAlert: getProfileAndSetAlertRequestEntity.isForAlert != null ? getProfileAndSetAlertRequestEntity.isForAlert as int : null,
      percentage: getProfileAndSetAlertRequestEntity.percentage != null ? getProfileAndSetAlertRequestEntity.percentage as int : null,
      amount: getProfileAndSetAlertRequestEntity.amount != null ? getProfileAndSetAlertRequestEntity.amount as int : null,
    );
  }

  GetProfileAndSetAlertRequestEntity toEntity() =>
  GetProfileAndSetAlertRequestEntity(
      isForAlert: isForAlert,
      percentage: percentage,
      amount: amount,
  
  );
}
