
class RazorPayRequestEntity {
  String? loanName;
  double? amount;
  String? orderId;
  String? loanMarginShortfallName;
  int? isForInterest;
  String? loanTransactionName;
  IsFailedEntity? isFailed;

  RazorPayRequestEntity(
      {this.loanName,
        this.amount,
        this.orderId,
        this.loanMarginShortfallName,
        this.isForInterest,
        this.loanTransactionName,
        this.isFailed});
}

class IsFailedEntity {
  String? code;
  String? description;
  String? source;
  String? step;
  String? reason;

  IsFailedEntity({this.code, this.description, this.source, this.step, this.reason});
}
