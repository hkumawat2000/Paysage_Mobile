class LoanDetailsResponseEntity {
  String? message;
  LoanDetailDataEntity? data;

  LoanDetailsResponseEntity({this.message, this.data});
}

class LoanDetailDataEntity {
  LoanEntity? loan;
  List<TransactionsEntity>? transactions;
  MarginShortfallEntity? marginShortfall;
  InterestEntity? interest;
  // TopUp topUp;
  double? topUp;
  int? increaseLoan;
  String? increaseLoanName;
  int? topUpApplication;
  String? topUpApplicationName;
  InvokeChargeDetailsEntity? invokeChargeDetails;
  List<CollateralLedgerEntity>? collateralLedger;
  int? sellCollateral;
  int? isSellTriggered;
  int? paymentAlreadyInProcess;
  UnpledgeEntity? unpledge;
  String? pledgorBoid;
  int? loanRenewalIsExpired;

  LoanDetailDataEntity({
    this.loan,
    this.transactions,
    this.marginShortfall,
    this.interest,
    this.topUp,
    this.increaseLoan,
    this.increaseLoanName,
    this.collateralLedger,
    this.topUpApplication,
    this.topUpApplicationName,
    this.invokeChargeDetails,
    this.sellCollateral,
    this.isSellTriggered,
    this.unpledge,
    this.paymentAlreadyInProcess,
    this.pledgorBoid,
    this.loanRenewalIsExpired,
  });
}

class InvokeChargeDetailsEntity {
  String? invokeInitiateChargeType;
  double? invokeInitiateCharges;
  double? invokeInitiateChargesMinimumAmount;
  double? invokeInitiateChargesMaximumAmount;

  InvokeChargeDetailsEntity(
      {this.invokeInitiateChargeType,
      this.invokeInitiateCharges,
      this.invokeInitiateChargesMinimumAmount,
      this.invokeInitiateChargesMaximumAmount});
}

class CollateralLedgerEntity {
  String? isin;
  String? psn;
  String? folio;
  double? requestedQuantity;

  CollateralLedgerEntity(
      {this.isin, this.psn, this.folio, this.requestedQuantity});
}

class LoanEntity {
  double? allowableLtv;
  double? balance;
  String? creation;
  String? customer;
  int? docstatus;
  String? doctype;
  double? drawingPower;
  double? actualDrawingPower;
  String? expiryDate;
  int? idx;
  List<ItemsEntity>? items;
  String? lender;
  String? loanAgreement;
  String? modified;
  String? modifiedBy;
  String? name;
  String? instrumentType;
  String? schemeType;
  String? owner;
  String? parent;
  String? parentfield;
  String? parenttype;
  double? sanctionedLimit;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  String? drawingPowerStr;
  String? sanctionedLimitStr;
  String? balanceStr;

  LoanEntity(
      {this.allowableLtv,
      this.balance,
      this.creation,
      this.customer,
      this.docstatus,
      this.doctype,
      this.drawingPower,
      this.actualDrawingPower,
      this.expiryDate,
      this.idx,
      this.items,
      this.lender,
      this.loanAgreement,
      this.modified,
      this.modifiedBy,
      this.name,
      this.instrumentType,
      this.schemeType,
      this.owner,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.sanctionedLimit,
      this.totalCollateralValue,
      this.balanceStr,
      this.drawingPowerStr,
      this.sanctionedLimitStr,
      this.totalCollateralValueStr});
}

class ItemsEntity {
  double? amount;
  String? creation;
  int? docstatus;
  String? doctype;
  String? errorCode;
  int? idx;
  String? isin;
  String? modified;
  String? modifiedBy;
  String? name;
  String? owner;
  String? parent;
  String? parentfield;
  String? parenttype;
  double? pledgedQuantity;
  double? eligiblePercentage;
  double? price;
  String? psn;
  String? securityCategory;
  String? securityName;
  String? folio;
  bool? check;
  int? remaningQty;

  ItemsEntity(
      {this.amount,
      this.creation,
      this.docstatus,
      this.doctype,
      this.errorCode,
      this.idx,
      this.isin,
      this.modified,
      this.modifiedBy,
      this.name,
      this.owner,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.pledgedQuantity,
      this.eligiblePercentage,
      this.price,
      this.psn,
      this.securityCategory,
      this.securityName,
      this.folio,
      this.check,
      this.remaningQty});
}

