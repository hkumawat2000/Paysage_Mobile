import 'dart:convert';

import 'package:lms/aa_getx/modules/dashboard/domain/entities/force_update_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForceUpdateResponseModel {
  String? message;
  ForceUpdateResponseDataModel? forceUpdateData;
  
  ForceUpdateResponseModel({
    this.message,
    this.forceUpdateData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': forceUpdateData?.toMap(),
    };
  }

  factory ForceUpdateResponseModel.fromMap(Map<String, dynamic> map) {
    return ForceUpdateResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      forceUpdateData: map['data'] != null ? ForceUpdateResponseDataModel.fromMap(map['data'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForceUpdateResponseModel.fromJson(String source) => ForceUpdateResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ForceUpdateResponseEntity toEntity() =>
  ForceUpdateResponseEntity(
      message: message,
      forceUpdateDataEntity: forceUpdateData?.toEntity(),
  
  );

  factory ForceUpdateResponseModel.fromEntity(ForceUpdateResponseEntity forceUpdateResponseEntity) {
    return ForceUpdateResponseModel(
      message: forceUpdateResponseEntity.message != null ? forceUpdateResponseEntity.message as String : null,
      forceUpdateData: forceUpdateResponseEntity.forceUpdateDataEntity != null ? ForceUpdateResponseDataModel.fromEntity(forceUpdateResponseEntity.forceUpdateDataEntity as ForceUpdateResponseDataEntity) : null,
    );
  }
}

class ForceUpdateResponseDataModel {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? androidVersion;
  String? playStoreLink;
  String? whatsNew;
  String? iosVersion;
  String? appStoreLink;
  String? releaseDate;
  int? forceUpdate;

  ForceUpdateResponseDataModel({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    this.idx,
    this.androidVersion,
    this.playStoreLink,
    this.whatsNew,
    this.iosVersion,
    this.appStoreLink,
    this.releaseDate,
    this.forceUpdate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'creation': creation,
      'modified': modified,
      'modified_by': modifiedBy,
      'owner': owner,
      'docstatus': docstatus,
      'idx': idx,
      'android_version': androidVersion,
      'play_store_link': playStoreLink,
      'whats_new': whatsNew,
      'ios_version': iosVersion,
      'app_store_link': appStoreLink,
      'release_date': releaseDate,
      'force_update': forceUpdate,
    };
  }

  factory ForceUpdateResponseDataModel.fromMap(Map<String, dynamic> map) {
    return ForceUpdateResponseDataModel(
      name: map['name'] != null ? map['name'] as String : null,
      creation: map['creation'] != null ? map['creation'] as String : null,
      modified: map['modified'] != null ? map['modified'] as String : null,
      modifiedBy: map['modified_by'] != null ? map['modified_by'] as String : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      docstatus: map['docstatus'] != null ? map['docstatus'] as int : null,
      idx: map['idx'] != null ? map['idx'] as int : null,
      androidVersion: map['android_version'] != null ? map['android_version'] as String : null,
      playStoreLink: map['play_store_link'] != null ? map['play_store_link'] as String : null,
      whatsNew: map['whats_new'] != null ? map['whats_new'] as String : null,
      iosVersion: map['ios_version'] != null ? map['ios_version'] as String : null,
      appStoreLink: map['app_store_link'] != null ? map['app_store_link'] as String : null,
      releaseDate: map['release_date'] != null ? map['release_date'] as String : null,
      forceUpdate: map['force_update'] != null ? map['force_update'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForceUpdateResponseDataModel.fromJson(String source) => ForceUpdateResponseDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ForceUpdateResponseDataEntity toEntity() =>
  ForceUpdateResponseDataEntity(
      name: name,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      owner: owner,
      docstatus: docstatus,
      idx: idx,
      androidVersion: androidVersion,
      playStoreLink: playStoreLink,
      whatsNew: whatsNew,
      iosVersion: iosVersion,
      appStoreLink: appStoreLink,
      releaseDate: releaseDate,
      forceUpdate: forceUpdate,
  
  );

  factory ForceUpdateResponseDataModel.fromEntity(ForceUpdateResponseDataEntity forceUpdateResponseDataEntity) {
    return ForceUpdateResponseDataModel(
      name: forceUpdateResponseDataEntity.name != null ? forceUpdateResponseDataEntity.name as String : null,
      creation: forceUpdateResponseDataEntity.creation != null ? forceUpdateResponseDataEntity.creation as String : null,
      modified: forceUpdateResponseDataEntity.modified != null ? forceUpdateResponseDataEntity.modified as String : null,
      modifiedBy: forceUpdateResponseDataEntity.modifiedBy != null ? forceUpdateResponseDataEntity.modifiedBy as String : null,
      owner: forceUpdateResponseDataEntity.owner != null ? forceUpdateResponseDataEntity.owner as String : null,
      docstatus: forceUpdateResponseDataEntity.docstatus != null ? forceUpdateResponseDataEntity.docstatus as int : null,
      idx: forceUpdateResponseDataEntity.idx != null ? forceUpdateResponseDataEntity.idx as int : null,
      androidVersion: forceUpdateResponseDataEntity.androidVersion != null ? forceUpdateResponseDataEntity.androidVersion as String : null,
      playStoreLink: forceUpdateResponseDataEntity.playStoreLink != null ? forceUpdateResponseDataEntity.playStoreLink as String : null,
      whatsNew: forceUpdateResponseDataEntity.whatsNew != null ? forceUpdateResponseDataEntity.whatsNew as String : null,
      iosVersion: forceUpdateResponseDataEntity.iosVersion != null ? forceUpdateResponseDataEntity.iosVersion as String : null,
      appStoreLink: forceUpdateResponseDataEntity.appStoreLink != null ? forceUpdateResponseDataEntity.appStoreLink as String : null,
      releaseDate: forceUpdateResponseDataEntity.releaseDate != null ? forceUpdateResponseDataEntity.releaseDate as String : null,
      forceUpdate: forceUpdateResponseDataEntity.forceUpdate != null ? forceUpdateResponseDataEntity.forceUpdate as int : null,
    );
  }
}
