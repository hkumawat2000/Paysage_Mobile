import 'package:choice/network/ModelWrapper.dart';

class TopUpResponse extends ModelWrapper<TopUpData>{
  String? message;
  TopUpData? topUpData;

  TopUpResponse({this.message, this.topUpData});

  TopUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    topUpData = json['data'] != null ? new TopUpData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.topUpData != null) {
      data['data'] = this.topUpData!.toJson();
    }
    return data;
  }
}

class TopUpData {
  String? topupApplicationName;

  TopUpData({this.topupApplicationName});

  TopUpData.fromJson(Map<String, dynamic> json) {
    topupApplicationName = json['topup_application_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['topup_application_name'] = this.topupApplicationName;
    return data;
  }
}
