import 'package:lms/network/ModelWrapper.dart';

class GetRequestAvailbaleResponse extends ModelWrapper<List<RequestavailableData>> {
  List<RequestavailableData>? requestavailableData ;

  GetRequestAvailbaleResponse({this.requestavailableData});

  GetRequestAvailbaleResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      requestavailableData = <RequestavailableData>[];
      json['data'].forEach((v) {
        requestavailableData!.add(new RequestavailableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestavailableData != null) {
      data['data'] = this.requestavailableData!.map((v) => v.toJson()).toList();

    }
    return data;
  }
}

class RequestavailableData {
  String? name;

  RequestavailableData({this.name});

  RequestavailableData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}