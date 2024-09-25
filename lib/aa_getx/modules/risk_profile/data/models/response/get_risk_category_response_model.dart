// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';

class GetRiskCategoryResponseModel {
  String? message;
  List<RishCategoryDataModel>? data;

  GetRiskCategoryResponseModel({this.message, this.data});

  GetRiskCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RishCategoryDataModel>[];
      json['data'].forEach((v) {
        data!.add(new RishCategoryDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  GetRiskCategoryResponseEntity toEntity() =>
  GetRiskCategoryResponseEntity(
      message: message,
      categoryDataList: data?.map((x) => x.toEntity()).toList(),
  
  );
}

class RishCategoryDataModel {
  String? category;
  List<String>? subCategoryList;

  RishCategoryDataModel({this.category, this.subCategoryList});

  RishCategoryDataModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    subCategoryList = json['sub category list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['sub category list'] = this.subCategoryList;
    return data;
  }

  RishCategoryDataEntity toEntity() =>
  RishCategoryDataEntity(
      category: category,
      subCategoryList: subCategoryList,
  
  );
}
