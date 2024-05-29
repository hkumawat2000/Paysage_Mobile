import 'package:lms/network/ModelWrapper.dart';

class MFSchemeResponse extends ModelWrapper<MFSchemeData> {
  MFSchemeData? mFSchemeData;

  MFSchemeResponse({this.mFSchemeData});

  MFSchemeResponse.fromJson(Map<String, dynamic> json) {
    mFSchemeData =
        json['data'] != null ? new MFSchemeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mFSchemeData != null) {
      data['data'] = this.mFSchemeData!.toJson();
    }
    return data;
  }
}

class MFSchemeData {
  List<SchemesList>? schemesList;

  MFSchemeData({this.schemesList});

  MFSchemeData.fromJson(Map<String, dynamic> json) {
    if (json['schemes_list'] != null) {
      schemesList = <SchemesList>[];
      json['schemes_list'].forEach((v) {
        schemesList!.add(new SchemesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schemesList != null) {
      data['schemes_list'] = this.schemesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SchemesList {
  String? isin;
  String? schemeName;
  double? ltv;
  String? instrumentType;
  String? schemeType;
  double? price;
  String? lenders;
  String? amcCode;
  String? amcImage;
  double? units;
  double? schemeValue;
  double? eligibleLoanAmount;

  SchemesList(
      {this.isin,
      this.schemeName,
      this.ltv,
      this.instrumentType,
      this.schemeType,
      this.price,
      this.lenders,
      this.amcCode,
      this.amcImage,
      this.units,
      this.schemeValue,
      this.eligibleLoanAmount});

  SchemesList.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    schemeName = json['scheme_name'];
    ltv = json['ltv'];
    instrumentType = json['instrument_type'];
    schemeType = json['scheme_type'];
    price = json['price'];
    lenders = json['lenders'];
    amcCode = json['amc_code'];
    amcImage = json['amc_image'];
    units = json['units'];
    schemeValue = json['scheme_value'];
    eligibleLoanAmount = json['eligible_loan_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['scheme_name'] = this.schemeName;
    data['ltv'] = this.ltv;
    data['instrument_type'] = this.instrumentType;
    data['scheme_type'] = this.schemeType;
    data['price'] = this.price;
    data['lenders'] = this.lenders;
    data['amc_code'] = this.amcCode;
    data['amc_image'] = this.amcImage;
    data['units'] = this.units;
    data['scheme_value'] = this.schemeValue;
    data['eligible_loan_amount'] = this.eligibleLoanAmount;
    return data;
  }
}
