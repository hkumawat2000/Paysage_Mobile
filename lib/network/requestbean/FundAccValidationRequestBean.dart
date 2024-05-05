// class FundAccValidationRequestBean {
//   String? faId;
//   String? bankAccountType;
//   String? branch;
//   String? city;
//   String? personalizedCheque;
//
//   FundAccValidationRequestBean(
//       {this.faId, this.bankAccountType, this.branch, this.city, this.personalizedCheque});
//
//   FundAccValidationRequestBean.fromJson(Map<String, dynamic> json) {
//     faId = json['fa_id'];
//     bankAccountType = json['bank_account_type'];
//     branch = json['branch'];
//     city = json['city'];
//     personalizedCheque = json['personalized_cheque'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['fa_id'] = this.faId;
//     data['bank_account_type'] = this.bankAccountType;
//     data['branch'] = this.branch;
//     data['city'] = this.city;
//     data['personalized_cheque'] = this.personalizedCheque;
//     return data;
//   }
// }
