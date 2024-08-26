import 'package:lms/aa_getx/modules/payment/domain/entities/request/razor_pay_request_entity.dart';

class RazorPayRequestModel {
  String? loanName;
  double? amount;
  String? orderId;
  String? loanMarginShortfallName;
  int? isForInterest;
  String? loanTransactionName;
  IsFailed? isFailed;

  RazorPayRequestModel(
      {this.loanName,
      this.amount,
      this.orderId,
      this.loanMarginShortfallName,
      this.isForInterest,
      this.loanTransactionName,
      this.isFailed});

  RazorPayRequestModel.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    amount = json['amount'];
    orderId = json['order_id'];
    loanMarginShortfallName = json['loan_margin_shortfall_name'];
    isForInterest = json['is_for_interest'];
    loanTransactionName = json['loan_transaction_name'];
    isFailed = json['is_failed'] != null
        ? new IsFailed.fromJson(json['is_failed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['amount'] = this.amount;
    data['order_id'] = this.orderId;
    data['loan_margin_shortfall_name'] = this.loanMarginShortfallName;
    data['is_for_interest'] = this.isForInterest;
    data['loan_transaction_name'] = this.loanTransactionName;
    if (this.isFailed != null) {
      data['is_failed'] = this.isFailed!.toJson();
    }
    return data;
  }

  factory RazorPayRequestModel.fromEntity(RazorPayRequestEntity razorPayRequestEntity) {
    return RazorPayRequestModel(
      loanName:razorPayRequestEntity.loanName != null ? razorPayRequestEntity.loanName as String : null,
      amount:razorPayRequestEntity.amount != null ? razorPayRequestEntity.amount as double : null,
      orderId:razorPayRequestEntity.orderId != null ? razorPayRequestEntity.orderId as String : null,
      loanMarginShortfallName:razorPayRequestEntity.loanMarginShortfallName != null ? razorPayRequestEntity.loanMarginShortfallName as String : null,
      isForInterest:razorPayRequestEntity.isForInterest != null ? razorPayRequestEntity.isForInterest as int : null,
      loanTransactionName:razorPayRequestEntity.loanTransactionName != null ? razorPayRequestEntity.loanTransactionName as String : null,
      isFailed:razorPayRequestEntity.isFailed != null ? IsFailed.fromEntity(razorPayRequestEntity.isFailed as IsFailedEntity) : null,
    );
  }
}

class IsFailed {
  String? code;
  String? description;
  String? source;
  String? step;
  String? reason;

  IsFailed({this.code, this.description, this.source, this.step, this.reason});

  IsFailed.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    source = json['source'];
    step = json['step'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    data['source'] = this.source;
    data['step'] = this.step;
    data['reason'] = this.reason;
    return data;
  }

  factory IsFailed.fromEntity(IsFailedEntity isFailed) {
    return IsFailed(
      code: isFailed.code != null ? isFailed.code as String : null,
      description: isFailed.description != null ? isFailed.description as String : null,
      source: isFailed.source != null ? isFailed.source as String : null,
      step: isFailed.step != null ? isFailed.step as String : null,
      reason: isFailed.reason != null ? isFailed.reason as String : null,
    );
  }
}
