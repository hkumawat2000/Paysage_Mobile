class PaymentResponseEntity {
  String? id;
  String? entity;
  int? amount;
  int? amountPaid;
  int? amountDue;
  String? currency;
  String? receipt;
  String? status;
  int? attempts;
  int? createdAt;

  PaymentResponseEntity(
      {this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.status,
      this.attempts,
      this.createdAt});
}
