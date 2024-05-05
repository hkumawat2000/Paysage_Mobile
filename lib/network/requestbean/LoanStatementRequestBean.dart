class LoanStatementRequestBean {
  String? loanName;
  String? type;
  String? duration;
  String? fromDate;
  String? toDate;
  String? fileFormat;
  int? isDownload;
  int? isEmail;

  LoanStatementRequestBean(
      {this.loanName,
        this.type,
        this.duration,
        this.fromDate,
        this.toDate,
        this.fileFormat,
        this.isDownload,
        this.isEmail});

  LoanStatementRequestBean.fromJson(Map<String, dynamic> json) {
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
}
