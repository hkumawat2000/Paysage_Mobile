import 'package:lms/network/ModelWrapper.dart';

class ProfileListResponse extends ModelWrapper<List<ProfileList>> {
  List<ProfileList>? profileList;

  ProfileListResponse({this.profileList});

  ProfileListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      profileList = <ProfileList>[];
      json['data'].forEach((v) {
        profileList!.add(new ProfileList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileList != null) {
      data['data'] = this.profileList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileList {
  String? name;

  ProfileList({this.name});

  ProfileList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}