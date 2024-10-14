// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lms/aa_getx/modules/lender/domain/entities/lender_response_entity.dart';

class LenderResponseModel {
  String? message;
  List<LenderDataResponseModel>? lenderData;

  LenderResponseModel({this.message, this.lenderData});

  LenderResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      lenderData = <LenderDataResponseModel>[];
      json['data'].forEach((v) {
        lenderData!.add(new LenderDataResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.lenderData != null) {
      data['data'] = this.lenderData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  LenderResponseEntity toEntity() =>
  LenderResponseEntity(
      message: message,
      lenderData: lenderData?.map((x) => x.toEntity()).toList(),
  
  );
}

class LenderDataResponseModel {
  String? name;
  List<String>? levels;
  String? schemeType;

  LenderDataResponseModel({this.name, this.levels, this.schemeType});

  LenderDataResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    levels = json['levels'].cast<String>();
    schemeType = json['scheme_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['levels'] = this.levels;
    data['scheme_type'] = this.schemeType;
    return data;
  }

  LenderDataResponseEntity toEntity() =>
  LenderDataResponseEntity(
      name: name,
      levels: levels,
      schemeType: schemeType,
  
  );
}
