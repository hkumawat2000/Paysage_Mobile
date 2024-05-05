import 'package:choice/network/ModelWrapper.dart';
class CkycDownloadResponse extends ModelWrapper<DownloadData> {
  String? message;
  DownloadData? downloadData;

  CkycDownloadResponse({this.message, this.downloadData});

  CkycDownloadResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    downloadData = json['data'] != null ? new DownloadData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.downloadData != null) {
      data['data'] = this.downloadData!.toJson();
    }
    return data;
  }
}

class DownloadData {
  String? userKycName;

  DownloadData({this.userKycName});

  DownloadData.fromJson(Map<String, dynamic> json) {
    userKycName = json['user_kyc_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_kyc_name'] = this.userKycName;
    return data;
  }
}
