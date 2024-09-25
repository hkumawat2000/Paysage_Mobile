// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/risk_profile_response_entity.dart';

class RiskProfileResponseModel {
  String? message;
  RiskPercentageDataResponseModel? data;

  RiskProfileResponseModel({this.message, this.data});

  RiskProfileResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new RiskPercentageDataResponseModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  RiskProfileResponseEntity toEntity() =>
  RiskProfileResponseEntity(
      message: message,
      data: data?.toEntity(),
  
  );
}

class RiskPercentageDataResponseModel {
  int? riskProfilePercentage;

  RiskPercentageDataResponseModel({this.riskProfilePercentage});

  RiskPercentageDataResponseModel.fromJson(Map<String, dynamic> json) {
    riskProfilePercentage = json['risk_profile_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['risk_profile_percentage'] = this.riskProfilePercentage;
    return data;
  }

  RiskPercentageDataResponseEnitty toEntity() =>
  RiskPercentageDataResponseEnitty(
      riskProfilePercentage: riskProfilePercentage,
  
  );
}
