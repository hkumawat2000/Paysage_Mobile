
class GetLoanDetailsRequestEntity{
  String? loanName;
  int? transactionsPerPage;
  int? transactionsStart;

  GetLoanDetailsRequestEntity({required this.loanName,required this.transactionsPerPage,required this.transactionsStart});
}