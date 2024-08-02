
import 'package:lms/aa_getx/modules/more/domain/entities/request/get_profile_set_alert_request_entity.dart';

class GetProfileSetAlertRequestModel{
  int? isForAlert;
  int? percentage;
  int? amount;

  GetProfileSetAlertRequestModel({this.isForAlert, this.percentage, this.amount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_for_alerts'] = this.isForAlert;
    data['percentage'] = this.percentage;
    data['amount'] = this.amount;
    return data;
  }

  factory GetProfileSetAlertRequestModel.fromEntity(
      GetProfileSetAlertRequestEntity getProfileSetAlertRequestEntity) {
    return GetProfileSetAlertRequestModel(
      amount: getProfileSetAlertRequestEntity.amount,
      isForAlert: getProfileSetAlertRequestEntity.isForAlert,
      percentage: getProfileSetAlertRequestEntity.percentage,
    );
  }
}
