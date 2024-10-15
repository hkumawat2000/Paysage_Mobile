// ignore_for_file: public_member_api_docs, sort_constructors_first

class ApprovedSecuritiesRequestEntity {
  String? lender;
  int? start;
  int? perPage;
  String? search;
  String? category;
  int? isDownload;
  String? loanType;
  
  ApprovedSecuritiesRequestEntity({
    this.lender,
    this.start,
    this.perPage,
    this.search,
    this.category,
    this.isDownload,
    this.loanType,
  });
}
