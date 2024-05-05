import 'package:choice/network/ModelWrapper.dart';

class IsinDetailResponseBean extends ModelWrapper<IsinDetailsData> {
  String? message;
  IsinDetailsData? data;

  IsinDetailResponseBean({this.message, this.data});

  IsinDetailResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new IsinDetailsData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class IsinDetailsData {
  List<IsinDetails>? isinDetails;

  IsinDetailsData({this.isinDetails});

  IsinDetailsData.fromJson(Map<String, dynamic> json) {
    if (json['isin_details'] != null) {
      isinDetails = <IsinDetails>[];
      json['isin_details'].forEach((v) {
        isinDetails!.add(new IsinDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.isinDetails != null) {
      data['isin_details'] = this.isinDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IsinDetails {
  String? isin;
  double? ltv;
  String? category;
  String? name;
  double? minimumSanctionedLimit;
  double? maximumSanctionedLimit;
  double? rateOfInterest;

  IsinDetails({
    this.isin,
    this.ltv,
    this.category,
    this.name,
    this.minimumSanctionedLimit,
    this.maximumSanctionedLimit,
    this.rateOfInterest,
  });

  IsinDetails.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    ltv = json['ltv'];
    category = json['category'];
    name = json['name'];
    minimumSanctionedLimit = json['minimum_sanctioned_limit'];
    maximumSanctionedLimit = json['maximum_sanctioned_limit'];
    rateOfInterest = json['rate_of_interest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['ltv'] = this.ltv;
    data['category'] = this.category;
    data['name'] = this.name;
    data['minimum_sanctioned_limit'] = this.minimumSanctionedLimit;
    data['maximum_sanctioned_limit'] = this.maximumSanctionedLimit;
    data['rate_of_interest'] = this.rateOfInterest;
    return data;
  }
}
