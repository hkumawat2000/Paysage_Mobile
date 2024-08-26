class PaymentRequestEntity {
  double? amount;
  String? currency;
  NotesEntity? notes;

  PaymentRequestEntity({this.amount, this.currency, this.notes});
}

class NotesEntity {
  String? loanName;
  String? amount;
  String? isForInterest;
  String? loanMarginShortfallName;

  NotesEntity(
      {this.loanName,
      this.amount,
      this.isForInterest,
      this.loanMarginShortfallName});
}
