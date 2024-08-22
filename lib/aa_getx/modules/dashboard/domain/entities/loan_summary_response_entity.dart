
class LoanSummaryResponseEntity {
  String? message;
  LoanSummaryDataEntity? loanSummaryData;

  LoanSummaryResponseEntity({this.message, this.loanSummaryData});
}

class LoanSummaryDataEntity {
  List<SellCollateralTopupAndUnpledgeListEntity>?
  sellCollateralTopupAndUnpledgeList;
  List<ActionableLoanEntity>? actionableLoan;
  List<UnderProcessLaEntity>? underProcessLa;
  List<UnderProcessLoanRenewalAppEntity>? underProcessLoanRenewalApp;
  List<ActiveLoansEntity>? activeLoans;
  List<SellCollateralListEntity>? sellCollateralList;
  List<UnpledgeListEntity>? unpledgeList;
  List<TopupListEntity>? topupList;
  List<IncreaseLoanListEntity>? increaseLoanList;
  String? instrumentType;
  String? schemeType;
  VersionDetailsEntity? versionDetails;
  List<LoanRenewalApplicationEntity>? loanRenewalApplication;

  LoanSummaryDataEntity(
      {this.sellCollateralTopupAndUnpledgeList,
        this.actionableLoan,
        this.underProcessLa,
        this.underProcessLoanRenewalApp,
        this.activeLoans,
        this.sellCollateralList,
        this.unpledgeList,
        this.topupList,
        this.increaseLoanList,
        this.instrumentType,
        this.schemeType,
        this.versionDetails,
        this.loanRenewalApplication});
}

class SellCollateralTopupAndUnpledgeListEntity {
  String? loanName;
  String? creation;
  UnpledgeApplicationAvailableEntity? unpledgeApplicationAvailable;
  SellCollateralAvailableEntity? sellCollateralAvailable;
  ExistingTopupApplicationEntity? existingTopupApplication;

  SellCollateralTopupAndUnpledgeListEntity(
      {this.loanName,
        this.creation,
        this.unpledgeApplicationAvailable,
        this.sellCollateralAvailable,
        this.existingTopupApplication});
}

class UnpledgeApplicationAvailableEntity {
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
  double? unpledgeCollateralValue;
  String? status;
  String? workflowState;
  List<UnpledgeItemsEntity>? unpledgeItems;

  UnpledgeApplicationAvailableEntity(
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
        this.unpledgeCollateralValue,
        this.status,
        this.workflowState,
        this.unpledgeItems});
}

class UnpledgeItemsEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  String? isin;
  int? unpledgedQuantity;
  String? securityName;
  String? folio;
  double? quantity;
  double? price;
  double? amount;
  double? eligiblePercentage;
  String? securityCategory;

  UnpledgeItemsEntity(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.idx,
        this.isin,
        this.unpledgedQuantity,
        this.securityName,
        this.folio,
        this.quantity,
        this.price,
        this.amount,
        this.eligiblePercentage,
        this.securityCategory});
}

class SellCollateralAvailableEntity {
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
  List<SellItemsEntity>? sellItems;

  SellCollateralAvailableEntity(
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
        this.loanMarginShortfall,
        this.sellItems});
}

class SellItemsEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  String? isin;
  String? securityName;
  String? folio;
  double? quantity;
  double? price;
  double? amount;
  double? eligiblePercentage;
  String? securityCategory;

  SellItemsEntity(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.idx,
        this.isin,
        this.securityName,
        this.folio,
        this.quantity,
        this.price,
        this.amount,
        this.eligiblePercentage,
        this.securityCategory});
}

class ExistingTopupApplicationEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? loan;
  double? topUpAmount;
  String? time;
  String? status;
  String? customer;
  String? customerName;
  String? customerEsignedDocument;
  String? lenderEsignedDocument;
  String? workflowState;
  double? sanctionedLimit;

  ExistingTopupApplicationEntity({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    this.idx,
    this.loan,
    this.topUpAmount,
    this.time,
    this.status,
    this.customer,
    this.customerName,
    this.customerEsignedDocument,
    this.lenderEsignedDocument,
    this.workflowState,
    this.sanctionedLimit,
  });
}

