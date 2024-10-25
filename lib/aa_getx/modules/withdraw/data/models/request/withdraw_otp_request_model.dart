import 'dart:convert';

import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_otp_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WithdrawOtpRequestModel {
  String loanName;
  double amount;
  String bankAccountName;
  String otp;
  WithdrawOtpRequestModel({
    required this.loanName,
    required this.amount,
    required this.bankAccountName,
    required this.otp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loan_name': loanName,
      'amount': amount,
      'bank_account_name': bankAccountName,
      'otp': otp,
    };
  }

  factory WithdrawOtpRequestModel.fromMap(Map<String, dynamic> map) {
    return WithdrawOtpRequestModel(
      loanName: map['loan_name'] as String,
      amount: map['amount'] as double,
      bankAccountName: map['bank_account_name'] as String,
      otp: map['otp'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WithdrawOtpRequestModel.fromJson(String source) => WithdrawOtpRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory WithdrawOtpRequestModel.fromEntity(WithdrawOtpRequestEntity withdrawOtpRequestEntity) {
    return WithdrawOtpRequestModel(
      loanName: withdrawOtpRequestEntity.loanName,
      amount: double.parse(withdrawOtpRequestEntity.amount.toString()),
      bankAccountName: withdrawOtpRequestEntity.bankAccountName,
      otp: withdrawOtpRequestEntity.otp,
    );
  }
}
