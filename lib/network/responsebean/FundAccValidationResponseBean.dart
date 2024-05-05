import 'package:choice/network/ModelWrapper.dart';

class FundAccValidationResponseBean extends ModelWrapper{
  String? message;
  FundAccValidationData? fundAccValidationData;

  FundAccValidationResponseBean({this.message, this.fundAccValidationData});

  FundAccValidationResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fundAccValidationData = json['data'] != null ? new FundAccValidationData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.fundAccValidationData != null) {
      data['data'] = this.fundAccValidationData!.toJson();
    }
    return data;
  }
}

class FundAccValidationData {
  String? favId;
  String? status;

  FundAccValidationData({this.favId, this.status});

  FundAccValidationData.fromJson(Map<String, dynamic> json) {
    favId = json['fav_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fav_id'] = this.favId;
    data['status'] = this.status;
    return data;
  }
}
