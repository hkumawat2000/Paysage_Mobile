
class PaymentArguments{
  var loanName, marginShortfallAmount, minimumCollateralValue, totalCollateralValue, marginShortfallLoanName;
  double? minimumCashAmount;
  bool? isMarginShortfall;
  int? isForInterest;

  PaymentArguments({
      required this.loanName,
      required this.isMarginShortfall,
      required this.marginShortfallAmount,
      required this.minimumCollateralValue,
      required this.totalCollateralValue,
      required this.marginShortfallLoanName,
      required this.minimumCashAmount,
      required this.isForInterest});
}