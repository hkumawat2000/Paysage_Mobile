import 'package:choice/network/ModelWrapper.dart';

class LoanSummaryResponseBean extends ModelWrapper<LoanSummaryData>{
  String? message;
  LoanSummaryData? loanSummaryData;

  LoanSummaryResponseBean({this.message, this.loanSummaryData});

  LoanSummaryResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    loanSummaryData = json['data'] != null ? new LoanSummaryData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.loanSummaryData != null) {
      data['data'] = this.loanSummaryData!.toJson();
    }
    return data;
  }
}

class LoanSummaryData {
  List<SellCollateralTopupAndUnpledgeList>? sellCollateralTopupAndUnpledgeList;
  List<ActionableLoan>? actionableLoan;
  List<UnderProcessLa>? underProcessLa;
  List<UnderProcessLoanRenewalApp>? underProcessLoanRenewalApp;
  List<ActiveLoans>? activeLoans;
  List<SellCollateralList>? sellCollateralList;
  List<UnpledgeList>? unpledgeList;
  List<TopupList>? topupList;
  List<IncreaseLoanList>? increaseLoanList;
  String? instrumentType;
  String? schemeType;
  VersionDetails? versionDetails;
  List<LoanRenewalApplication>? loanRenewalApplication;

  LoanSummaryData(
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

  LoanSummaryData.fromJson(Map<String, dynamic> json) {
    if (json['sell_collateral_topup_and_unpledge_list'] != null) {
      sellCollateralTopupAndUnpledgeList =
      <SellCollateralTopupAndUnpledgeList>[];
      json['sell_collateral_topup_and_unpledge_list'].forEach((v) {
        sellCollateralTopupAndUnpledgeList!
            .add(new SellCollateralTopupAndUnpledgeList.fromJson(v));
      });
    }
    if (json['actionable_loan'] != null) {
      actionableLoan = <ActionableLoan>[];
      json['actionable_loan'].forEach((v) {
        actionableLoan!.add(new ActionableLoan.fromJson(v));
      });
    }
    if (json['under_process_la'] != null) {
      underProcessLa = <UnderProcessLa>[];
      json['under_process_la'].forEach((v) {
        underProcessLa!.add(new UnderProcessLa.fromJson(v));
      });
    }
    if (json['under_process_loan_renewal_app'] != null) {
      underProcessLoanRenewalApp = <UnderProcessLoanRenewalApp>[];
      json['under_process_loan_renewal_app'].forEach((v) {
        underProcessLoanRenewalApp!
            .add(new UnderProcessLoanRenewalApp.fromJson(v));
      });
    }
    if (json['active_loans'] != null) {
      activeLoans = <ActiveLoans>[];
      json['active_loans'].forEach((v) {
        activeLoans!.add(new ActiveLoans.fromJson(v));
      });
    }
    if (json['sell_collateral_list'] != null) {
      sellCollateralList = <SellCollateralList>[];
      json['sell_collateral_list'].forEach((v) {
        sellCollateralList!.add(new SellCollateralList.fromJson(v));
      });
    }
    if (json['unpledge_list'] != null) {
      unpledgeList = <UnpledgeList>[];
      json['unpledge_list'].forEach((v) {
        unpledgeList!.add(new UnpledgeList.fromJson(v));
      });
    }
    if (json['topup_list'] != null) {
      topupList = <TopupList>[];
      json['topup_list'].forEach((v) {
        topupList!.add(new TopupList.fromJson(v));
      });
    }
    if (json['increase_loan_list'] != null) {
      increaseLoanList = <IncreaseLoanList>[];
      json['increase_loan_list'].forEach((v) {
        increaseLoanList!.add(new IncreaseLoanList.fromJson(v));
      });
    }
    instrumentType = json['instrument_type'];
    schemeType = json['scheme_type'];
    versionDetails = json['version_details'] != null
        ? new VersionDetails.fromJson(json['version_details'])
        : null;
    if (json['loan_renewal_application'] != null) {
      loanRenewalApplication = <LoanRenewalApplication>[];
      json['loan_renewal_application'].forEach((v) {
        loanRenewalApplication!.add(new LoanRenewalApplication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sellCollateralTopupAndUnpledgeList != null) {
      data['sell_collateral_topup_and_unpledge_list'] = this
          .sellCollateralTopupAndUnpledgeList!
          .map((v) => v.toJson())
          .toList();
    }
    if (this.actionableLoan != null) {
      data['actionable_loan'] =
          this.actionableLoan!.map((v) => v.toJson()).toList();
    }
    if (this.underProcessLa != null) {
      data['under_process_la'] =
          this.underProcessLa!.map((v) => v.toJson()).toList();
    }
    if (this.underProcessLoanRenewalApp != null) {
      data['under_process_loan_renewal_app'] =
          this.underProcessLoanRenewalApp!.map((v) => v.toJson()).toList();
    }
    if (this.activeLoans != null) {
      data['active_loans'] = this.activeLoans!.map((v) => v.toJson()).toList();
    }
    if (this.sellCollateralList != null) {
      data['sell_collateral_list'] =
          this.sellCollateralList!.map((v) => v.toJson()).toList();
    }
    if (this.unpledgeList != null) {
      data['unpledge_list'] = this.unpledgeList!.map((v) => v.toJson()).toList();
    }
    if (this.topupList != null) {
      data['topup_list'] = this.topupList!.map((v) => v.toJson()).toList();
    }
    if (this.increaseLoanList != null) {
      data['increase_loan_list'] =
          this.increaseLoanList!.map((v) => v.toJson()).toList();
    }
    data['instrument_type'] = this.instrumentType;
    data['scheme_type'] = this.schemeType;
    if (this.versionDetails != null) {
      data['version_details'] = this.versionDetails!.toJson();
    }
    if (this.loanRenewalApplication != null) {
      data['loan_renewal_application'] =
          this.loanRenewalApplication!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellCollateralTopupAndUnpledgeList {
  String? loanName;
  String? creation;
  UnpledgeApplicationAvailable? unpledgeApplicationAvailable;
  // Null unpledgeMsgWhileMarginShortfall;
  // Null unpledge;
  SellCollateralAvailable? sellCollateralAvailable;
  // int topUpAmount;
  ExistingTopupApplication? existingTopupApplication;

  SellCollateralTopupAndUnpledgeList(
      {this.loanName,
        this.creation,
        this.unpledgeApplicationAvailable,
        // this.unpledgeMsgWhileMarginShortfall,
        // this.unpledge,
        this.sellCollateralAvailable,
        // this.topUpAmount,
        this.existingTopupApplication});

  SellCollateralTopupAndUnpledgeList.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    creation = json['creation'];
    unpledgeApplicationAvailable =
    json['unpledge_application_available'] != null
        ? new UnpledgeApplicationAvailable.fromJson(
        json['unpledge_application_available'])
        : null;
    // unpledgeMsgWhileMarginShortfall =
    // json['unpledge_msg_while_margin_shortfall'];
    // unpledge = json['unpledge'];
    sellCollateralAvailable = json['sell_collateral_available'] != null
        ? new SellCollateralAvailable.fromJson(
        json['sell_collateral_available'])
        : null;
    // topUpAmount = json['top_up_amount'];
    existingTopupApplication = json['existing_topup_application'] != null
        ? new ExistingTopupApplication.fromJson(
        json['existing_topup_application'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['creation'] = this.creation;
    if (this.unpledgeApplicationAvailable != null) {
      data['unpledge_application_available'] =
          this.unpledgeApplicationAvailable!.toJson();
    }
    // data['unpledge_msg_while_margin_shortfall'] =
    //     this.unpledgeMsgWhileMarginShortfall;
    // data['unpledge'] = this.unpledge;
    if (this.sellCollateralAvailable != null) {
      data['sell_collateral_available'] = this.sellCollateralAvailable!.toJson();
    }
    // data['top_up_amount'] = this.topUpAmount;
    if (this.existingTopupApplication != null) {
      data['existing_topup_application'] =
          this.existingTopupApplication!.toJson();
    }
    return data;
  }
}

class UnpledgeApplicationAvailable {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  // Null parent;
  // Null parentfield;
  // Null parenttype;
  int? idx;
  String? loan;
  double? totalCollateralValue;
  String? lender;
  String? customer;
  double? unpledgeCollateralValue;
  // Null amendedFrom;
  String? status;
  String? workflowState;
  List<UnpledgeItems>? unpledgeItems;

  UnpledgeApplicationAvailable(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        // this.parent,
        // this.parentfield,
        // this.parenttype,
        this.idx,
        this.loan,
        this.totalCollateralValue,
        this.lender,
        this.customer,
        this.unpledgeCollateralValue,
        // this.amendedFrom,
        this.status,
        this.workflowState,
        this.unpledgeItems});

  UnpledgeApplicationAvailable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    // parent = json['parent'];
    // parentfield = json['parentfield'];
    // parenttype = json['parenttype'];
    idx = json['idx'];
    loan = json['loan'];
    totalCollateralValue = json['total_collateral_value'];
    lender = json['lender'];
    customer = json['customer'];
    unpledgeCollateralValue = json['unpledge_collateral_value'];
    // amendedFrom = json['amended_from'];
    status = json['status'];
    workflowState = json['workflow_state'];
    if (json['items'] != null) {
      unpledgeItems = <UnpledgeItems>[];
      json['items'].forEach((v) {
        unpledgeItems!.add(new UnpledgeItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    // data['parent'] = this.parent;
    // data['parentfield'] = this.parentfield;
    // data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['loan'] = this.loan;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['lender'] = this.lender;
    data['customer'] = this.customer;
    data['unpledge_collateral_value'] = this.unpledgeCollateralValue;
    // data['amended_from'] = this.amendedFrom;
    data['status'] = this.status;
    data['workflow_state'] = this.workflowState;
    if (this.unpledgeItems != null) {
      data['items'] = this.unpledgeItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnpledgeItems {
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

  UnpledgeItems(
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

  UnpledgeItems.fromJson(Map<String, dynamic> json) {
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
    isin = json['isin'];
    unpledgedQuantity = json['unpledged_quantity'];
    securityName = json['security_name'];
    folio = json['folio'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
    eligiblePercentage = json['eligible_percentage'];
    securityCategory = json['security_category'];
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
    data['isin'] = this.isin;
    data['unpledged_quantity'] = this.unpledgedQuantity;
    data['security_name'] = this.securityName;
    data['folio'] = this.folio;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['security_category'] = this.securityCategory;
    return data;
  }
}

class SellCollateralAvailable {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  // Null parent;
  // Null parentfield;
  // Null parenttype;
  int? idx;
  String? loan;
  double? totalCollateralValue;
  String? lender;
  String? customer;
  double? sellingCollateralValue;
  // Null amendedFrom;
  String? status;
  String? workflowState;
  String? loanMarginShortfall;
  List<SellItems>? sellItems;

  SellCollateralAvailable(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        // this.parent,
        // this.parentfield,
        // this.parenttype,
        this.idx,
        this.loan,
        this.totalCollateralValue,
        this.lender,
        this.customer,
        this.sellingCollateralValue,
        // this.amendedFrom,
        this.status,
        this.workflowState,
        this.loanMarginShortfall,
        this.sellItems});

  SellCollateralAvailable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    // parent = json['parent'];
    // parentfield = json['parentfield'];
    // parenttype = json['parenttype'];
    idx = json['idx'];
    loan = json['loan'];
    totalCollateralValue = json['total_collateral_value'];
    lender = json['lender'];
    customer = json['customer'];
    sellingCollateralValue = json['selling_collateral_value'];
    // amendedFrom = json['amended_from'];
    status = json['status'];
    workflowState = json['workflow_state'];
    loanMarginShortfall = json['loan_margin_shortfall'];
    if (json['items'] != null) {
      sellItems = <SellItems>[];
      json['items'].forEach((v) {
        sellItems!.add(new SellItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    // data['parent'] = this.parent;
    // data['parentfield'] = this.parentfield;
    // data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['loan'] = this.loan;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['lender'] = this.lender;
    data['customer'] = this.customer;
    data['selling_collateral_value'] = this.sellingCollateralValue;
    // data['amended_from'] = this.amendedFrom;
    data['status'] = this.status;
    data['workflow_state'] = this.workflowState;
    data['loan_margin_shortfall'] = this.loanMarginShortfall;
    if (this.sellItems != null) {
      data['items'] = this.sellItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellItems {
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

  SellItems(
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

  SellItems.fromJson(Map<String, dynamic> json) {
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
    isin = json['isin'];
    securityName = json['security_name'];
    folio = json['folio'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
    eligiblePercentage = json['eligible_percentage'];
    securityCategory = json['security_category'];
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
    data['isin'] = this.isin;
    data['security_name'] = this.securityName;
    data['folio'] = this.folio;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['security_category'] = this.securityCategory;
    return data;
  }
}

class ExistingTopupApplication {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  // Null parent;
  // Null parentfield;
  // Null parenttype;
  int? idx;
  String? loan;
  double? topUpAmount;
  String? time;
  String? status;
  String? customer;
  String? customerName;
  String? customerEsignedDocument;
  String? lenderEsignedDocument;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;
  String? workflowState;
  double? sanctionedLimit;
  // Null amendedFrom;

  ExistingTopupApplication(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        // this.parent,
        // this.parentfield,
        // this.parenttype,
        this.idx,
        this.loan,
        this.topUpAmount,
        this.time,
        this.status,
        this.customer,
        this.customerName,
        this.customerEsignedDocument,
        this.lenderEsignedDocument,
        // this.nUserTags,
        // this.nComments,
        // this.nAssign,
        // this.nLikedBy,
        this.workflowState,
        this.sanctionedLimit,
        // this.amendedFrom
      });

  ExistingTopupApplication.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    // parent = json['parent'];
    // parentfield = json['parentfield'];
    // parenttype = json['parenttype'];
    idx = json['idx'];
    loan = json['loan'];
    topUpAmount = json['top_up_amount'];
    time = json['time'];
    status = json['status'];
    customer = json['customer'];
    customerName = json['customer_name'];
    customerEsignedDocument = json['customer_esigned_document'];
    lenderEsignedDocument = json['lender_esigned_document'];
    // nUserTags = json['_user_tags'];
    // nComments = json['_comments'];
    // nAssign = json['_assign'];
    // nLikedBy = json['_liked_by'];
    workflowState = json['workflow_state'];
    sanctionedLimit = json['sanctioned_limit'];
    // amendedFrom = json['amended_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    // data['parent'] = this.parent;
    // data['parentfield'] = this.parentfield;
    // data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['loan'] = this.loan;
    data['top_up_amount'] = this.topUpAmount;
    data['time'] = this.time;
    data['status'] = this.status;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['customer_esigned_document'] = this.customerEsignedDocument;
    data['lender_esigned_document'] = this.lenderEsignedDocument;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    data['workflow_state'] = this.workflowState;
    data['sanctioned_limit'] = this.sanctionedLimit;
    // data['amended_from'] = this.amendedFrom;
    return data;
  }
}

class ActionableLoan {
  String? name;
  double? drawingPower;
  String? drawingPowerStr;
  double? balance;
  String? balanceStr;
  String? creation;

  ActionableLoan(
      {this.name,
        this.drawingPower,
        this.drawingPowerStr,
        this.balance,
        this.balanceStr,
        this.creation});

  ActionableLoan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    balance = json['balance'];
    balanceStr = json['balance_str'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['balance'] = this.balance;
    data['balance_str'] = this.balanceStr;
    data['creation'] = this.creation;
    return data;
  }
}

class UnderProcessLa {
  String? name;
  String? status;

  UnderProcessLa({this.name, this.status});

  UnderProcessLa.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    return data;
  }
}

class UnderProcessLoanRenewalApp {
  String? name;
  String? status;
  String? creation;

  UnderProcessLoanRenewalApp({this.name, this.status, this.creation});

  UnderProcessLoanRenewalApp.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['creation'] = this.creation;
    return data;
  }
}

class ActiveLoans {
  String? name;
  double? drawingPower;
  String? drawingPowerStr;
  double? balance;
  String? balanceStr;
  String? creation;

  ActiveLoans(
      {this.name,
        this.drawingPower,
        this.drawingPowerStr,
        this.balance,
        this.balanceStr,
        this.creation});

  ActiveLoans.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    balance = json['balance'];
    balanceStr = json['balance_str'];
    creation = json['creation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['balance'] = this.balance;
    data['balance_str'] = this.balanceStr;
    data['creation'] = this.creation;
    return data;
  }
}

class SellCollateralList {
  String? loanName;
  SellCollateralAvailable? sellCollateralAvailable;
  int? isSellTriggered;

  SellCollateralList({this.loanName, this.sellCollateralAvailable, this.isSellTriggered});

  SellCollateralList.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    isSellTriggered = json['is_sell_triggered'];
    sellCollateralAvailable = json['sell_collateral_available'] != null
        ? new SellCollateralAvailable.fromJson(
        json['sell_collateral_available'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['is_sell_triggered'] = this.isSellTriggered;
    if (this.sellCollateralAvailable != null) {
      data['sell_collateral_available'] = this.sellCollateralAvailable!.toJson();
    }
    return data;
  }
}

class UnpledgeList {
  String? loanName;
  UnpledgeApplicationAvailable? unpledgeApplicationAvailable;
  String? unpledgeMsgWhileMarginShortfall;
  Unpledge? unpledge;

  UnpledgeList(
      {this.loanName,
        this.unpledgeApplicationAvailable,
        this.unpledgeMsgWhileMarginShortfall,
        this.unpledge});

  UnpledgeList.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    unpledgeApplicationAvailable =
    json['unpledge_application_available'] != null
        ? new UnpledgeApplicationAvailable.fromJson(
        json['unpledge_application_available'])
        : null;
    unpledgeMsgWhileMarginShortfall =
    json['unpledge_msg_while_margin_shortfall'];
    unpledge = json['unpledge'] != null
        ? new Unpledge.fromJson(json['unpledge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    if (this.unpledgeApplicationAvailable != null) {
      data['unpledge_application_available'] =
          this.unpledgeApplicationAvailable!.toJson();
    }
    data['unpledge_msg_while_margin_shortfall'] =
        this.unpledgeMsgWhileMarginShortfall;
    if (this.unpledge != null) {
      data['unpledge'] = this.unpledge!.toJson();
    }
    return data;
  }
}

class Unpledge {
  double? minimumCollateralValue;
  double? maximumUnpledgeAmount;

  Unpledge({this.minimumCollateralValue, this.maximumUnpledgeAmount});

  Unpledge.fromJson(Map<String, dynamic> json) {
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

class TopupList {
  String? loanName;
  double? topUpAmount;

  TopupList({this.loanName, this.topUpAmount});

  TopupList.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    topUpAmount = json['top_up_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['top_up_amount'] = this.topUpAmount;
    return data;
  }
}

class IncreaseLoanList {
  String? loanName;
  int? increaseLoanAvailable;

  IncreaseLoanList({this.loanName, this.increaseLoanAvailable});

  IncreaseLoanList.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    increaseLoanAvailable = json['increase_loan_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['increase_loan_available'] = this.increaseLoanAvailable;
    return data;
  }
}

class LoanRenewalApplication {
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

  LoanRenewalApplication(
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

  LoanRenewalApplication.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    workflowState = json['workflow_state'];
    loan = json['loan'];
    lender = json['lender'];
    oldKycName = json['old_kyc_name'];
    updatedKycStatus = json['updated_kyc_status'];
    totalCollateralValue = json['total_collateral_value'];
    sanctionedLimit = json['sanctioned_limit'];
    loanBalance = json['loan_balance'];
    tncComplete = json['tnc_complete'];
    reminders = json['reminders'];
    status = json['status'];
    customer = json['customer'];
    customerName = json['customer_name'];
    drawingPower = json['drawing_power'];
    isExpired = json['is_expired'];
    timeRemaining = json['time_remaining'];
    actionStatus = json['action_status'];
    doctype = json['doctype'];
    tncShow = json['tnc_show'];
    expiryDate = json['expiry_date'];
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
    data['workflow_state'] = this.workflowState;
    data['loan'] = this.loan;
    data['lender'] = this.lender;
    data['old_kyc_name'] = this.oldKycName;
    data['updated_kyc_status'] = this.updatedKycStatus;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['loan_balance'] = this.loanBalance;
    data['tnc_complete'] = this.tncComplete;
    data['reminders'] = this.reminders;
    data['status'] = this.status;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['drawing_power'] = this.drawingPower;
    data['is_expired'] = this.isExpired;
    data['time_remaining'] = this.timeRemaining;
    data['action_status'] = this.actionStatus;
    data['doctype'] = this.doctype;
    data['tnc_show'] = this.tncShow;
    data['expiry_date'] = this.expiryDate;
    return data;
  }
}


class VersionDetails {
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

  VersionDetails({this.name,
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

  VersionDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    forceUpdate = json['force_update'];
    idx = json['idx'];
    androidVersion = json['android_version'];
    playStoreLink = json['play_store_link'];
    whatsNew = json['whats_new'];
    iosVersion = json['ios_version'];
    appStoreLink = json['app_store_link'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['force_update'] = this.forceUpdate;
    data['idx'] = this.idx;
    data['android_version'] = this.androidVersion;
    data['play_store_link'] = this.playStoreLink;
    data['whats_new'] = this.whatsNew;
    data['ios_version'] = this.iosVersion;
    data['app_store_link'] = this.appStoreLink;
    data['release_date'] = this.releaseDate;
    return data;
  }
}

