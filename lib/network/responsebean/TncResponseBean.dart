import 'package:lms/network/ModelWrapper.dart';

class TnCResponseBean extends ModelWrapper<List<TnCData>> {
  List<TnCData>? tnCData;

  TnCResponseBean({this.tnCData});

  TnCResponseBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tnCData = <TnCData>[];
      json['data'].forEach((v) {
        tnCData!.add(new TnCData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tnCData != null) {
      data['data'] = this.tnCData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TnCData {
  String? tnc;
  bool? isCheckUser = true;

  TnCData({this.tnc,this.isCheckUser});

  TnCData.fromJson(Map<String, dynamic> json) {
    tnc = json['tnc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tnc'] = this.tnc;
    return data;
  }
}