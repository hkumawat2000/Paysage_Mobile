import 'package:lms/network/ModelWrapper.dart';

class CkycSearchResponse extends ModelWrapper<SearchData>{
  String? message;
  SearchData? searchData;

  CkycSearchResponse({this.message, this.searchData});

  CkycSearchResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    searchData = json['data'] != null ? new SearchData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.searchData != null) {
      data['data'] = this.searchData!.toJson();
    }
    return data;
  }
}

class SearchData {
  String? ckycNo;

  SearchData({this.ckycNo});

  SearchData.fromJson(Map<String, dynamic> json) {
    ckycNo = json['ckyc_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ckyc_no'] = this.ckycNo;
    return data;
  }
}
