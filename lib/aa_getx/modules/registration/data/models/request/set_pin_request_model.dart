import 'package:lms/aa_getx/modules/registration/domain/entities/request/set_pin_request_entity.dart';

class SetPinRequestModel{
  String? pin;

  SetPinRequestModel(
      {this.pin});

  SetPinRequestModel.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pin'] = pin;
    return data;
  }

  SetPinRequestEntity toEntity() => SetPinRequestEntity(
    pin: pin,
  );

  factory SetPinRequestModel.fromEntity(
      SetPinRequestEntity setPinParamsEntity) {
    return SetPinRequestModel(
      pin: setPinParamsEntity.pin,
    );
  }

}