class ActionableLoanEntity {
  String? name;
  double? drawingPower;
  String? drawingPowerStr;
  double? balance;
  String? balanceStr;
  String? creation;

  ActionableLoanEntity(
      {this.name,
        this.drawingPower,
        this.drawingPowerStr,
        this.balance,
        this.balanceStr,
        this.creation});
}

class UnderProcessLaEntity {
  String? name;
  String? status;

  UnderProcessLaEntity({this.name, this.status});
}

class UnderProcessLoanRenewalAppEntity {
  String? name;
  String? status;
  String? creation;

  UnderProcessLoanRenewalAppEntity({this.name, this.status, this.creation});
}

class ActiveLoansEntity {
  String? name;
  double? drawingPower;
  String? drawingPowerStr;
  double? balance;
  String? balanceStr;
  String? creation;

  ActiveLoansEntity(
      {this.name,
        this.drawingPower,
        this.drawingPowerStr,
        this.balance,
        this.balanceStr,
        this.creation});
}

class SellCollateralListEntity {
  String? loanName;
  SellCollateralAvailableEntity? sellCollateralAvailable;
  int? isSellTriggered;

  SellCollateralListEntity(
      {this.loanName, this.sellCollateralAvailable, this.isSellTriggered});
}

class UnpledgeListEntity {
  String? loanName;
  UnpledgeApplicationAvailableEntity? unpledgeApplicationAvailable;
  String? unpledgeMsgWhileMarginShortfall;
  UnpledgeEntity? unpledge;

  UnpledgeListEntity(
      {this.loanName,
        this.unpledgeApplicationAvailable,
        this.unpledgeMsgWhileMarginShortfall,
        this.unpledge});
}

class UnpledgeEntity {
  double? minimumCollateralValue;
  double? maximumUnpledgeAmount;

  UnpledgeEntity({this.minimumCollateralValue, this.maximumUnpledgeAmount});
}

class TopupListEntity {
  String? loanName;
  double? topUpAmount;

  TopupListEntity({this.loanName, this.topUpAmount});
}


class IncreaseLoanListEntity {
  String? loanName;
  int? increaseLoanAvailable;

  IncreaseLoanListEntity({this.loanName, this.increaseLoanAvailable});
}


class LoanRenewalApplicationEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? workflowState;
  String? loan;
  String? lender;
  String? oldKycName;
  String? updatedKycStatus;
  double? totalCollateralValue;
  double? sanctionedLimit;
  double? loanBalance;
  int? tncComplete;
  int? reminders;
  String? status;
  String? customer;
  String? customerName;
  double? drawingPower;
  int? isExpired;
  String? timeRemaining;
  String? actionStatus;
  String? doctype;
  int? tncShow;
  String? expiryDate;

  LoanRenewalApplicationEntity(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.workflowState,
        this.loan,
        this.lender,
        this.oldKycName,
        this.updatedKycStatus,
        this.totalCollateralValue,
        this.sanctionedLimit,
        this.loanBalance,
        this.tncComplete,
        this.reminders,
        this.status,
        this.customer,
        this.customerName,
        this.drawingPower,
        this.isExpired,
        this.timeRemaining,
        this.actionStatus,
        this.doctype,
        this.tncShow,
        this.expiryDate});
}


class VersionDetailsEntity {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? androidVersion;
  String? playStoreLink;
  String? whatsNew;
  String? iosVersion;
  String? appStoreLink;
  String? releaseDate;
  int? forceUpdate;

  VersionDetailsEntity(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.forceUpdate,
        this.idx,
        this.androidVersion,
        this.playStoreLink,
        this.whatsNew,
        this.iosVersion,
        this.appStoreLink,
        this.releaseDate});
}
