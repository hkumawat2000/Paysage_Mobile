class LoanCloserRequestModel {
  String? loanNo;

  LoanCloserRequestModel({this.loanNo});

  LoanCloserRequestModel.fromJson(Map<String, dynamic> json) {
    loanNo = json['loan_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_no'] = this.loanNo;
    return data;
  }
}
