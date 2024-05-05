class TermsConditionRequestBean {
  String? cartName;
  String? loanName;
  String? loanRenewalName;
  double? topupAmount;

  TermsConditionRequestBean(
      {this.cartName, this.loanName, this.loanRenewalName, this.topupAmount});

  TermsConditionRequestBean.fromJson(Map<String, dynamic> json) {
    cartName = json['cart_name'];
    loanName = json['loan_name'];
    loanRenewalName = json['loan_renewal_name'];
    topupAmount = json['topup_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_name'] = this.cartName;
    data['loan_name'] = this.loanName;
    data['loan_renewal_name'] = this.loanRenewalName;
    data['topup_amount'] = this.topupAmount;
    return data;
  }
}
