
class RecentTransactionResponseEntity {
  String? message;
  LoanDataEntity? loanData;
  String? pdfFileUrl;
  String? excelFileUrl;

  RecentTransactionResponseEntity(
      {this.message, this.loanData, this.pdfFileUrl, this.excelFileUrl});
}

class LoanDataEntity {
  LoanEntity? loan;
  List<PledgedSecuritiesTransactionsEntity>? pledgedSecuritiesTransactions;

  LoanDataEntity({this.loan, this.pledgedSecuritiesTransactions});
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
        this.doctype});
}

class PledgedSecuritiesTransactionsEntity {
  String? creation;
  String? securityName;
  String? isin;
  double? quantity;
  String? requestType;
  String? folio;
  String? securityCategory;
  double? eligiblePercentage;

  PledgedSecuritiesTransactionsEntity(
      {this.creation,
        this.securityName,
        this.isin,
        this.quantity,
        this.requestType,
        this.folio,
        this.securityCategory,
        this.eligiblePercentage});
}