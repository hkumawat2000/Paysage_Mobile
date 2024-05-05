class ValidateBankRequestBean {
  String? ifsc;
  String? accountHolderName;
  String? accountNumber;
  String? bankAccountType;
  String? bank;
  String? branch;
  String? city;
  String? personalizedCheque;

  ValidateBankRequestBean(
      {this.ifsc,
        this.accountHolderName,
        this.accountNumber,
        this.bankAccountType,
        this.bank,
        this.branch,
        this.city,
        this.personalizedCheque});

  ValidateBankRequestBean.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
    accountHolderName = json['account_holder_name'];
    accountNumber = json['account_number'];
    bankAccountType = json['bank_account_type'];
    bank = json['bank'];
    branch = json['branch'];
    city = json['city'];
    personalizedCheque = json['personalized_cheque'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifsc'] = this.ifsc;
    data['account_holder_name'] = this.accountHolderName;
    data['account_number'] = this.accountNumber;
    data['bank_account_type'] = this.bankAccountType;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['city'] = this.city;
    data['personalized_cheque'] = this.personalizedCheque;
    return data;
  }
}
