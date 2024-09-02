import 'package:lms/aa_getx/modules/payment/domain/entities/request/payment_request_entity.dart';

class PaymentRequestModel {
  double? amount;
  String? currency;
  Notes? notes;


  PaymentRequestModel({this.amount, this.currency, this.notes});

  PaymentRequestModel.fromJson(Map<String, dynamic> json) {
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

  factory PaymentRequestModel.fromEntity(PaymentRequestEntity paymentRequestEntity) {
    return PaymentRequestModel(
      amount: paymentRequestEntity.amount != null ? paymentRequestEntity.amount as double : null,
      currency: paymentRequestEntity.currency != null ? paymentRequestEntity.currency as String : null,
      notes: paymentRequestEntity.notes != null ? Notes.fromEntity(paymentRequestEntity.notes as NotesEntity) : null,
    );
  }
}


class Notes {
  String? loanName;
  String? amount;
  String? isForInterest;
  String? loanMarginShortfallName;

  Notes({this.loanName, this.amount, this.isForInterest, this.loanMarginShortfallName});

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

  factory Notes.fromEntity(NotesEntity notes) {
    return Notes(
      loanName: notes.loanName != null ? notes.loanName as String : null,
      amount: notes.amount != null ? notes.amount as String : null,
      isForInterest: notes.isForInterest != null ? notes.isForInterest as String : null,
      loanMarginShortfallName: notes.loanMarginShortfallName != null ? notes.loanMarginShortfallName as String : null,
    );
  }
}
