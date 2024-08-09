
import 'package:lms/aa_getx/modules/my_loan/domain/entities/lender_response_entity.dart';

class LendersResponseModel {
  String? message;
  List<LenderData>? lenderData;

  LendersResponseModel({this.message, this.lenderData});

  LendersResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      lenderData = <LenderData>[];
      json['data'].forEach((v) {
        lenderData!.add(new LenderData.fromJson(v));
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

  factory LendersResponseModel.fromEntity(LenderResponseEntity lenderResponseEntity) {
    return LendersResponseModel(
      message: lenderResponseEntity.message != null ? lenderResponseEntity.message as String : null,
      lenderData: lenderResponseEntity.lenderData != null ? List<LenderData>.from((lenderResponseEntity.lenderData as List<dynamic>).map<LenderData?>((x) => LenderData.fromEntity(x as LenderDataEntity),),) : null,
    );
  }
}

class LenderData {
  String? name;
  List<String>? levels;
  String? schemeType;

  LenderData({this.name, this.levels, this.schemeType});

  LenderData.fromJson(Map<String, dynamic> json) {
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

  LenderDataEntity toEntity() =>
      LenderDataEntity(
        name: name,
        levels: levels,
        schemeType: schemeType,

      );

  factory LenderData.fromEntity(LenderDataEntity lenderData) {
    return LenderData(
      name: lenderData.name != null ? lenderData.name as String : null,
      levels: lenderData.levels != null ? List<String>.from(lenderData.levels as List<String>) : null,
      schemeType: lenderData.schemeType != null ? lenderData.schemeType as String : null,
    );
  }
}