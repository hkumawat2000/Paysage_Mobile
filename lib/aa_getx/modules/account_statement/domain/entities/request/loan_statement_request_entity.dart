
class LoanStatementRequestEntity {
  String? loanName;
  String? type;
  String? duration;
  String? fromDate;
  String? toDate;
  String? fileFormat;
  int? isDownload;
  int? isEmail;

  LoanStatementRequestEntity(
      {this.loanName,
        this.type,
        this.duration,
        this.fromDate,
        this.toDate,
        this.fileFormat,
        this.isDownload,
        this.isEmail});
}