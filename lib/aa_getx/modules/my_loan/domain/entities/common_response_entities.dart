class CommonResponseEntity {
  String? message;
  CommonDataEntity? commonData;

  CommonResponseEntity({this.message, this.commonData});
}

class CommonDataEntity {
  String? loanTransactionName;

  CommonDataEntity({this.loanTransactionName});
}
