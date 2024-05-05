import 'dart:typed_data';

class UpdateProfileAndPinRequestBean {
  int? isForUpdatePin;
  String? oldPin;
  String? newPin;
  String? retypePin;
  int? isForProfilePic;
  String? image;

  UpdateProfileAndPinRequestBean(
      {this.isForUpdatePin,
        this.oldPin,
        this.newPin,
        this.retypePin,
        this.isForProfilePic,
        this.image});

  UpdateProfileAndPinRequestBean.fromJson(Map<String, dynamic> json) {
    isForUpdatePin = json['is_for_update_pin'];
    oldPin = json['old_pin'];
    newPin = json['new_pin'];
    retypePin = json['retype_pin'];
    isForProfilePic = json['is_for_profile_pic'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_for_update_pin'] = this.isForUpdatePin;
    data['old_pin'] = this.oldPin;
    data['new_pin'] = this.newPin;
    data['retype_pin'] = this.retypePin;
    data['is_for_profile_pic'] = this.isForProfilePic;
    data['image'] = this.image;
    return data;
  }
}
