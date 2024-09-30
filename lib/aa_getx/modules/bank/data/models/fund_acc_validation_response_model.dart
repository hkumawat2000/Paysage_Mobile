
import 'package:lms/aa_getx/modules/bank/domain/entities/fund_acc_validation_response_entity.dart';

class FundAccValidationResponseModel {
  String? message;
  FundAccValidationData? fundAccValidationData;

  FundAccValidationResponseModel({this.message, this.fundAccValidationData});

  FundAccValidationResponseModel.fromJson(Map<String, dynamic> json) {
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

  FundAccValidationResponseEntity toEntity() =>
      FundAccValidationResponseEntity(
        message: message,
        fundAccValidationData: fundAccValidationData?.toEntity(),

      );
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

  FundAccValidationDataEntity toEntity() =>
      FundAccValidationDataEntity(
        favId: favId,
        status: status,

      );
}