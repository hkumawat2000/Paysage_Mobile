// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/request/risk_profile_request_entity.dart';

class RishProfileRequestModel {
  List<RiskProfileRequestDataModel>? data;

  RishProfileRequestModel({this.data});

  RishProfileRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <RiskProfileRequestDataModel>[];
      json['data'].forEach((v) {
        data!.add(new RiskProfileRequestDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  RishProfileRequestEntity toEntity() =>
  RishProfileRequestEntity(
      data: data?.map((x) => x.toEntity()).toList(),
  );

  factory RishProfileRequestModel.fromEntity(RishProfileRequestEntity rishProfileRequestEntity) {
    return RishProfileRequestModel(
      data: rishProfileRequestEntity.data != null ? List<RiskProfileRequestDataModel>.from((rishProfileRequestEntity.data as List<dynamic>).map<RiskProfileRequestDataModel?>((x) => RiskProfileRequestDataModel.fromEntity(x as RiskProfileRequestDataEntity),),) : null,
    );
  }
}

class RiskProfileRequestDataModel {
  String? category;
  String? subCategory;

  RiskProfileRequestDataModel({this.category, this.subCategory});

  RiskProfileRequestDataModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    subCategory = json['sub_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    return data;
  }

  RiskProfileRequestDataEntity toEntity() =>
  RiskProfileRequestDataEntity(
      category: category,
      subCategory: subCategory,
  );

  factory RiskProfileRequestDataModel.fromEntity(RiskProfileRequestDataEntity riskProfileRequestDataEntity) {
    return RiskProfileRequestDataModel(
      category: riskProfileRequestDataEntity.category != null ? riskProfileRequestDataEntity.category as String : null,
      subCategory: riskProfileRequestDataEntity.subCategory != null ? riskProfileRequestDataEntity.subCategory as String : null,
    );
  }
}
