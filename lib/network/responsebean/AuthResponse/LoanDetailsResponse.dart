import 'package:choice/network/ModelWrapper.dart';

class LoanDetailsResponse extends ModelWrapper<LoanDetailData> {
  String? message;
  LoanDetailData? data;

  LoanDetailsResponse({this.message, this.data});

  LoanDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new LoanDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoanDetailData {
  Loan? loan;
  List<Transactions>? transactions;
  MarginShortfall? marginShortfall;
  Interest? interest;
  // TopUp topUp;
  double? topUp;
  int? increaseLoan;
  String? increaseLoanName;
  int? topUpApplication;
  String? topUpApplicationName;
  InvokeChargeDetails? invokeChargeDetails;
  List<CollateralLedger>? collateralLedger;
  int? sellCollateral;
  int? isSellTriggered;
  int? paymentAlreadyInProcess;
  Unpledge? unpledge;
  String? pledgorBoid;
  int? loanRenewalIsExpired;

  LoanDetailData({this.loan, this.transactions, this.marginShortfall, this.interest, this.topUp,this.increaseLoan, this.increaseLoanName, this.collateralLedger, this.topUpApplication, this.topUpApplicationName,this.invokeChargeDetails, this.sellCollateral,this.isSellTriggered, this.unpledge,this.paymentAlreadyInProcess , this.pledgorBoid, this.loanRenewalIsExpired});

  LoanDetailData.fromJson(Map<String, dynamic> json) {
    loan = json['loan'] != null ? new Loan.fromJson(json['loan']) : null;
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    marginShortfall = json['margin_shortfall'] != null
        ? new MarginShortfall.fromJson(json['margin_shortfall'])
        : null;
    interest = json['interest'] != null ? new Interest.fromJson(json['interest']) : null;
    // topUp = json['topup'] != null ? new TopUp.fromJson(json['topup']) : null;
    topUp = json['topup'];
    increaseLoan = json['increase_loan'];
    increaseLoanName = json['increase_loan_name'];
    topUpApplication = json['topup_application'];
    topUpApplicationName = json['topup_application_name'];
    invokeChargeDetails = json['invoke_charge_details'] != null
        ? new InvokeChargeDetails.fromJson(json['invoke_charge_details'])
        : null;
    if (json['collateral_ledger'] != null) {
      collateralLedger = <CollateralLedger>[];
      json['collateral_ledger'].forEach((v) {
        collateralLedger!.add(new CollateralLedger.fromJson(v));
      });
    }
    sellCollateral = json['sell_collateral'];
    isSellTriggered = json['is_sell_triggered'];
    paymentAlreadyInProcess = json['payment_already_in_process'];
    unpledge = json['unpledge'] != null
        ? new Unpledge.fromJson(json['unpledge'])
        : null;
    pledgorBoid = json['pledgor_boid'];
    loanRenewalIsExpired = json['loan_renewal_is_expired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.marginShortfall != null) {
      data['margin_shortfall'] = this.marginShortfall!.toJson();
    }
    if (this.interest != null) {
      data['interest'] = this.interest!.toJson();
    }
    // if (this.topUp != null) {
    //   data['topup'] = this.topUp.toJson();
    // }
    data['topup'] = this.topUp;
    data['increase_loan'] = this.increaseLoan;
    data['increase_loan_name'] = this.increaseLoanName;
    data['topup_application'] = this.topUpApplication;
    data['topup_application_name'] = this.topUpApplicationName;
    if (this.invokeChargeDetails != null) {
      data['invoke_charge_details'] = this.invokeChargeDetails!.toJson();
    }
    if (this.collateralLedger != null) {
      data['collateral_ledger'] =
          this.collateralLedger!.map((v) => v.toJson()).toList();
    }
    data['sell_collateral'] = this.sellCollateral;
    data['is_sell_triggered'] = this.isSellTriggered;
    data['payment_already_in_process'] = this.paymentAlreadyInProcess;
    if (this.unpledge != null) {
      data['unpledge'] = this.unpledge!.toJson();
    }
    data['pledgor_boid'] = this.pledgorBoid;
    data['loan_renewal_is_expired'] = this.loanRenewalIsExpired;
    return data;
  }
}

class InvokeChargeDetails {
  String? invokeInitiateChargeType;
  double? invokeInitiateCharges;
  double? invokeInitiateChargesMinimumAmount;
  double? invokeInitiateChargesMaximumAmount;

