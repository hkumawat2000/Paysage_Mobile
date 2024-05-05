import 'package:choice/network/ModelWrapper.dart';

class PaymentRequest{
  double? amount;
  String? currency;
  Notes? notes;


  PaymentRequest(this.amount, this.currency, this.notes);

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
    notes = json['notes'] != null
        ? new Notes.fromJson(json['notes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    if (this.notes != null) {
      data['notes'] = this.notes!.toJson();
    }
    return data;
  }
}

class Notes{
  String? loanName;
  String? amount;
  String? isForInterest;
  String? loanMarginShortfallName;

  Notes(this.loanName, this.amount, this.isForInterest, this.loanMarginShortfallName);

  Notes.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    amount = json['amount'];
    isForInterest = json['is_for_interest'];
    loanMarginShortfallName = json['loan_margin_shortfall_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['amount'] = this.amount;
    data['is_for_interest'] = this.isForInterest;
    data['loan_margin_shortfall_name'] = this.loanMarginShortfallName;
    return data;
  }
}
