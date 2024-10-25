// ignore_for_file: public_member_api_docs, sort_constructors_first
class WithdrawOtpRequestEntity {
  String loanName;
  double amount;
  String bankAccountName;
  String otp;

  WithdrawOtpRequestEntity({
    required this.loanName,
    required this.amount,
    required this.bankAccountName,
    required this.otp,
  });
}
