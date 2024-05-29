import 'package:lms/network/ModelWrapper.dart';

class AllLoanNamesResponse extends ModelWrapper<List<AllLoansNameData>> {
  String? message;
  List<AllLoansNameData>? allLoansNameData;

  AllLoanNamesResponse({this.message, this.allLoansNameData});

  AllLoanNamesResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      allLoansNameData = <AllLoansNameData>[];
      json['data'].forEach((v) {
        allLoansNameData!.add(new AllLoansNameData.fromJson(v));
      });
      data = allLoansNameData;
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
}

class AllLoansNameData {
  String? name;

  AllLoansNameData({this.name});

  AllLoansNameData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}