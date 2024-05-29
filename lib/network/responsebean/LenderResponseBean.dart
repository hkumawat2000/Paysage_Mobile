import 'package:lms/network/ModelWrapper.dart';

  class LenderResponseBean extends ModelWrapper<List<LenderData>> {
  String? message;
  List<LenderData>? lenderData;

  LenderResponseBean({this.message, this.lenderData});

  LenderResponseBean.fromJson(Map<String, dynamic> json) {
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
}
