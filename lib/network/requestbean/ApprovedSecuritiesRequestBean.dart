class ApprovedSecuritiesRequestBean {
  String? lender;
  int? start;
  int? perPage;
  String? search;
  String? category;
  int? isDownload;
  String? loanType;

  ApprovedSecuritiesRequestBean(
      {this.lender,  this.start,  this.perPage,  this.search,  this.category, this.isDownload, this.loanType});

  ApprovedSecuritiesRequestBean.fromJson(Map<String, dynamic> json) {
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
}
