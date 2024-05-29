import 'package:lms/network/ModelWrapper.dart';

class UpdateProfileAndPinResponseBean extends ModelWrapper<UpdatedData>{
  String? message;
  UpdatedData? updatedData;

  UpdateProfileAndPinResponseBean({this.message, this.updatedData});

  UpdateProfileAndPinResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    updatedData = json['data'] != null ? new UpdatedData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.updatedData != null) {
      data['data'] = this.updatedData!.toJson();
    }
    return data;
  }
}

class UpdatedData {
  String? profilePictureFileUrl;

  UpdatedData({this.profilePictureFileUrl});

  UpdatedData.fromJson(Map<String, dynamic> json) {
    profilePictureFileUrl = json['profile_picture_file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_picture_file_url'] = this.profilePictureFileUrl;
    return data;
  }
}
