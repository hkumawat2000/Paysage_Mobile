import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';

class LoanStatementRequestModel {
  String? loanName;
  String? type;
  String? duration;
  String? fromDate;
  String? toDate;
  String? fileFormat;
  int? isDownload;
  int? isEmail;

  LoanStatementRequestModel(
      {this.loanName,
        this.type,
        this.duration,
        this.fromDate,
        this.toDate,
        this.fileFormat,
        this.isDownload,
        this.isEmail});

  LoanStatementRequestModel.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    type = json['type'];
    duration = json['duration'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    fileFormat = json['file_format'];
    isDownload = json['is_download'];
    isEmail = json['is_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['file_format'] = this.fileFormat;
    data['is_download'] = this.isDownload;
    data['is_email'] = this.isEmail;
    return data;
  }

  factory LoanStatementRequestModel.fromEntity(LoanStatementRequestEntity loanStatementRequestEntity) {
    return LoanStatementRequestModel(
      loanName: loanStatementRequestEntity.loanName != null ? loanStatementRequestEntity.loanName as String : null,
      type: loanStatementRequestEntity.type != null ? loanStatementRequestEntity.type as String : null,
      duration: loanStatementRequestEntity.duration != null ? loanStatementRequestEntity.duration as String : null,
      fromDate: loanStatementRequestEntity.fromDate != null ? loanStatementRequestEntity.fromDate as String : null,
      toDate: loanStatementRequestEntity.toDate != null ? loanStatementRequestEntity.toDate as String : null,
      fileFormat: loanStatementRequestEntity.fileFormat != null ? loanStatementRequestEntity.fileFormat as String : null,
      isDownload: loanStatementRequestEntity.isDownload != null ? loanStatementRequestEntity.isDownload as int : null,
      isEmail: loanStatementRequestEntity.isEmail != null ? loanStatementRequestEntity.isEmail as int : null,
    );
  }
}
