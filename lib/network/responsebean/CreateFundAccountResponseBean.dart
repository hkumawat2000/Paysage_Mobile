import 'package:lms/network/ModelWrapper.dart';

class CreateFundAccountResponseBean extends ModelWrapper {
  String? message;
  FundData? fundData;

  CreateFundAccountResponseBean({this.message, this.fundData});

  CreateFundAccountResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fundData = json['data'] != null ? new FundData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.fundData != null) {
      data['data'] = this.fundData!.toJson();
    }
    return data;
  }
}

class FundData {
  String? faId;

  FundData({this.faId});

  FundData.fromJson(Map<String, dynamic> json) {
    faId = json['fa_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fa_id'] = this.faId;
    return data;
  }
}
