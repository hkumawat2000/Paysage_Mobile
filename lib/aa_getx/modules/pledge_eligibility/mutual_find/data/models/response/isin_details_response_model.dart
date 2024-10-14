// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/isin_details_response_entity.dart';

class IsinDetailResponseModel {
  String? message;
  IsinDetailsDataResponseModel? data;

  IsinDetailResponseModel({this.message, this.data});

  IsinDetailResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null
        ? new IsinDetailsDataResponseModel.fromJson(json['data'])
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

  IsinDetailResponseEntity toEntity() =>
  IsinDetailResponseEntity(
      message: message,
      data: data?.toEntity(),
  
  );
}

class IsinDetailsDataResponseModel {
  List<IsinDetailsResponseModel>? isinDetails;

  IsinDetailsDataResponseModel({this.isinDetails});

  IsinDetailsDataResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['isin_details'] != null) {
      isinDetails = <IsinDetailsResponseModel>[];
      json['isin_details'].forEach((v) {
        isinDetails!.add(new IsinDetailsResponseModel.fromJson(v));
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

  IsinDetailsDataResponseEntity toEntity() =>
  IsinDetailsDataResponseEntity(
      isinDetails: isinDetails?.map((x) => x.toEntity()).toList(),
  
  );
}

class IsinDetailsResponseModel {
  String? isin;
  double? ltv;
  String? category;
  String? name;
  double? minimumSanctionedLimit;
  double? maximumSanctionedLimit;
  double? rateOfInterest;

  IsinDetailsResponseModel({
    this.isin,
    this.ltv,
    this.category,
    this.name,
    this.minimumSanctionedLimit,
    this.maximumSanctionedLimit,
    this.rateOfInterest,
  });

  IsinDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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

  IsinDetailsResponseEntity toEntity() =>
  IsinDetailsResponseEntity(
      isin: isin,
      ltv: ltv,
      category: category,
      name: name,
      minimumSanctionedLimit: minimumSanctionedLimit,
      maximumSanctionedLimit: maximumSanctionedLimit,
      rateOfInterest: rateOfInterest,
  
  );
}
