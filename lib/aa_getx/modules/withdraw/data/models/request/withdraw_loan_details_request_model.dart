import 'dart:convert';

import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_loan_details_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WithdrawLoanDetailsRequestModel {
  String loanName;
  
  WithdrawLoanDetailsRequestModel({
    required this.loanName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loan_name': loanName,
    };
  }

  factory WithdrawLoanDetailsRequestModel.fromMap(Map<String, dynamic> map) {
    return WithdrawLoanDetailsRequestModel(
      loanName: map['loan_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawLoanDetailsRequestModel.fromJson(String source) => WithdrawLoanDetailsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory WithdrawLoanDetailsRequestModel.fromEntity(WithdrawLoanDetailsRequestEntity withdrawLoanDetailsRequestEntity) {
    return WithdrawLoanDetailsRequestModel(
      loanName: withdrawLoanDetailsRequestEntity.loanName,
    );
  }
}