  InvokeChargeDetails(
      {this.invokeInitiateChargeType,
        this.invokeInitiateCharges,
        this.invokeInitiateChargesMinimumAmount,
        this.invokeInitiateChargesMaximumAmount});

  InvokeChargeDetails.fromJson(Map<String, dynamic> json) {
    invokeInitiateChargeType = json['invoke_initiate_charge_type'];
    invokeInitiateCharges = json['invoke_initiate_charges'];
    invokeInitiateChargesMinimumAmount =
    json['invoke_initiate_charges_minimum_amount'];
    invokeInitiateChargesMaximumAmount =
    json['invoke_initiate_charges_maximum_amount'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoke_initiate_charge_type'] = this.invokeInitiateChargeType;
    data['invoke_initiate_charges'] = this.invokeInitiateCharges;
    data['invoke_initiate_charges_minimum_amount'] =
        this.invokeInitiateChargesMinimumAmount;
    data['invoke_initiate_charges_maximum_amount'] =
        this.invokeInitiateChargesMaximumAmount;
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

class Loan {
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
  List<Items>? items;
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

  Loan(
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

  Loan.fromJson(Map<String, dynamic> json) {
    allowableLtv = json['allowable_ltv'];
    balance = json['balance'];
    creation = json['creation'];
    customer = json['customer'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    drawingPower = json['drawing_power'];
    actualDrawingPower = json['actual_drawing_power'];
    expiryDate = json['expiry_date'];
    idx = json['idx'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    lender = json['lender'];
    loanAgreement = json['loan_agreement'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    instrumentType = json['instrument_type'];
    schemeType = json['scheme_type'];
    owner = json['owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    sanctionedLimit = json['sanctioned_limit'];
    totalCollateralValue = json['total_collateral_value'];
    totalCollateralValueStr = json['total_collateral_value_str'];
    drawingPowerStr = json['drawing_power_str'];
    sanctionedLimitStr = json['sanctioned_limit_str'];
    balanceStr = json['balance_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowable_ltv'] = this.allowableLtv;
    data['balance'] = this.balance;
    data['creation'] = this.creation;
    data['customer'] = this.customer;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['drawing_power'] = this.drawingPower;
    data['actual_drawing_power'] = this.actualDrawingPower;
    data['expiry_date'] = this.expiryDate;
    data['idx'] = this.idx;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['lender'] = this.lender;
    data['loan_agreement'] = this.loanAgreement;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['instrument_type'] = this.instrumentType;
    data['scheme_type'] = this.schemeType;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['sanctioned_limit_str'] = this.sanctionedLimitStr;
    data['balance_str'] = this.balanceStr;
    return data;
  }
}

class Items {
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

  Items(
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
        this.remaningQty });

  Items.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    creation = json['creation'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    errorCode = json['error_code'];
    idx = json['idx'];
    isin = json['isin'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    owner = json['owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    pledgedQuantity = json['pledged_quantity'];
    eligiblePercentage = json['eligible_percentage'];
    price = json['price'];
    psn = json['psn'];
    securityCategory = json['security_category'];
    securityName = json['security_name'];
    folio = json['folio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['creation'] = this.creation;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['error_code'] = this.errorCode;
    data['idx'] = this.idx;
    data['isin'] = this.isin;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['price'] = this.price;
    data['psn'] = this.psn;
    data['security_category'] = this.securityCategory;
    data['security_name'] = this.securityName;
    data['folio'] = this.folio;
    return data;
  }
}

class Transactions {
  String? transactionType;
  String? recordType;
  String? time;
  String? amount;

  Transactions({this.transactionType, this.recordType, this.time, this.amount});

  Transactions.fromJson(Map<String, dynamic> json) {
    transactionType = json['transaction_type'];
    recordType = json['record_type'];
    time = json['time'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_type'] = this.transactionType;
    data['record_type'] = this.recordType;
    data['time'] = this.time;
    data['amount'] = this.amount;
    return data;
  }
}

class MarginShortfall {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  Null parent;
  Null parentfield;
  Null parenttype;
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
  Null actionTime;
  Null nUserTags;
  Null nComments;
  Null nAssign;
  Null nLikedBy;
  int? isBankHoliday;
  String? deadline;
  String? actionTakenMsg;
  LinkedApplication? linkedApplication;
  String? deadlineInHrs;
  String? shortfallCStr;
  int? isTodayHoliday;

  MarginShortfall(
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
        this.actionTime,
        this.nUserTags,
        this.nComments,
        this.nAssign,
        this.nLikedBy,
        this.isBankHoliday,
        this.deadline,
        this.actionTakenMsg,
        this.linkedApplication,
        this.deadlineInHrs,
        this.shortfallCStr,
        this.isTodayHoliday});

  MarginShortfall.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    loan = json['loan'];
    totalCollateralValue = json['total_collateral_value'];
    allowableLtv = json['allowable_ltv'];
    drawingPower = json['drawing_power'];
    loanBalance = json['loan_balance'];
    minimumCollateralValue = json['minimum_collateral_value'];
    ltv = json['ltv'];
    surplusMargin = json['surplus_margin'];
    shortfall = json['shortfall'];
    shortfallC = json['shortfall_c'];
    minimumPledgeAmount = json['minimum_pledge_amount'];
    minimumCashAmount = json['minimum_cash_amount'];
    shortfallPercentage = json['shortfall_percentage'];
    marginShortfallAction = json['margin_shortfall_action'];
    advisablePledgeAmount = json['advisable_pledge_amount'];
    advisableCashAmount = json['advisable_cash_amount'];
    status = json['status'];
    actionTime = json['action_time'];
    nUserTags = json['_user_tags'];
    nComments = json['_comments'];
    nAssign = json['_assign'];
    nLikedBy = json['_liked_by'];
    isBankHoliday = json['is_bank_holiday'];
    deadline = json['deadline'];
    actionTakenMsg = json['action_taken_msg'];
    linkedApplication = json['linked_application'] != null
        ? new LinkedApplication.fromJson(json['linked_application'])
        : null;
    deadlineInHrs = json['deadline_in_hrs'];
    shortfallCStr = json['shortfall_c_str'];
    isTodayHoliday = json['is_today_holiday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['loan'] = this.loan;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['allowable_ltv'] = this.allowableLtv;
    data['drawing_power'] = this.drawingPower;
    data['loan_balance'] = this.loanBalance;
    data['minimum_collateral_value'] = this.minimumCollateralValue;
    data['ltv'] = this.ltv;
    data['surplus_margin'] = this.surplusMargin;
    data['shortfall'] = this.shortfall;
    data['shortfall_c'] = this.shortfallC;
    data['minimum_pledge_amount'] = this.minimumPledgeAmount;
    data['minimum_cash_amount'] = this.minimumCashAmount;
    data['shortfall_percentage'] = this.shortfallPercentage;
    data['margin_shortfall_action'] = this.marginShortfallAction;
    data['advisable_pledge_amount'] = this.advisablePledgeAmount;
    data['advisable_cash_amount'] = this.advisableCashAmount;
    data['status'] = this.status;
    data['action_time'] = this.actionTime;
    data['_user_tags'] = this.nUserTags;
    data['_comments'] = this.nComments;
    data['_assign'] = this.nAssign;
    data['_liked_by'] = this.nLikedBy;
    data['is_bank_holiday'] = this.isBankHoliday;
    data['deadline'] = this.deadline;
    data['action_taken_msg'] = this.actionTakenMsg;
    data['linked_application'] = this.linkedApplication;
    data['deadline_in_hrs'] = this.deadlineInHrs;
    data['shortfall_c_str'] = this.shortfallCStr;
    data['is_today_holiday'] = this.isTodayHoliday;
    return data;
  }
}

class LinkedApplication {
  LoanApplication? loanApplication;
  SellCollateralApplication? sellCollateralApplication;

  LinkedApplication({this.loanApplication, this.sellCollateralApplication});

  LinkedApplication.fromJson(Map<String, dynamic> json) {
    loanApplication = json['loan_application'] != null
        ? new LoanApplication.fromJson(
        json['loan_application'])
        : null;
    sellCollateralApplication = json['sell_collateral_application'] != null
        ? new SellCollateralApplication.fromJson(
        json['sell_collateral_application'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loanApplication != null) {
      data['loan_application'] =
          this.loanApplication!.toJson();
    }
    if (this.sellCollateralApplication != null) {
      data['sell_collateral_application'] =
          this.sellCollateralApplication!.toJson();
    }
    return data;
  }
}

class LoanApplication {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  Null parent;
  Null parentfield;
  Null parenttype;
  int? idx;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  String? status;
  Null customerEsignedDocument;
  double? pledgedTotalCollateralValue;
  String? pledgedTotalCollateralValueStr;
  String? loanMarginShortfall;
  String? customer;
  String? customerName;
  double? allowableLtv;
  String? expiryDate;
  String? loan;
  Null lenderEsignedDocument;
  String? pledgeStatus;
  Null nUserTags;
  Null nComments;
  Null nAssign;
  Null nLikedBy;
  String? workflowState;
  String? pledgorBoid;
  String? pledgeeBoid;

  LoanApplication(
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
        this.totalCollateralValue,
        this.totalCollateralValueStr,
        this.drawingPower,
        this.drawingPowerStr,
        this.lender,
        this.status,
        this.customerEsignedDocument,
        this.pledgedTotalCollateralValue,
        this.pledgedTotalCollateralValueStr,
        this.loanMarginShortfall,
        this.customer,
        this.customerName,
        this.allowableLtv,
        this.expiryDate,
        this.loan,
        this.lenderEsignedDocument,
        this.pledgeStatus,
        this.nUserTags,
        this.nComments,
        this.nAssign,
        this.nLikedBy,
        this.workflowState,
        this.pledgorBoid,
        this.pledgeeBoid});

  LoanApplication.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    totalCollateralValue = json['total_collateral_value'];
    totalCollateralValueStr = json['total_collateral_value_str'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    lender = json['lender'];
    status = json['status'];
    customerEsignedDocument = json['customer_esigned_document'];
    pledgedTotalCollateralValue = json['pledged_total_collateral_value'];
    pledgedTotalCollateralValueStr = json['pledged_total_collateral_value_str'];
    loanMarginShortfall = json['loan_margin_shortfall'];
    customer = json['customer'];
    customerName = json['customer_name'];
    allowableLtv = json['allowable_ltv'];
    expiryDate = json['expiry_date'];
    loan = json['loan'];
    lenderEsignedDocument = json['lender_esigned_document'];
    pledgeStatus = json['pledge_status'];
    nUserTags = json['_user_tags'];
    nComments = json['_comments'];
    nAssign = json['_assign'];
    nLikedBy = json['_liked_by'];
    workflowState = json['workflow_state'];
    pledgorBoid = json['pledgor_boid'];
    pledgeeBoid = json['pledgee_boid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['lender'] = this.lender;
    data['status'] = this.status;
    data['customer_esigned_document'] = this.customerEsignedDocument;
    data['pledged_total_collateral_value'] = this.pledgedTotalCollateralValue;
    data['pledged_total_collateral_value_str'] =
        this.pledgedTotalCollateralValueStr;
    data['loan_margin_shortfall'] = this.loanMarginShortfall;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['allowable_ltv'] = this.allowableLtv;
    data['expiry_date'] = this.expiryDate;
    data['loan'] = this.loan;
    data['lender_esigned_document'] = this.lenderEsignedDocument;
    data['pledge_status'] = this.pledgeStatus;
    data['_user_tags'] = this.nUserTags;
    data['_comments'] = this.nComments;
    data['_assign'] = this.nAssign;
    data['_liked_by'] = this.nLikedBy;
    data['workflow_state'] = this.workflowState;
    data['pledgor_boid'] = this.pledgorBoid;
    data['pledgee_boid'] = this.pledgeeBoid;
    return data;
  }
}

class SellCollateralApplication {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  Null parent;
  Null parentfield;
  Null parenttype;
  int? idx;
  String? loan;
  double? totalCollateralValue;
  String? lender;
  String? customer;
  double? sellingCollateralValue;
  Null amendedFrom;
  String? status;
  Null nUserTags;
  Null nComments;
  Null nAssign;
  Null nLikedBy;
  String? workflowState;
  String? loanMarginShortfall;

  SellCollateralApplication(
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
        this.loan,
        this.totalCollateralValue,
        this.lender,
        this.customer,
        this.sellingCollateralValue,
        this.amendedFrom,
        this.status,
        this.nUserTags,
        this.nComments,
        this.nAssign,
        this.nLikedBy,
        this.workflowState,
        this.loanMarginShortfall});

  SellCollateralApplication.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    loan = json['loan'];
    totalCollateralValue = json['total_collateral_value'];
    lender = json['lender'];
    customer = json['customer'];
    sellingCollateralValue = json['selling_collateral_value'];
    amendedFrom = json['amended_from'];
    status = json['status'];
    nUserTags = json['_user_tags'];
    nComments = json['_comments'];
    nAssign = json['_assign'];
    nLikedBy = json['_liked_by'];
    workflowState = json['workflow_state'];
    loanMarginShortfall = json['loan_margin_shortfall'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['loan'] = this.loan;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['lender'] = this.lender;
    data['customer'] = this.customer;
    data['selling_collateral_value'] = this.sellingCollateralValue;
    data['amended_from'] = this.amendedFrom;
    data['status'] = this.status;
    data['_user_tags'] = this.nUserTags;
    data['_comments'] = this.nComments;
    data['_assign'] = this.nAssign;
    data['_liked_by'] = this.nLikedBy;
    data['workflow_state'] = this.workflowState;
    data['loan_margin_shortfall'] = this.loanMarginShortfall;
    return data;
  }
}


class Interest {
  double? totalInterestAmt;
  String? dueDate;
  String? dueBtnTxt;
  String? infoMsg;
  int? dpdText;

  Interest({this.totalInterestAmt, this.dueDate, this.dueBtnTxt, this.infoMsg, this.dpdText});

  Interest.fromJson(Map<String, dynamic> json) {
    totalInterestAmt = json['total_interest_amt'];
    dueDate = json['due_date'];
    dueBtnTxt = json['due_date_txt'];
    infoMsg = json['info_msg'];
    dpdText = json['dpd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_interest_amt'] = this.totalInterestAmt;
    data['due_date'] = this.dueDate;
    data['due_btn_txt'] = this.dueBtnTxt;
    data['info_msg'] = this.infoMsg;
    data['dpd'] = this.dpdText;
    return data;
  }
}

class TopUp {
  double? topUpAmount;
  double? minimumTopUpAmount;

  TopUp({this.topUpAmount, this.minimumTopUpAmount});

  TopUp.fromJson(Map<String, dynamic> json) {
    topUpAmount = json['top_up_amount'];
    minimumTopUpAmount = json['minimum_top_up_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['top_up_amount'] = this.topUpAmount;
    data['minimum_top_up_amount'] = this.minimumTopUpAmount;
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