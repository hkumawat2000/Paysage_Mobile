import 'dart:convert';

import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_data_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateDataResponseModel {
  String? profilePicturesFileUrl;
  
  UpdateDataResponseModel({
    this.profilePicturesFileUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profile_picture_file_url': profilePicturesFileUrl,
    };
  }

  factory UpdateDataResponseModel.fromMap(Map<String, dynamic> map) {
    return UpdateDataResponseModel(
      profilePicturesFileUrl: map['profile_picture_file_url'] != null ? map['profile_picture_file_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateDataResponseModel.fromJson(String source) => UpdateDataResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UpdateDataResponseEntity toEntity() =>
  UpdateDataResponseEntity(
      profilePicturesFileUrl: profilePicturesFileUrl,
  
  );

  factory UpdateDataResponseModel.fromEntity(UpdateDataResponseEntity updateDataResponseEntity) {
    return UpdateDataResponseModel(
      profilePicturesFileUrl: updateDataResponseEntity.profilePicturesFileUrl != null ? updateDataResponseEntity.profilePicturesFileUrl as String : null,
    );
  }
}
