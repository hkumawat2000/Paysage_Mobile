// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/approved_securities_response_entity.dart';

class ApprovedSecuritiesResponseModel {
  String? message;
  ApprovedSecuritiesDataResponseModel? data;

  ApprovedSecuritiesResponseModel({
    this.message,
    this.data,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'data': data?.toJson(),
    };
  }

  factory ApprovedSecuritiesResponseModel.fromJson(Map<String, dynamic> map) {
    return ApprovedSecuritiesResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? ApprovedSecuritiesDataResponseModel.fromJson(
              map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  ApprovedSecuritiesResponseEntity toEntity() =>
  ApprovedSecuritiesResponseEntity(
      message: message,
      data: data?.toEntity(),
  
  );
}

class ApprovedSecuritiesDataResponseModel {
  List<String>? securityCategoryList;
  List<ApprovedSecuritiesListResponseModel>? approvedSecuritiesList;
  String? pdfFileUrl;
  ApprovedSecuritiesDataResponseModel({
    this.securityCategoryList,
    this.approvedSecuritiesList,
    this.pdfFileUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'security_category_list': securityCategoryList,
      'approved_securities_list': approvedSecuritiesList!.map((x) => x?.toJson()).toList(),
      'pdf_file_url': pdfFileUrl,
    };
  }

  factory ApprovedSecuritiesDataResponseModel.fromJson(Map<String, dynamic> map) {
    return ApprovedSecuritiesDataResponseModel(
      securityCategoryList: map['security_category_list'] != null ? List<String>.from((map['security_category_list'] as List<String>)) : null,
      approvedSecuritiesList: map['approved_securities_list'] != null ? List<ApprovedSecuritiesListResponseModel>.from((map['approved_securities_list'] as List<int>).map<ApprovedSecuritiesListResponseModel?>((x) => ApprovedSecuritiesListResponseModel.fromJson(x as Map<String,dynamic>),),) : null,
      pdfFileUrl: map['pdf_file_url'] != null ? map['pdf_file_url'] as String : null,
    );
  }

  ApprovedSecuritiesDataResponseEntity toEntity() =>
  ApprovedSecuritiesDataResponseEntity(
      securityCategoryList: securityCategoryList,
      approvedSecuritiesList: approvedSecuritiesList?.map((x) => x.toEntity()).toList(),
      pdfFileUrl: pdfFileUrl,
  
  );
}

class ApprovedSecuritiesListResponseModel {
  String? isin;
  String? securityName;
  String? securityCategory;
  double? eligiblePercentage;
  ApprovedSecuritiesListResponseModel({
    this.isin,
    this.securityName,
    this.securityCategory,
    this.eligiblePercentage,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'isin': isin,
      'security_name': securityName,
      'security_category': securityCategory,
      'eligible_percentage': eligiblePercentage,
    };
  }

  factory ApprovedSecuritiesListResponseModel.fromJson(Map<String, dynamic> map) {
    return ApprovedSecuritiesListResponseModel(
      isin: map['isin'] != null ? map['isin'] as String : null,
      securityName: map['security_name'] != null ? map['security_name'] as String : null,
      securityCategory: map['security_category'] != null ? map['security_category'] as String : null,
      eligiblePercentage: map['eligible_percentage'] != null ? map['eligible_percentage'] as double : null,
    );
  }

  ApprovedSecuritiesListResponseEntity toEntity() =>
  ApprovedSecuritiesListResponseEntity(
      isin: isin,
      securityName: securityName,
      securityCategory: securityCategory,
      eligiblePercentage: eligiblePercentage,
  
  );
}
