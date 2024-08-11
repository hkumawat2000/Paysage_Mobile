import 'dart:convert';

import 'package:lms/aa_getx/modules/account_settings/domain/entities/request/update_profile_and_pin_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateProfileAndPinRequestModel {
  int? isForUpdatePin;
  int? isForProfilePic;
  String? oldPin;
  String? newPin;
  String? retypePin;
  String? image;
  
  UpdateProfileAndPinRequestModel({
    this.isForUpdatePin,
    this.isForProfilePic,
    this.oldPin,
    this.newPin,
    this.retypePin,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'is_for_update_pin': isForUpdatePin,
      'is_for_profile_pic': isForProfilePic,
      'old_pin': oldPin,
      'new_pin': newPin,
      'retype_pin': retypePin,
      'image': image,
    };
  }

  factory UpdateProfileAndPinRequestModel.fromMap(Map<String, dynamic> map) {
    return UpdateProfileAndPinRequestModel(
      isForUpdatePin: map['is_for_update_pin'] != null ? map['is_for_update_pin'] as int : null,
      isForProfilePic: map['is_for_profile_pic'] != null ? map['is_for_profile_pic'] as int : null,
      oldPin: map['old_pin'] != null ? map['old_pin'] as String : null,
      newPin: map['new_pin'] != null ? map['new_pin'] as String : null,
      retypePin: map['retype_pin'] != null ? map['retype_pin'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfileAndPinRequestModel.fromJson(String source) => UpdateProfileAndPinRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UpdateProfileAndPinRequestEntity toEntity() =>
  UpdateProfileAndPinRequestEntity(
      isForUpdatePin: isForUpdatePin,
      isForProfilePic: isForProfilePic,
      oldPin: oldPin,
      newPin: newPin,
      retypePin: retypePin,
      image: image,
  
  );

  factory UpdateProfileAndPinRequestModel.fromEntity(UpdateProfileAndPinRequestEntity updateProfileAndPinRequestEntity) {
    return UpdateProfileAndPinRequestModel(
      isForUpdatePin: updateProfileAndPinRequestEntity.isForUpdatePin != null ? updateProfileAndPinRequestEntity.isForUpdatePin as int : null,
      isForProfilePic: updateProfileAndPinRequestEntity.isForProfilePic != null ? updateProfileAndPinRequestEntity.isForProfilePic as int : null,
      oldPin: updateProfileAndPinRequestEntity.oldPin != null ? updateProfileAndPinRequestEntity.oldPin as String : null,
      newPin: updateProfileAndPinRequestEntity.newPin != null ? updateProfileAndPinRequestEntity.newPin as String : null,
      retypePin: updateProfileAndPinRequestEntity.retypePin != null ? updateProfileAndPinRequestEntity.retypePin as String : null,
      image: updateProfileAndPinRequestEntity.image != null ? updateProfileAndPinRequestEntity.image as String : null,
    );
  }
}
