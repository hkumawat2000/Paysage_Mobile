

class LoanStatementResponseEntity{
  String? message;
  LoanDataEntity? loanData;

  LoanStatementResponseEntity({this.message, this.loanData});
}

class LoanDataEntity {
  LoanEntity? loan;
  List<LoanTransactionListEntity>? loanTransactionList;
  String? pdfFileUrl;
  String? excelFileUrl;

  LoanDataEntity({this.loan, this.loanTransactionList, this.pdfFileUrl, this.excelFileUrl});
}

class LoanEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  double? sanctionedLimit;
  String? sanctionedLimitStr;
  double? balance;
  String? balanceStr;
  String? customer;
  String? customerName;
  double? allowableLtv;
  String? expiryDate;
  String? loanAgreement;
  int? isEligibleForInterest;
  int? isIrregular;
  int? isPenalize;
  String? doctype;
  List<ItemsEntity>? items;

  LoanEntity(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.totalCollateralValue,
        this.totalCollateralValueStr,
        this.drawingPower,
        this.drawingPowerStr,
        this.lender,
        this.sanctionedLimit,
        this.sanctionedLimitStr,
        this.balance,
        this.balanceStr,
        this.customer,
        this.customerName,
        this.allowableLtv,
        this.expiryDate,
        this.loanAgreement,
        this.isEligibleForInterest,
        this.isIrregular,
        this.isPenalize,
        this.doctype,
        this.items});
}

class ItemsEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  int? docstatus;
  String? isin;
  String? securityName;
  String? securityCategory;
  double? pledgedQuantity;
  double? price;
  double? amount;
  String? psn;
  String? errorCode;
  String? doctype;

  ItemsEntity(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.idx,
        this.docstatus,
        this.isin,
        this.securityName,
        this.securityCategory,
        this.pledgedQuantity,
        this.price,
        this.amount,
        this.psn,
        this.errorCode,
        this.doctype});
}

class LoanTransactionListEntity {
  String? name;
  String? transactionType;
  String? recordType;
  String? amount;
  String? time;
  String? status;

  LoanTransactionListEntity(
      {this.name, this.transactionType, this.recordType, this.amount, this.time, this.status});
}