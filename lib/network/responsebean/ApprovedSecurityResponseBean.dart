import 'package:choice/network/ModelWrapper.dart';

class ApprovedSecurityResponseBean extends ModelWrapper<ApprovedSecuritiesData> {
  String? message;
  ApprovedSecuritiesData? data;

  ApprovedSecurityResponseBean({this.message, this.data});

  ApprovedSecurityResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new ApprovedSecuritiesData.fromJson(json['data']) : null;
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

class ApprovedSecuritiesData {
  List<String>? securityCategoryList;
  List<ApprovedSecuritiesList>? approvedSecuritiesList;
  String? pdfFileUrl;

  ApprovedSecuritiesData(
      {this.securityCategoryList,
        this.approvedSecuritiesList,
        this.pdfFileUrl});

  ApprovedSecuritiesData.fromJson(Map<String, dynamic> json) {
    securityCategoryList = json['security_category_list'].cast<String>();
    if (json['approved_securities_list'] != null) {
      approvedSecuritiesList = <ApprovedSecuritiesList>[];
      json['approved_securities_list'].forEach((v) {
        approvedSecuritiesList!.add(new ApprovedSecuritiesList.fromJson(v));
      });
    }
    pdfFileUrl = json['pdf_file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['security_category_list'] = this.securityCategoryList;
    if (this.approvedSecuritiesList != null) {
      data['approved_securities_list'] =
          this.approvedSecuritiesList!.map((v) => v.toJson()).toList();
    }
    data['pdf_file_url'] = this.pdfFileUrl;
    return data;
  }
}

class ApprovedSecuritiesList {
  String? isin;
  String? securityName;
  String? securityCategory;
  double? eligiblePercentage;

  ApprovedSecuritiesList(
      {this.isin,
        this.securityName,
        this.securityCategory,
        this.eligiblePercentage});

  ApprovedSecuritiesList.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    securityName = json['security_name'];
    securityCategory = json['security_category'];
    eligiblePercentage = json['eligible_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['security_name'] = this.securityName;
    data['security_category'] = this.securityCategory;
    data['eligible_percentage'] = this.eligiblePercentage;
    return data;
  }
}