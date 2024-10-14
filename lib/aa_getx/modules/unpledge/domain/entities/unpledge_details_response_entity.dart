class UnpledgeDetailsResponseEntity {
  String? message;
  UnpledgeDataEntity? unpledgeData;

  UnpledgeDetailsResponseEntity({this.message, this.unpledgeData});
}

class UnpledgeDataEntity {
  LoanEntity? loan;
  UnpledgeEntity? unpledge;
  List<CollateralLedgerEntity>? collateralLedger;
  RevokeChargeDetailsEntity? revokeChargeDetails;

  UnpledgeDataEntity(
      {this.loan,
      this.unpledge,
      this.collateralLedger,
      this.revokeChargeDetails});
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
  double? existingtotalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  double? existingdrawingPower;
  double? actualDrawingPower;
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
  int? isEligibleForInterest;
  int? isIrregular;
  int? isPenalize;
  String? doctype;
  List<UnpledgeItemsEntity>? items;

  LoanEntity(
      {this.name,
      this.owner,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.idx,
      this.docstatus,
      this.totalCollateralValue,
      this.existingtotalCollateralValue,
      this.totalCollateralValueStr,
      this.drawingPower,
      this.existingdrawingPower,
      this.actualDrawingPower,
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
      this.isEligibleForInterest,
      this.isIrregular,
      this.isPenalize,
      this.doctype,
      this.items});
}

class UnpledgeItemsEntity {
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
  double? eligiblePercentage;
  double? price;
  double? amount;
  String? doctype;
  String? folio;
  String? psn;
  int? remainingQty;
  int? qty;
  bool? check;

  UnpledgeItemsEntity(
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
      this.eligiblePercentage,
      this.price,
      this.amount,
      this.doctype,
      this.folio,
      this.psn,
      this.remainingQty,
      this.qty,
      this.check});
}

class CollateralLedgerEntity {
  String? isin;
  String? psn;
  String? folio;
  double? requestedQuantity;

  CollateralLedgerEntity(
      {this.isin, this.psn, this.folio, this.requestedQuantity});
}

class RevokeChargeDetailsEntity {
  String? revokeInitiateChargeType;
  double? revokeInitiateCharges;
  double? revokeInitiateChargesMinimumAmount;
  double? revokeInitiateChargesMaximumAmount;

  RevokeChargeDetailsEntity(
      {this.revokeInitiateChargeType,
      this.revokeInitiateCharges,
      this.revokeInitiateChargesMinimumAmount,
      this.revokeInitiateChargesMaximumAmount});
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
