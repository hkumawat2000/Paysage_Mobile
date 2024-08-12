// ignore_for_file: public_member_api_docs, sort_constructors_first
class ForceUpdateResponseEntity {
  String? message;
  ForceUpdateResponseDataEntity? forceUpdateDataEntity;
  ForceUpdateResponseEntity({
    this.message,
    this.forceUpdateDataEntity,
  });
}

class ForceUpdateResponseDataEntity {
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
  ForceUpdateResponseDataEntity({
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
}
