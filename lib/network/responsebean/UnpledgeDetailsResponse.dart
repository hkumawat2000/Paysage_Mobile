import 'package:lms/network/ModelWrapper.dart';

class UnpledgeDetailsResponse extends ModelWrapper<UnpledgeData> {
  String? message;
  UnpledgeData? unpledgeData;

  UnpledgeDetailsResponse({this.message, this.unpledgeData});

  UnpledgeDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    unpledgeData = json['data'] != null ? new UnpledgeData.fromJson(json['data']) : null;
    data = unpledgeData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.unpledgeData != null) {
      data['data'] = this.unpledgeData!.toJson();
    }
    return data;
  }
}

class UnpledgeData {
  Loan? loan;
  Unpledge? unpledge;
  List<CollateralLedger>? collateralLedger;
  RevokeChargeDetails? revokeChargeDetails;

  UnpledgeData({this.loan, this.unpledge,this.collateralLedger, this.revokeChargeDetails});

  UnpledgeData.fromJson(Map<String, dynamic> json) {
    loan = json['loan'] != null ? new Loan.fromJson(json['loan']) : null;
    unpledge = json['unpledge'] != null
        ? new Unpledge.fromJson(json['unpledge'])
        : null;
    if (json['collateral_ledger'] != null) {
      collateralLedger = <CollateralLedger>[];
      json['collateral_ledger'].forEach((v) {
        collateralLedger!.add(new CollateralLedger.fromJson(v));
      });
    }
    revokeChargeDetails = json['revoke_charge_details'] != null
        ? new RevokeChargeDetails.fromJson(json['revoke_charge_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    if (this.unpledge != null) {
      data['unpledge'] = this.unpledge!.toJson();
    }
    if (this.collateralLedger != null) {
      data['collateral_ledger'] =
          this.collateralLedger!.map((v) => v.toJson()).toList();
    }
    if (this.revokeChargeDetails != null) {
      data['revoke_charge_details'] = this.revokeChargeDetails!.toJson();
    }
    return data;
  }
}

class Loan {
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
  List<UnpledgeItems>? items;

  Loan(
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

  Loan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    totalCollateralValue = json['total_collateral_value'];
    existingtotalCollateralValue = json['existing_total_collateral_value'];
    totalCollateralValueStr = json['total_collateral_value_str'];
    drawingPower = json['drawing_power'];
    existingdrawingPower = json['existing_drawing_power'];
    actualDrawingPower = json['actual_drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    lender = json['lender'];
    sanctionedLimit = json['sanctioned_limit'];
    sanctionedLimitStr = json['sanctioned_limit_str'];
    balance = json['balance'];
    balanceStr = json['balance_str'];
    customer = json['customer'];
    customerName = json['customer_name'];
    allowableLtv = json['allowable_ltv'];
    expiryDate = json['expiry_date'];
    isEligibleForInterest = json['is_eligible_for_interest'];
    isIrregular = json['is_irregular'];
    isPenalize = json['is_penalize'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <UnpledgeItems>[];
      json['items'].forEach((v) {
        items!.add(new UnpledgeItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['existing_total_collateral_value'] = this.existingtotalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['drawing_power'] = this.drawingPower;
    data['existing_drawing_power'] = this.existingdrawingPower;
    data['actual_drawing_power'] = this.actualDrawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['lender'] = this.lender;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['sanctioned_limit_str'] = this.sanctionedLimitStr;
    data['balance'] = this.balance;
    data['balance_str'] = this.balanceStr;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['allowable_ltv'] = this.allowableLtv;
    data['expiry_date'] = this.expiryDate;
    data['is_eligible_for_interest'] = this.isEligibleForInterest;
    data['is_irregular'] = this.isIrregular;
    data['is_penalize'] = this.isPenalize;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnpledgeItems {
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

  UnpledgeItems(
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

  UnpledgeItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    isin = json['isin'];
    securityName = json['security_name'];
    securityCategory = json['security_category'];
    pledgedQuantity = json['pledged_quantity'];
    eligiblePercentage = json['eligible_percentage'];
    price = json['price'];
    amount = json['amount'];
    doctype = json['doctype'];
    folio = json['folio'];
    psn = json['psn'];
    remainingQty = json['remaining_qty'];
    qty = json['qty'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['isin'] = this.isin;
    data['security_name'] = this.securityName;
    data['security_category'] = this.securityCategory;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['doctype'] = this.doctype;
    data['folio'] = this.folio;
    data['psn'] = this.psn;
    data['remaining_qty'] = this.remainingQty;
    data['qty'] = this.qty;
    data['check'] = this.check;
    return data;
  }
}

class CollateralLedger {
  String? isin;
  String? psn;
  String? folio;
  double? requestedQuantity;

  CollateralLedger({this.isin, this.psn, this.folio, this.requestedQuantity});

  CollateralLedger.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    psn = json['psn'];
    folio = json['folio'];
    requestedQuantity = json['requested_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['psn'] = this.psn;
    data['folio'] = this.folio;
    data['requested_quantity'] = this.requestedQuantity;
    return data;
  }
}

class RevokeChargeDetails {
  String? revokeInitiateChargeType;
  double? revokeInitiateCharges;
  double? revokeInitiateChargesMinimumAmount;
  double? revokeInitiateChargesMaximumAmount;

  RevokeChargeDetails(
      {this.revokeInitiateChargeType,
        this.revokeInitiateCharges,
        this.revokeInitiateChargesMinimumAmount,
        this.revokeInitiateChargesMaximumAmount});

  RevokeChargeDetails.fromJson(Map<String, dynamic> json) {
    revokeInitiateChargeType = json['revoke_initiate_charge_type'];
    revokeInitiateCharges = json['revoke_initiate_charges'];
    revokeInitiateChargesMinimumAmount = json['revoke_initiate_charges_minimum_amount'];
    revokeInitiateChargesMaximumAmount = json['revoke_initiate_charges_maximum_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['revoke_initiate_charge_type'] = this.revokeInitiateChargeType;
    data['revoke_initiate_charges'] = this.revokeInitiateCharges;
    data['revoke_initiate_charges_minimum_amount'] = this.revokeInitiateChargesMinimumAmount;
    data['revoke_initiate_charges_maximum_amount'] = this.revokeInitiateChargesMaximumAmount;
    return data;
  }
}

class Unpledge {
  String? unpledgeMsgWhileMarginShortfall;
  UnpledgeValue? unpledgeValue;

  Unpledge({this.unpledgeMsgWhileMarginShortfall, this.unpledgeValue});

  Unpledge.fromJson(Map<String, dynamic> json) {
    unpledgeMsgWhileMarginShortfall =
    json['unpledge_msg_while_margin_shortfall'];
    unpledgeValue = json['unpledge'] != null
        ? new UnpledgeValue.fromJson(json['unpledge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unpledge_msg_while_margin_shortfall'] =
        this.unpledgeMsgWhileMarginShortfall;
    if (this.unpledgeValue != null) {
      data['unpledge'] = this.unpledgeValue!.toJson();
    }
    return data;
  }
}

class UnpledgeValue {
  double? minimumCollateralValue;
  double? maximumUnpledgeAmount;

  UnpledgeValue({this.minimumCollateralValue, this.maximumUnpledgeAmount});

  UnpledgeValue.fromJson(Map<String, dynamic> json) {
    minimumCollateralValue = json['minimum_collateral_value'];
    maximumUnpledgeAmount = json['maximum_unpledge_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum_collateral_value'] = this.minimumCollateralValue;
    data['maximum_unpledge_amount'] = this.maximumUnpledgeAmount;
    return data;
  }
}