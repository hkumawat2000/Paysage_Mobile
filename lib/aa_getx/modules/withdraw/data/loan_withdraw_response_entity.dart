class LoanWithdrawResponseEntity {
  String? message;
  DataEntity? data;

  LoanWithdrawResponseEntity({this.message, this.data});
}

class DataEntity {
  LoanEntity? loan;
  List<BanksEntity>? banks;

  DataEntity({this.loan, this.banks});
}

class LoanEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  int? totalCollateralValue;
  String? totalCollateralValueStr;
  int? drawingPower;
  String? drawingPowerStr;
  String? lender;
  int? sanctionedLimit;
  String? sanctionedLimitStr;
  double? balance;
  String? balanceStr;
  int? isClosed;
  String? customer;
  String? customerName;
  int? availableTopupAmt;
  int? actualDrawingPower;
  String? expiryDate;
  String? loanAgreement;
  String? slCialEntries;
  int? marginShortfallAmount;
  String? instrumentType;
  String? schemeType;
  int? isEligibleForInterest;
  int? isIrregular;
  int? isPenalize;
  double? baseInterest;
  double? baseInterestConfig;
  double? baseInterestAmount;
  int? interestDue;
  double? penalInterestCharges;
  double? totalInterestInclPenalDue;
  double? rebateInterest;
  double? rebateInterestConfig;
  double? rebateInterestAmount;
  double? interestOverdue;
  int? dayPastDue;
  double? customBaseInterest;
  double? oldInterest;
  String? wefDate;
  int? isDefault;
  double? customRebateInterest;
  double? oldRebateInterest;
  String? oldWefDate;
  String? doctype;
  List<ItemsEntity>? items;
  double? amountAvailableForWithdrawal;

  LoanEntity(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.totalCollateralValue,
      this.totalCollateralValueStr,
      this.drawingPower,
      this.drawingPowerStr,
      this.lender,
      this.sanctionedLimit,
      this.sanctionedLimitStr,
      this.balance,
      this.balanceStr,
      this.isClosed,
      this.customer,
      this.customerName,
      this.availableTopupAmt,
      this.actualDrawingPower,
      this.expiryDate,
      this.loanAgreement,
      this.slCialEntries,
      this.marginShortfallAmount,
      this.instrumentType,
      this.schemeType,
      this.isEligibleForInterest,
      this.isIrregular,
      this.isPenalize,
      this.baseInterest,
      this.baseInterestConfig,
      this.baseInterestAmount,
      this.interestDue,
      this.penalInterestCharges,
      this.totalInterestInclPenalDue,
      this.rebateInterest,
      this.rebateInterestConfig,
      this.rebateInterestAmount,
      this.interestOverdue,
      this.dayPastDue,
      this.customBaseInterest,
      this.oldInterest,
      this.wefDate,
      this.isDefault,
      this.customRebateInterest,
      this.oldRebateInterest,
      this.oldWefDate,
      this.doctype,
      this.items,
      this.amountAvailableForWithdrawal});
}

class ItemsEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? isin;
  String? securityName;
  String? securityCategory;
  int? pledgedQuantity;
  int? eligiblePercentage;
  int? eligibleAmount;
  int? price;
  int? amount;
  String? type;
  Null? folio;
  Null? amcCode;
  Null? amcImage;
  String? psn;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  ItemsEntity(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.docstatus,
      this.idx,
      this.isin,
      this.securityName,
      this.securityCategory,
      this.pledgedQuantity,
      this.eligiblePercentage,
      this.eligibleAmount,
      this.price,
      this.amount,
      this.type,
      this.folio,
      this.amcCode,
      this.amcImage,
      this.psn,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.doctype});
}

class BanksEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? bankStatus;
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  Null? bankCode;
  String? city;
  Null? state;
  int? isDefault;
  Null? isSparkDefault;
  String? pennyRequestId;
  String? bankTransactionStatus;
  String? accountHolderName;
  String? personalizedCheque;
  Null? bankAddress;
  Null? contact;
  String? accountType;
  Null? micr;
  Null? bankMode;
  Null? bankZipCode;
  Null? district;
  int? notificationSent;
  int? isRepeated;
  int? isMismatched;
  String? parent;
  String? parentfield;
  String? parenttype;

  BanksEntity(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.owner,
      this.docstatus,
      this.idx,
      this.bankStatus,
      this.bank,
      this.branch,
      this.accountNumber,
      this.ifsc,
      this.bankCode,
      this.city,
      this.state,
      this.isDefault,
      this.isSparkDefault,
      this.pennyRequestId,
      this.bankTransactionStatus,
      this.accountHolderName,
      this.personalizedCheque,
      this.bankAddress,
      this.contact,
      this.accountType,
      this.micr,
      this.bankMode,
      this.bankZipCode,
      this.district,
      this.notificationSent,
      this.isRepeated,
      this.isMismatched,
      this.parent,
      this.parentfield,
      this.parenttype});
}