class TransactionsEntity {
  String? transactionType;
  String? recordType;
  String? time;
  String? amount;

  TransactionsEntity(
      {this.transactionType, this.recordType, this.time, this.amount});
}

class MarginShortfallEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? loan;
  double? totalCollateralValue;
  double? allowableLtv;
  double? drawingPower;
  double? loanBalance;
  double? minimumCollateralValue;
  double? ltv;
  double? surplusMargin;
  double? shortfall;
  double? shortfallC;
  double? minimumPledgeAmount;
  double? minimumCashAmount;
  double? shortfallPercentage;
  String? marginShortfallAction;
  double? advisablePledgeAmount;
  double? advisableCashAmount;
  String? status;
  int? isBankHoliday;
  String? deadline;
  String? actionTakenMsg;
  LinkedApplicationEntity? linkedApplication;
  String? deadlineInHrs;
  String? shortfallCStr;
  int? isTodayHoliday;

  MarginShortfallEntity(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.owner,
      this.docstatus,
      this.idx,
      this.loan,
      this.totalCollateralValue,
      this.allowableLtv,
      this.drawingPower,
      this.loanBalance,
      this.minimumCollateralValue,
      this.ltv,
      this.surplusMargin,
      this.shortfall,
      this.shortfallC,
      this.minimumPledgeAmount,
      this.minimumCashAmount,
      this.shortfallPercentage,
      this.marginShortfallAction,
      this.advisablePledgeAmount,
      this.advisableCashAmount,
      this.status,
      this.isBankHoliday,
      this.deadline,
      this.actionTakenMsg,
      this.linkedApplication,
      this.deadlineInHrs,
      this.shortfallCStr,
      this.isTodayHoliday});
}

class LinkedApplicationEntity {
  LoanApplicationEntity? loanApplication;
  SellCollateralApplicationEntity? sellCollateralApplication;

  LinkedApplicationEntity(
      {this.loanApplication, this.sellCollateralApplication});
}

class LoanApplicationEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  String? status;
  double? pledgedTotalCollateralValue;
  String? pledgedTotalCollateralValueStr;
  String? loanMarginShortfall;
  String? customer;
  String? customerName;
  double? allowableLtv;
  String? expiryDate;
  String? loan;
  String? pledgeStatus;
  String? workflowState;
  String? pledgorBoid;
  String? pledgeeBoid;

  LoanApplicationEntity(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.owner,
      this.docstatus,
      this.idx,
      this.totalCollateralValue,
      this.totalCollateralValueStr,
      this.drawingPower,
      this.drawingPowerStr,
      this.lender,
      this.status,
      this.pledgedTotalCollateralValue,
      this.pledgedTotalCollateralValueStr,
      this.loanMarginShortfall,
      this.customer,
      this.customerName,
      this.allowableLtv,
      this.expiryDate,
      this.loan,
      this.pledgeStatus,
      this.workflowState,
      this.pledgorBoid,
      this.pledgeeBoid});
}

class SellCollateralApplicationEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? loan;
  double? totalCollateralValue;
  String? lender;
  String? customer;
  double? sellingCollateralValue;
  String? status;
  String? workflowState;
  String? loanMarginShortfall;

  SellCollateralApplicationEntity(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.owner,
      this.docstatus,
      this.idx,
      this.loan,
      this.totalCollateralValue,
      this.lender,
      this.customer,
      this.sellingCollateralValue,
      this.status,
      this.workflowState,
      this.loanMarginShortfall});
}

class InterestEntity {
  double? totalInterestAmt;
  String? dueDate;
  String? dueBtnTxt;
  String? infoMsg;
  int? dpdText;

  InterestEntity(
      {this.totalInterestAmt,
      this.dueDate,
      this.dueBtnTxt,
      this.infoMsg,
      this.dpdText});
}

class TopUpEntity {
  double? topUpAmount;
  double? minimumTopUpAmount;

  TopUpEntity({this.topUpAmount, this.minimumTopUpAmount});
}

class UnpledgeEntity {
  String? unpledgeMsgWhileMarginShortfall;
  UnpledgeValueEntity? unpledgeValue;

  UnpledgeEntity({this.unpledgeMsgWhileMarginShortfall, this.unpledgeValue});
}

class UnpledgeValueEntity {
  double? minimumCollateralValue;
  double? maximumUnpledgeAmount;

  UnpledgeValueEntity(
      {this.minimumCollateralValue, this.maximumUnpledgeAmount});
}
