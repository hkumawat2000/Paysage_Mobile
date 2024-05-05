import '../ModelWrapper.dart';

class PinCodeResponseBean extends ModelWrapper<PinCodeData> {
  String? message;
  PinCodeData? data;

  PinCodeResponseBean({this.message, this.data});

  PinCodeResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new PinCodeData.fromJson(json['data']) : null;
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

class PinCodeData {
  String? district;
  String? state;

  PinCodeData({this.district, this.state});

  PinCodeData.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['state'] = this.state;
    return data;
  }
}
