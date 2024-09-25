// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/request/approved_securities_request_entity.dart';

class ApprovedSecuritiesRequestModel {
  String? lender;
  int? start;
  int? perPage;
  String? search;
  String? category;
  int? isDownload;
  String? loanType;

  ApprovedSecuritiesRequestModel(
      {this.lender,
      this.start,
      this.perPage,
      this.search,
      this.category,
      this.isDownload,
      this.loanType});

  ApprovedSecuritiesRequestModel.fromJson(Map<String, dynamic> json) {
    lender = json['lender'];
    start = json['start'];
    perPage = json['per_page'];
    search = json['search'];
    category = json['category'];
    isDownload = json['is_download'];
    loanType = json['loan_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lender'] = this.lender;
    data['start'] = this.start;
    data['per_page'] = this.perPage;
    data['search'] = this.search;
    data['category'] = this.category;
    data['is_download'] = this.isDownload;
    data['loan_type'] = this.loanType;
    return data;
  }

  factory ApprovedSecuritiesRequestModel.fromEntity(
      ApprovedSecuritiesRequestEntity approvedSecuritiesRequestEntity) {
    return ApprovedSecuritiesRequestModel(
      lender: approvedSecuritiesRequestEntity.lender != null
          ? approvedSecuritiesRequestEntity.lender as String
          : null,
      start: approvedSecuritiesRequestEntity.start != null
          ? approvedSecuritiesRequestEntity.start as int
          : null,
      perPage: approvedSecuritiesRequestEntity.perPage != null
          ? approvedSecuritiesRequestEntity.perPage as int
          : null,
      search: approvedSecuritiesRequestEntity.search != null
          ? approvedSecuritiesRequestEntity.search as String
          : null,
      category: approvedSecuritiesRequestEntity.category != null
          ? approvedSecuritiesRequestEntity.category as String
          : null,
      isDownload: approvedSecuritiesRequestEntity.isDownload != null
          ? approvedSecuritiesRequestEntity.isDownload as int
          : null,
      loanType: approvedSecuritiesRequestEntity.loanType != null
          ? approvedSecuritiesRequestEntity.loanType as String
          : null,
    );
  }
}
