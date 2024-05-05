import '../ModelWrapper.dart';

class ESignResponse extends ModelWrapper<ESignData> {
  String? message;
  ESignData? data;

  ESignResponse({this.message});

  ESignResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ESignData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ESignData {
  String? esignUrl;
  String? fileId;

  ESignData({this.esignUrl, this.fileId});

  ESignData.fromJson(Map<String, dynamic> json) {
    esignUrl = json['esign_url'];
    fileId = json['file_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['esign_url'] = this.esignUrl;
    data['file_id'] = this.fileId;
    return data;
  }
}