class LoanStatementArguments {
  String? loanName, loanType;
  double? loanBalance, drawingPower;

  LoanStatementArguments(
      {required this.loanName,
      required this.loanBalance,
      required this.drawingPower,
      required this.loanType});
}
