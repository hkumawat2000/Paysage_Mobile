import 'package:lms/network/ModelWrapper.dart';

class ForceUpdateResponse extends ModelWrapper{
  String? message;
  UpdateData? updateData;

  ForceUpdateResponse({this.message, this.updateData});

  ForceUpdateResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updateData = json['data'] != null ? new UpdateData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updateData != null) {
      data['data'] = this.updateData!.toJson();
    }
    return data;
  }
}

class UpdateData {
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

  UpdateData(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.forceUpdate,
        this.idx,
        this.androidVersion,
        this.playStoreLink,
        this.whatsNew,
        this.iosVersion,
        this.appStoreLink,
        this.releaseDate});

  UpdateData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    forceUpdate = json['force_update'];
    idx = json['idx'];
    androidVersion = json['android_version'];
    playStoreLink = json['play_store_link'];
    whatsNew = json['whats_new'];
    iosVersion = json['ios_version'];
    appStoreLink = json['app_store_link'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['force_update'] = this.forceUpdate;
    data['idx'] = this.idx;
    data['android_version'] = this.androidVersion;
    data['play_store_link'] = this.playStoreLink;
    data['whats_new'] = this.whatsNew;
    data['ios_version'] = this.iosVersion;
    data['app_store_link'] = this.appStoreLink;
    data['release_date'] = this.releaseDate;
    return data;
  }
}
